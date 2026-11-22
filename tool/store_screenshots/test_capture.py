#!/usr/bin/env python3
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from tool.store_screenshots.capture import (
    TOOL_DIR,
    CaptureError,
    app_session,
    drop_scenes_without_fixtures,
    select_scenes,
)

CONFIG = json.loads((TOOL_DIR / "scenes.json").read_text())


class CaptureConfigTest(unittest.TestCase):
    def test_lock_screen_scene_is_ios_only(self) -> None:
        android = {scene["name"] for scene in select_scenes(CONFIG, "android", None)}
        ios = {scene["name"] for scene in select_scenes(CONFIG, "ios", None)}
        self.assertNotIn("lock_screen_live_activity", android)
        self.assertEqual(ios - android, {"lock_screen_live_activity"})

    def test_every_layout_page_has_an_ios_scene(self) -> None:
        layout = json.loads((TOOL_DIR / "layout.json").read_text())
        ios = {scene["name"] for scene in select_scenes(CONFIG, "ios", None)}
        self.assertLessEqual({page["scene"] for page in layout["pages"]}, ios)

    def test_rejects_unknown_scene_names(self) -> None:
        with self.assertRaisesRegex(CaptureError, "lock_screen_live_activity"):
            select_scenes(CONFIG, "android", {"lock_screen_live_activity"})

    def test_app_session_drops_host_only_keys(self) -> None:
        session = app_session(CONFIG, select_scenes(CONFIG, "ios", None))
        self.assertEqual(session["preferences"], CONFIG["preferences"])
        for scene in session["scenes"]:
            self.assertNotIn("platforms", scene)
            self.assertNotIn("capture", scene)

    def test_missing_fixtures_fail_unless_allowed(self) -> None:
        scenes = select_scenes(CONFIG, "ios", None)
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(CaptureError, "noto_peninsula_2024.eqrp"):
                drop_scenes_without_fixtures(scenes, Path(directory), allow_missing=False)
            remaining = drop_scenes_without_fixtures(scenes, Path(directory), allow_missing=True)
        self.assertEqual(
            [scene["name"] for scene in remaining], ["earthquake_detail", "lock_screen_live_activity"]
        )


if __name__ == "__main__":
    unittest.main()
