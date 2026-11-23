#!/usr/bin/env python3
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from PIL import Image, ImageDraw

from tool.store_screenshots.compose import ComposeError, compose_all

BACKGROUND = (10, 20, 30)
SCREEN = (200, 100, 50)
BEZEL = (90, 90, 90)


class ComposeTest(unittest.TestCase):
    def setUp(self) -> None:
        self.directory = tempfile.TemporaryDirectory()
        self.root = Path(self.directory.name)
        (self.root / "screens").mkdir()
        (self.root / "fixtures").mkdir()
        Image.new("RGB", (200, 400), BACKGROUND).save(self.root / "background.png")
        bezel = Image.new("RGBA", (120, 240), BEZEL + (255,))
        ImageDraw.Draw(bezel).rectangle((10, 10, 109, 229), fill=(0, 0, 0, 0))
        bezel.save(self.root / "fixtures" / "bezel.png")
        self.layout = self.root / "layout.json"
        self.layout.write_text(
            json.dumps(
                {
                    "canvas": {"width": 200, "height": 400},
                    "pages": [
                        {
                            "id": "01_eew",
                            "scene": "eew_warning",
                            "background": "background.png",
                            "device": {
                                "bezel": "bezel.png",
                                "bezelRect": {"x": 40.4, "y": 80, "width": 120, "height": 240},
                                "screenRect": {"x": 50, "y": 90, "width": 100, "height": 220},
                                "screenCornerRadius": 20,
                            },
                        }
                    ],
                }
            )
        )

    def tearDown(self) -> None:
        self.directory.cleanup()

    def compose(self, page_ids: set[str] | None = None, skip_missing: bool = False) -> list[Path]:
        return compose_all(
            self.layout, self.root / "screens", self.root / "fixtures", self.root / "out", page_ids, skip_missing
        )

    def test_places_rounded_screen_under_bezel(self) -> None:
        Image.new("RGB", (500, 1100), SCREEN).save(self.root / "screens" / "eew_warning.png")
        [path] = self.compose()
        image = Image.open(path)
        self.assertEqual(image.mode, "RGB")
        self.assertEqual(image.size, (200, 400))
        self.assertEqual(image.getpixel((100, 200)), SCREEN)
        self.assertEqual(image.getpixel((51, 91)), BACKGROUND)
        self.assertEqual(image.getpixel((45, 200)), BEZEL)
        self.assertEqual(image.getpixel((5, 5)), BACKGROUND)

    def test_rejects_screenshot_from_another_device_shape(self) -> None:
        Image.new("RGB", (500, 1000), SCREEN).save(self.root / "screens" / "eew_warning.png")
        with self.assertRaisesRegex(ComposeError, "aspect ratio"):
            self.compose()

    def test_reports_missing_screenshot(self) -> None:
        with self.assertRaisesRegex(ComposeError, "01_eew is missing .*eew_warning.png"):
            self.compose()

    def test_reports_missing_bezel_fixture(self) -> None:
        Image.new("RGB", (500, 1100), SCREEN).save(self.root / "screens" / "eew_warning.png")
        (self.root / "fixtures" / "bezel.png").unlink()
        with self.assertRaisesRegex(ComposeError, "01_eew is missing .*bezel.png"):
            self.compose()

    def test_skip_missing_composes_nothing_without_inputs(self) -> None:
        self.assertEqual(self.compose(skip_missing=True), [])

    def test_draws_later_devices_in_front(self) -> None:
        layout = json.loads(self.layout.read_text())
        device = layout["pages"][0]["device"]
        front = {
            **device,
            "scene": "front",
            "bezelRect": {**device["bezelRect"], "x": 60.4, "y": 120},
            "screenRect": {**device["screenRect"], "x": 70, "y": 130},
        }
        layout["pages"][0]["devices"] = [{**device, "scene": "back"}, front]
        self.layout.write_text(json.dumps(layout))
        Image.new("RGB", (500, 1100), SCREEN).save(self.root / "screens" / "back.png")
        Image.new("RGB", (500, 1100), (0, 0, 255)).save(self.root / "screens" / "front.png")
        [path] = self.compose()
        image = Image.open(path)
        self.assertEqual(image.getpixel((60, 110)), SCREEN)
        self.assertEqual(image.getpixel((120, 250)), (0, 0, 255))
        self.assertEqual(image.getpixel((65, 250)), BEZEL)

    def test_rejects_unknown_page_id(self) -> None:
        with self.assertRaisesRegex(ComposeError, "unknown page ids: 99_missing"):
            self.compose({"99_missing"})


if __name__ == "__main__":
    unittest.main()
