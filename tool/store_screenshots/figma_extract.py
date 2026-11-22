#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["numpy==2.5.5", "pillow==13.0.0"]
# ///
from __future__ import annotations

import argparse
import io
import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

import numpy as np
from PIL import Image

API = "https://api.figma.com/v1"
TOOL_DIR = Path(__file__).resolve().parent


class FigmaError(RuntimeError):
    pass


class FigmaClient:
    def __init__(self, file_key: str, token: str | None) -> None:
        self.file_key = file_key
        self.token = token

    def get_json(self, path: str, params: dict[str, str]) -> dict:
        url = f"{API}{path}?{urllib.parse.urlencode(params)}"
        request = urllib.request.Request(url)
        if self.token:
            request.add_header("X-Figma-Token", self.token)
        try:
            with urllib.request.urlopen(request, timeout=120) as response:
                body = json.load(response)
        except urllib.error.HTTPError as error:
            raise FigmaError(
                f"{url} returned HTTP {error.code}. Set FIGMA_TOKEN to a token that can read the file."
            ) from error
        if body.get("err"):
            raise FigmaError(f"{url}: {body['err']}")
        return body

    def nodes(self, node_ids: list[str]) -> dict[str, dict]:
        body = self.get_json(f"/files/{self.file_key}/nodes", {"ids": ",".join(node_ids)})
        return {node_id: entry["document"] for node_id, entry in body["nodes"].items()}

    def render(self, node_ids: list[str], scale: float) -> dict[str, Image.Image]:
        body = self.get_json(
            f"/images/{self.file_key}",
            {"ids": ",".join(node_ids), "scale": repr(scale), "format": "png"},
        )
        return {node_id: download_image(url) for node_id, url in body["images"].items()}

    def image_fill_urls(self) -> dict[str, str]:
        return self.get_json(f"/files/{self.file_key}/images", {})["meta"]["images"]


def download_image(url: str) -> Image.Image:
    with urllib.request.urlopen(url, timeout=120) as response:
        return Image.open(io.BytesIO(response.read())).convert("RGBA")


def linear_gradient(fill: dict, width: int, height: int) -> Image.Image:
    handles = fill["gradientHandlePositions"]
    start = np.array([handles[0]["x"], handles[0]["y"]])
    end = np.array([handles[1]["x"], handles[1]["y"]])
    axis = end - start
    ys, xs = np.mgrid[0:height, 0:width]
    t = ((xs + 0.5) / width - start[0]) * axis[0] + ((ys + 0.5) / height - start[1]) * axis[1]
    t = np.clip(t / (axis @ axis), 0, 1)
    positions = np.array([stop["position"] for stop in fill["gradientStops"]])
    channels = [
        np.interp(t, positions, np.array([stop["color"][c] for stop in fill["gradientStops"]]))
        for c in "rgb"
    ]
    pixels = np.round(np.stack(channels, axis=-1) * 255).astype(np.uint8)
    return Image.fromarray(pixels, "RGB").convert("RGBA")


def frame_background(frame: dict, width: int, height: int) -> Image.Image:
    fills = [fill for fill in frame.get("fills", []) if fill.get("visible", True)]
    if len(fills) != 1:
        raise FigmaError(f"{frame['id']}: expected exactly one visible fill, got {len(fills)}")
    fill = fills[0]
    if fill["type"] == "GRADIENT_LINEAR":
        return linear_gradient(fill, width, height)
    if fill["type"] == "SOLID":
        color = tuple(round(fill["color"][c] * 255) for c in "rgb")
        return Image.new("RGBA", (width, height), color)
    raise FigmaError(f"{frame['id']}: unsupported background fill {fill['type']}")


def image_fill(node: dict) -> dict | None:
    return next((fill for fill in node.get("fills", []) if fill["type"] == "IMAGE"), None)


def is_device(node: dict) -> bool:
    return (
        node["type"] == "INSTANCE"
        and image_fill(node) is not None
        and any(image_fill(child) is not None for child in node.get("children", []))
    )


