#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["pillow==13.0.0"]
# ///
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw

TOOL_DIR = Path(__file__).resolve().parent
ASPECT_TOLERANCE = 0.005
MASK_SUPERSAMPLING = 4


class ComposeError(RuntimeError):
    pass


def rounded_mask(size: tuple[int, int], radius: float) -> Image.Image:
    width, height = size
    scale = MASK_SUPERSAMPLING
    mask = Image.new("L", (width * scale, height * scale), 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        (0, 0, width * scale - 1, height * scale - 1), radius=radius * scale, fill=255
    )
    return mask.resize(size, Image.LANCZOS)


def box(rect: dict[str, float]) -> tuple[tuple[int, int], tuple[int, int]]:
    return (round(rect["x"]), round(rect["y"])), (round(rect["width"]), round(rect["height"]))


def place_screen(canvas: Image.Image, screenshot: Image.Image, device: dict) -> None:
    position, size = box(device["screenRect"])
    expected = device["screenRect"]["width"] / device["screenRect"]["height"]
    actual = screenshot.width / screenshot.height
    if abs(actual / expected - 1) > ASPECT_TOLERANCE:
        raise ComposeError(
            f"screenshot {screenshot.width}x{screenshot.height} does not match the device screen aspect ratio {expected:.4f}"
        )
    screen = screenshot.convert("RGBA").resize(size, Image.LANCZOS)
    screen.putalpha(ImageChops.multiply(screen.getchannel("A"), rounded_mask(size, device["screenCornerRadius"])))
    canvas.alpha_composite(screen, position)


def page_devices(page: dict) -> list[dict]:
    # devices は手で書いた配置で、Figma から抽出する device より優先する。後ろの要素ほど手前に描く。
    return page.get("devices") or [{**page["device"], "scene": page["scene"]}]


def compose_page(
    page: dict, canvas_size: tuple[int, int], screenshots: Path, layout_dir: Path, fixtures: Path
) -> Image.Image:
    background = Image.open(layout_dir / page["background"]).convert("RGBA")
    if background.size != canvas_size:
        raise ComposeError(f"{page['background']} is {background.size}, expected {canvas_size}")
    for device in page_devices(page):
        with Image.open(screenshots / f"{device['scene']}.png") as screenshot:
            place_screen(background, screenshot, device)
        position, size = box(device["bezelRect"])
        bezel = Image.open(fixtures / device["bezel"]).convert("RGBA").resize(size, Image.LANCZOS)
        background.alpha_composite(bezel, position)
    return background.convert("RGB")


def missing_inputs(page: dict, screenshots: Path, fixtures: Path) -> list[Path]:
    required = []
    for device in page_devices(page):
        required += [screenshots / f"{device['scene']}.png", fixtures / device["bezel"]]
    return [path for path in dict.fromkeys(required) if not path.is_file()]


def compose_all(
    layout_path: Path,
    screenshots: Path,
    fixtures: Path,
    output: Path,
    page_ids: set[str] | None,
    skip_missing: bool = False,
) -> list[Path]:
    layout = json.loads(layout_path.read_text())
    canvas_size = (layout["canvas"]["width"], layout["canvas"]["height"])
    pages = [page for page in layout["pages"] if page_ids is None or page["id"] in page_ids]
    if page_ids is not None and len(pages) != len(page_ids):
        unknown = page_ids - {page["id"] for page in pages}
        raise ComposeError(f"unknown page ids: {', '.join(sorted(unknown))}")
    missing = {page["id"]: missing_inputs(page, screenshots, fixtures) for page in pages}
    missing = {page_id: paths for page_id, paths in missing.items() if paths}
    for page_id, paths in missing.items():
        message = f"{page_id} is missing {', '.join(str(path) for path in paths)}"
        if not skip_missing:
            raise ComposeError(message)
        print(f"warning: skipped {message}", file=sys.stderr)
    output.mkdir(parents=True, exist_ok=True)
    written = []
    for page in (page for page in pages if page["id"] not in missing):
        image = compose_page(page, canvas_size, screenshots, layout_path.parent, fixtures)
        destination = output / f"{page['id']}.png"
        image.save(destination, optimize=True)
        written.append(destination)
    return written


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description="Compose App Store screenshots from captured scenes")
    parser.add_argument("--layout", type=Path, default=TOOL_DIR / "layout.json")
    parser.add_argument("--screenshots", type=Path, required=True, help="directory with <scene>.png captures")
    parser.add_argument("--fixtures", type=Path, required=True, help="directory with decrypted fixtures")
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--pages", help="comma separated page ids (default: all pages)")
    parser.add_argument("--skip-missing", action="store_true", help="skip pages without a screenshot or bezel")
    args = parser.parse_args(argv)

    page_ids = set(args.pages.split(",")) if args.pages else None
    for path in compose_all(
        args.layout, args.screenshots, args.fixtures, args.output, page_ids, args.skip_missing
    ):
        print(f"composed: {path}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except ComposeError as error:
        print(f"error: {error}", file=sys.stderr)
        sys.exit(1)
