#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["numpy==2.3.4", "pillow==13.0.0"]
# ///
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

import numpy as np
from PIL import Image

sys.path.insert(0, str(Path(__file__).resolve().parent))
from compose import place_screen  # noqa: E402
from derive_background import extract_text, fit_gradient, render_gradient  # noqa: E402

TOOL_DIR = Path(__file__).resolve().parent

# App Store の「ヘッダと検索結果」の画像。寸法と、見せたいものを収める領域（art safe area）は
# https://developer.apple.com/help/app-store-connect/reference/app-information/creative-assets-specifications （2026-11-24 確認）。
# 見出しは safe area に、端末は外側の領域に置く。外側は端末の画面の向きによって切れる。
PLACEMENTS = {
    "header": {"size": (3840, 1646), "safe": (1097, 493, 1646, 661)},
    "search_results": {"size": (3840, 2560), "safe": (836, 765, 2168, 1030)},
    "universal": {"size": (5244, 2950), "safe": (1921, 660, 1402, 962)},
}

IPHONE = {
    "bezel": "bezel_iphone_18_pro_black_portrait.png",
    "frame": (1041.04, 2128.36),
    "screen": (54.96, 53.29, 930.0, 2021.94),
    "radius": 130.0,
}
WATCH = {
    "bezel": "bezel_apple_watch_ultra_4_black_ocean_band_translucent_black.png",
    "frame": (620.0, 940.0),
    "screen": (99.0, 213.0, 422.0, 514.0),
    "radius": 100.0,
}


def device_box(spec: dict, x: float, y: float, height: float) -> dict:
    k = height / spec["frame"][1]
    sx, sy, sw, sh = spec["screen"]
    return {
        "bezel": spec["bezel"],
        "bezelRect": {"x": x, "y": y, "width": spec["frame"][0] * k, "height": height},
        "screenRect": {"x": x + sx * k, "y": y + sy * k, "width": sw * k, "height": sh * k},
        "screenCornerRadius": spec["radius"] * k,
    }


def draw_device(canvas: Image.Image, box: dict, screenshot: Path, fixtures: Path) -> None:
    with Image.open(screenshot) as image:
        place_screen(canvas, image, box)
    rect = box["bezelRect"]
    size = (round(rect["width"]), round(rect["height"]))
    bezel = Image.open(fixtures / box["bezel"]).convert("RGBA").resize(size, Image.LANCZOS)
    canvas.alpha_composite(bezel, (round(rect["x"]), round(rect["y"])))


def render(placement: str, screenshots: Path, fixtures: Path, source: Path) -> Image.Image:
    width, height = PLACEMENTS[placement]["size"]
    safe_x, safe_y, safe_w, safe_h = PLACEMENTS[placement]["safe"]
    pixels = np.asarray(Image.open(source).convert("RGB"), dtype=np.float64)
    coefficients = fit_gradient(pixels)
    text, _ = extract_text(pixels, render_gradient(coefficients, pixels.shape[1], pixels.shape[0]))
    canvas = Image.fromarray(render_gradient(coefficients, width, height).round().astype(np.uint8), "RGB").convert("RGBA")

    # 見出しは safe area の 9 割に収め、中央に置く。
    scale = min(safe_w * 0.9 / text.width, safe_h * 0.9 / text.height)
    text = text.resize((round(text.width * scale), round(text.height * scale)), Image.LANCZOS)
    canvas.alpha_composite(text, (round(safe_x + (safe_w - text.width) / 2), round(safe_y + (safe_h - text.height) / 2)))

    # 端末は safe area の左右に置く。左に EEW、右に強震モニタ、右下の手前に Apple Watch。
    phone_height = min(height * 0.86, (safe_x * 0.86) / IPHONE["frame"][0] * IPHONE["frame"][1])
    phone_width = IPHONE["frame"][0] * phone_height / IPHONE["frame"][1]
    top = (height - phone_height) / 2
    left = device_box(IPHONE, (safe_x - phone_width) / 2, top, phone_height)
    right_x = safe_x + safe_w + (width - safe_x - safe_w - phone_width) / 2
    right = device_box(IPHONE, right_x, top, phone_height)
    watch_height = phone_height * 0.42
    watch_width = WATCH["frame"][0] * watch_height / WATCH["frame"][1]
    # 外側の領域が狭いと Watch が右端からはみ出すため、キャンバスに収める。
    watch_x = min(right_x + phone_width * 0.62, width * 0.985 - watch_width)
    watch = device_box(WATCH, watch_x, top + phone_height - watch_height * 0.92, watch_height)
    draw_device(canvas, left, screenshots / "eew_warning.png", fixtures)
    draw_device(canvas, right, screenshots / "kyoshin_monitor.png", fixtures)
    if (screenshots / "watch_live_activity.png").is_file():
        draw_device(canvas, watch, screenshots / "watch_live_activity.png", fixtures)
    return canvas.convert("RGB")


def main() -> None:
    parser = argparse.ArgumentParser(description="Render the App Store product page header and search results images")
    parser.add_argument("--screenshots", type=Path, required=True, help="directory with eew_warning / kyoshin_monitor / watch_live_activity captures")
    parser.add_argument("--fixtures", type=Path, required=True, help="directory with decrypted fixtures (device frames)")
    parser.add_argument("--background", type=Path, default=TOOL_DIR / "backgrounds" / "01_eew.png", help="background with the logo and tagline")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    for placement in PLACEMENTS:
        destination = args.output / f"{placement}.png"
        render(placement, args.screenshots, args.fixtures, args.background).save(destination, optimize=True)
        print(json.dumps({"placement": placement, "path": str(destination), "size": PLACEMENTS[placement]["size"]}))


if __name__ == "__main__":
    main()
