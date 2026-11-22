#!/usr/bin/env python3
from __future__ import annotations

import json
import re
import unittest

from tool.store_screenshots.capture import APP_DIR, PATROL_TARGET, TOOL_DIR, pending_scenes


class CaptureTest(unittest.TestCase):
    def test_pending_scenes_are_sorted_and_skip_captured(self) -> None:
        self.assertEqual(
            pending_scenes({"kyoshin_monitor", "eew_warning", "earthquake_detail"}, {"eew_warning"}),
            ["earthquake_detail", "kyoshin_monitor"],
        )

    def test_every_layout_page_has_a_scene_in_the_patrol_test(self) -> None:
        layout = json.loads((TOOL_DIR / "layout.json").read_text())
        test_source = (APP_DIR / PATROL_TARGET).read_text()
        scenes = set(re.findall(r"scene: '([a-z_]+)'", test_source))
        self.assertLessEqual({page["scene"] for page in layout["pages"]}, scenes)


if __name__ == "__main__":
    unittest.main()
