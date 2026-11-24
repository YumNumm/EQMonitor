#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["pillow==13.0.0"]
# ///
from __future__ import annotations

import argparse
import json
from pathlib import Path

from PIL import Image, ImageDraw

# Pixel 11 Pro の公式の端末画像は Android Studio 2026.2 に無い（device-art-resources は Pixel 9 まで）。
# iPhone Duo の公式の画像は Apple Design Resources にあるが未取得。画面の寸法から黒い端末の枠を描く。
# 画面の部分は透明にし、カメラの穴だけ枠の側に描く。
SUPERSAMPLING = 2
BODY = (32, 32, 34, 255)
RIM = (70, 70, 74, 255)
BEZEL = (0, 0, 0, 255)


def rounded(draw: ImageDraw.ImageDraw, box: tuple[float, float, float, float], radius: float, fill) -> None:
    draw.rounded_rectangle(tuple(round(v * SUPERSAMPLING) for v in box), radius=round(radius * SUPERSAMPLING), fill=fill)


def generate(
    screen_width: int, screen_height: int, camera: bool, buttons: bool, bezel_ratio: float = 3.2, radius_ratio: float = 9
) -> tuple[Image.Image, dict]:
    unit = screen_width / 100
    bezel = bezel_ratio * unit
    body = 0.9 * unit
    button = 0.7 * unit if buttons else 0
    width = screen_width + 2 * (bezel + body) + button
    height = screen_height + 2 * (bezel + body)
    screen_x, screen_y = body + bezel, body + bezel
    screen_radius = radius_ratio * unit
    image = Image.new("RGBA", (round(width * SUPERSAMPLING), round(height * SUPERSAMPLING)), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    right = width - button
    for top, length in ((0.20, 0.07), (0.30, 0.13)) if buttons else ():
        rounded(draw, (right - unit, height * top, width, height * (top + length)), button, RIM)
    rounded(draw, (0, 0, right, height), screen_radius + bezel + body, RIM)
    rounded(draw, (0.25 * unit, 0.25 * unit, right - 0.25 * unit, height - 0.25 * unit), screen_radius + bezel + body, BODY)
    rounded(draw, (body, body, right - body, height - body), screen_radius + bezel, BEZEL)
    rounded(draw, (screen_x, screen_y, screen_x + screen_width, screen_y + screen_height), screen_radius, (0, 0, 0, 0))
    if camera:
        radius = 1.9 * unit
        center_x, center_y = screen_x + screen_width / 2, screen_y + 3.1 * unit
        draw.ellipse(
            tuple(round(v * SUPERSAMPLING) for v in (center_x - radius, center_y - radius, center_x + radius, center_y + radius)),
            fill=BEZEL,
        )
    size = (round(width), round(height))
    layout = {
        "frameSize": {"width": size[0], "height": size[1]},
        "screenRect": {"x": round(screen_x, 2), "y": round(screen_y, 2), "width": screen_width, "height": screen_height},
        "screenCornerRadius": round(screen_radius, 2),
    }
    return image.resize(size, Image.LANCZOS), layout


def main() -> None:
    parser = argparse.ArgumentParser(description="Draw a plain black phone frame around a screen size")
    parser.add_argument("--screen", default="1280x2856", help="screen size in pixels (Pixel 11 Pro: 1280x2856)")
    parser.add_argument("--no-camera", action="store_true", help="omit the punch-hole camera")
    parser.add_argument("--no-buttons", action="store_true", help="omit the side buttons")
    parser.add_argument("--bezel", type=float, default=3.2, help="bezel width in percent of the screen width")
    parser.add_argument("--radius", type=float, default=9, help="screen corner radius in percent of the screen width")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    screen_width, screen_height = (int(value) for value in args.screen.split("x"))
    image, layout = generate(screen_width, screen_height, not args.no_camera, not args.no_buttons, args.bezel, args.radius)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    image.save(args.output, optimize=True)
    print(json.dumps(layout))


if __name__ == "__main__":
    main()
