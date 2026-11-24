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
from derive_background import extract_text, fit_gradient, render_gradient, text_left  # noqa: E402

TOOL_DIR = Path(__file__).resolve().parent

# App Store の「ヘッダと検索結果」の画像。寸法と、見せたいものを収める領域（art safe area）は
# https://developer.apple.com/help/app-store-connect/reference/app-information/creative-assets-specifications （2026-11-24 確認）。
# 左右に奥と手前の iPhone を 2 台ずつ重ね、奥は上、手前は下に寄せる。端末と見出しは safe area より大きく、
# 画面の向きによっては端が切れる。検索結果の見出しは safe area の外（手前の端末より上）に置いている。
# phone は手前の端末の高さ（キャンバスの高さに対する比）、back は奥の端末の手前に対する比、
# overlap は奥の端末が手前に隠れる幅の比、watch は Apple Watch の手前の端末に対する比。
PLACEMENTS = {
    "header": {
        "size": (3840, 1646), "safe": (1097, 493, 1646, 661),
        "phone": 0.84, "back": 0.9, "overlap": 0.45, "watch": 0.38, "text": "center", "text_height": 0.62,
    },
    "search_results": {
        "size": (3840, 2560), "safe": (836, 765, 2168, 1030),
        "phone": 0.72, "back": 0.9, "overlap": 0.5, "watch": 0.42, "text": "top",
    },
}
MARGIN = 0.02
EDGE = 0.025

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


def layout(placement: str, text_box: tuple[int, int, int, int], source_width: int) -> tuple[dict, list[dict]]:
    spec = PLACEMENTS[placement]
    width, height = spec["size"]
    margin = width * MARGIN
    edge = height * EDGE
    front_height = height * spec["phone"]
    front_width = IPHONE["frame"][0] * front_height / IPHONE["frame"][1]
    back_height = front_height * spec["back"]
    back_width = IPHONE["frame"][0] * back_height / IPHONE["frame"][1]
    front_top = height - edge - front_height
    back_right = width - margin - back_width
    front_left = margin + back_width * (1 - spec["overlap"])
    front_right = back_right + back_width * spec["overlap"] - front_width
    watch_height = front_height * spec["watch"]
    watch_width = WATCH["frame"][0] * watch_height / WATCH["frame"][1]
    devices = [
        {**device_box(IPHONE, margin, edge, back_height), "scene": "earthquake_detail"},
        {**device_box(IPHONE, back_right, edge, back_height), "scene": "kyoshin_monitor"},
        {**device_box(IPHONE, front_left, front_top, front_height), "scene": "eew_warning"},
        {**device_box(IPHONE, front_right, front_top, front_height), "scene": "lock_screen_live_activity"},
        {
            **device_box(WATCH, width * 0.995 - watch_width, front_top + front_height - watch_height * 0.92, watch_height),
            "scene": "watch_live_activity",
        },
    ]

    text_width, text_height = text_box[2] - text_box[0], text_box[3] - text_box[1]
    if spec["text"] == "top":
        top, bottom = edge, front_top - edge / 2
        available = back_right - (margin + back_width) - 2 * margin
        scale = min(available * 0.92 / text_width, (bottom - top) / text_height)
        y = (top + bottom) / 2 - text_height * scale / 2
    else:
        _, safe_y, _, safe_h = spec["safe"]
        available = front_right - (front_left + front_width) - 2 * margin
        scale = min(available * 0.92 / text_width, height * spec["text_height"] / text_height)
        y = safe_y + safe_h / 2 - text_height * scale / 2
    return {"x": text_left(text_box, source_width, scale, width), "y": y, "scale": scale}, devices


def render(placement: str, screenshots: Path, fixtures: Path, source: Path) -> Image.Image:
    width, height = PLACEMENTS[placement]["size"]
    pixels = np.asarray(Image.open(source).convert("RGB"), dtype=np.float64)
    coefficients = fit_gradient(pixels)
    text, box = extract_text(pixels, render_gradient(coefficients, pixels.shape[1], pixels.shape[0]))
    canvas = Image.fromarray(render_gradient(coefficients, width, height).round().astype(np.uint8), "RGB").convert("RGBA")

    placed, devices = layout(placement, box, pixels.shape[1])
    scale = placed["scale"]
    text = text.resize((round(text.width * scale), round(text.height * scale)), Image.LANCZOS)
    canvas.alpha_composite(text, (round(placed["x"]), round(placed["y"])))
    for device in devices:
        screenshot = screenshots / f"{device['scene']}.png"
        if device["scene"] == "watch_live_activity" and not screenshot.is_file():
            continue
        draw_device(canvas, device, screenshot, fixtures)
    return canvas.convert("RGB")


def main() -> None:
    parser = argparse.ArgumentParser(description="Render the App Store product page header and search results images")
    parser.add_argument("--screenshots", type=Path, required=True, help="directory with eew_warning / kyoshin_monitor / earthquake_detail / lock_screen_live_activity "
        "(and optionally watch_live_activity) captures")
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