def slug(name: str) -> str:
    return re.sub(r"[^a-z0-9]+", "_", name.lower()).strip("_")


def rect(box: dict, origin: dict, scale: float) -> dict[str, float]:
    return {
        "x": round((box["x"] - origin["x"]) * scale, 2),
        "y": round((box["y"] - origin["y"]) * scale, 2),
        "width": round(box["width"] * scale, 2),
        "height": round(box["height"] * scale, 2),
    }


def device_layout(device: dict, origin: dict, scale: float) -> tuple[dict, str, str]:
    bezel = next(child for child in device["children"] if image_fill(child) is not None)
    bezel_fill = image_fill(bezel)
    if image_fill(device)["scaleMode"] != "FIT" or bezel_fill["scaleMode"] != "FILL":
        raise FigmaError(f"{device['id']}: unexpected image scale modes")
    bezel_name = f"bezel_{slug(bezel['name'])}.png"
    layout = {
        "bezel": bezel_name,
        "bezelRect": rect(bezel["absoluteBoundingBox"], origin, scale),
        "screenRect": rect(device["absoluteBoundingBox"], origin, scale),
        "screenCornerRadius": round(device.get("cornerRadius", 0) * scale, 2),
    }
    return layout, bezel_name, bezel_fill["imageRef"]


def extract_page(client: FigmaClient, page: dict, frame: dict, canvas: dict) -> tuple[dict, dict[str, str]]:
    origin = frame["absoluteBoundingBox"]
    scale = canvas["width"] / origin["width"]
    if abs(origin["height"] * scale - canvas["height"]) > 1:
        raise FigmaError(f"{frame['id']}: frame aspect ratio does not match the canvas")
    devices = [child for child in frame["children"] if is_device(child)]
    if len(devices) != 1:
        raise FigmaError(f"{frame['id']}: expected one device instance, got {len(devices)}")
    layers = [child for child in frame["children"] if not is_device(child) and child.get("visible", True)]
    background = frame_background(frame, canvas["width"], canvas["height"])
    rendered = client.render([layer["id"] for layer in layers], scale)
    for layer in layers:
        bounds = layer["absoluteRenderBounds"]
        position = (round((bounds["x"] - origin["x"]) * scale), round((bounds["y"] - origin["y"]) * scale))
        background.alpha_composite(rendered[layer["id"]], position)
    destination = TOOL_DIR / page["background"]
    destination.parent.mkdir(parents=True, exist_ok=True)
    background.convert("RGB").save(destination, optimize=True)
    device, bezel_name, bezel_ref = device_layout(devices[0], origin, scale)
    return {**page, "device": device}, {bezel_name: bezel_ref}


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description="Extract store screenshot backgrounds and device frames from Figma")
    parser.add_argument("--layout", type=Path, default=TOOL_DIR / "layout.json")
    parser.add_argument("--bezel-out", type=Path, required=True)
    args = parser.parse_args(argv)

    layout = json.loads(args.layout.read_text())
    client = FigmaClient(layout["figmaFile"], os.environ.get("FIGMA_TOKEN"))
    frames = client.nodes([page["figmaNodeId"] for page in layout["pages"]])
    pages = []
    bezels: dict[str, str] = {}
    for page in layout["pages"]:
        extracted, page_bezels = extract_page(client, page, frames[page["figmaNodeId"]], layout["canvas"])
        pages.append(extracted)
        bezels.update(page_bezels)

    fill_urls = client.image_fill_urls()
    args.bezel_out.mkdir(parents=True, exist_ok=True)
    for name, image_ref in bezels.items():
        download_image(fill_urls[image_ref]).save(args.bezel_out / name)
        print(f"bezel: {args.bezel_out / name}")

    args.layout.write_text(json.dumps({**layout, "pages": pages}, ensure_ascii=False, indent=2) + "\n")
    print(f"updated {args.layout}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except FigmaError as error:
        print(f"error: {error}", file=sys.stderr)
        sys.exit(1)
