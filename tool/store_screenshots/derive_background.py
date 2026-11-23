#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# dependencies = ["numpy==2.3.4", "pillow==13.0.0"]
# ///
from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
from PIL import Image

# Figma のデザインは iPhone の縦長の画面向けしか無い。iPhone Duo などの別の縦横比には、
# 既存の背景からグラデーションを推定し、白い見出しとロゴだけを抜き出して置き直す。
TEXT_THRESHOLD = 12


def fit_gradient(pixels: np.ndarray) -> np.ndarray:
    height, width, _ = pixels.shape
    ys, xs = np.mgrid[0:height, 0:width]
    u, v = (xs + 0.5) / width, (ys + 0.5) / height
    basis = np.stack([np.ones_like(u), u, v], axis=-1).reshape(-1, 3)
    values = pixels.reshape(-1, 3)
    mask = np.ones(len(values), dtype=bool)
    for _ in range(3):
        coefficients, *_ = np.linalg.lstsq(basis[mask], values[mask], rcond=None)
        residual = np.abs(values - basis @ coefficients).max(axis=1)
        mask = residual < TEXT_THRESHOLD
    return coefficients


def render_gradient(coefficients: np.ndarray, width: int, height: int) -> np.ndarray:
    ys, xs = np.mgrid[0:height, 0:width]
    basis = np.stack([np.ones((height, width)), (xs + 0.5) / width, (ys + 0.5) / height], axis=-1)
    return np.clip(basis @ coefficients, 0, 255)


def extract_text(pixels: np.ndarray, gradient: np.ndarray) -> tuple[Image.Image, int]:
    # 見出しとロゴは白一色。各画素の白の割合を (画素 - 地) / (白 - 地) で求める。
    alpha = ((pixels - gradient) / np.maximum(255 - gradient, 1)).max(axis=-1)
    alpha = np.clip(alpha, 0, 1)
    alpha[alpha < 0.02] = 0
    layer = np.zeros((*alpha.shape, 4), dtype=np.uint8)
    layer[..., :3] = 255
    layer[..., 3] = np.round(alpha * 255).astype(np.uint8)
    image = Image.fromarray(layer, "RGBA")
    box = image.getbbox()
    return image.crop(box), box[1]


def derive(source: Path, width: int, height: int, text_scale: float) -> Image.Image:
    pixels = np.asarray(Image.open(source).convert("RGB"), dtype=np.float64)
    coefficients = fit_gradient(pixels)
    text, top = extract_text(pixels, render_gradient(coefficients, pixels.shape[1], pixels.shape[0]))
    background = Image.fromarray(render_gradient(coefficients, width, height).round().astype(np.uint8), "RGB").convert("RGBA")
    # 元の幅に対する比率を保ち、見出しの大きさと上端の余白を揃える。
    scale = width / pixels.shape[1] * text_scale
    text = text.resize((round(text.width * scale), round(text.height * scale)), Image.LANCZOS)
    background.alpha_composite(text, (round((width - text.width) / 2), round(top * scale)))
    return background.convert("RGB")


def main() -> None:
    parser = argparse.ArgumentParser(description="Re-lay an existing store background out for another canvas size")
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--size", required=True, help="canvas size, e.g. 2007x2853")
    parser.add_argument("--text-scale", type=float, default=1.0, help="extra scale for the heading, relative to the width ratio")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    width, height = (int(value) for value in args.size.split("x"))
    args.output.parent.mkdir(parents=True, exist_ok=True)
    derive(args.source, width, height, args.text_scale).save(args.output, optimize=True)
    print(f"derived: {args.output}")


if __name__ == "__main__":
    main()
