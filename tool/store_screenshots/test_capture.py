#!/usr/bin/env python3
from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

from tool.store_screenshots.capture import (
    TOOL_DIR,
    CaptureError,
    app_error_lines,
    app_session,
    drop_scenes_without_fixtures,
    select_scenes,
)

CONFIG = json.loads((TOOL_DIR / "scenes.json").read_text())


class CaptureConfigTest(unittest.TestCase):
    def test_lock_screen_scene_is_ios_only_and_experimental(self) -> None:
        all_names = {"eew_warning", "kyoshin_monitor", "earthquake_detail", "lock_screen_live_activity"}
        android = {scene["name"] for scene in select_scenes(CONFIG, "android", None)}
        ios = {scene["name"] for scene in select_scenes(CONFIG, "ios", None)}
        self.assertEqual(android, ios)
        self.assertNotIn("lock_screen_live_activity", ios)
        named = select_scenes(CONFIG, "ios", {"lock_screen_live_activity"})
        self.assertEqual([scene["name"] for scene in named], ["lock_screen_live_activity"])
        self.assertLessEqual(ios, all_names)

    def test_every_layout_page_has_an_ios_scene(self) -> None:
        layout = json.loads((TOOL_DIR / "layout.json").read_text())
        ios = {scene["name"] for scene in CONFIG["scenes"] if "ios" in scene["platforms"]}
        self.assertLessEqual({page["scene"] for page in layout["pages"]}, ios)

    def test_rejects_unknown_scene_names(self) -> None:
        with self.assertRaisesRegex(CaptureError, "lock_screen_live_activity"):
            select_scenes(CONFIG, "android", {"lock_screen_live_activity"})

    def test_app_session_drops_host_only_keys(self) -> None:
        session = app_session(CONFIG, select_scenes(CONFIG, "ios", {"lock_screen_live_activity", "eew_warning"}))
        self.assertEqual(session["preferences"], CONFIG["preferences"])
        for scene in session["scenes"]:
            self.assertNotIn("platforms", scene)
            self.assertNotIn("capture", scene)
            self.assertNotIn("experimental", scene)

    def test_missing_fixtures_fail_unless_allowed(self) -> None:
        scenes = select_scenes(CONFIG, "ios", None)
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(CaptureError, "noto_peninsula_2024.eqrp"):
                drop_scenes_without_fixtures(scenes, Path(directory), allow_missing=False)
            remaining = drop_scenes_without_fixtures(scenes, Path(directory), allow_missing=True)
        self.assertEqual([scene["name"] for scene in remaining], ["earthquake_detail"])

    def test_app_error_lines_keep_context_after_matches(self) -> None:
        log = "\n".join(
            [
                "flutter: GET /v2/earthquakes 200",
                "flutter: [http-error] [GET] https://example.invalid/v2/x",
                "flutter: Status: 403",
                "flutter: Data: {error: FORBIDDEN}",
                "flutter: ok 1",
                "flutter: ok 2",
                "flutter: ok 3",
                "flutter: ok 4",
                "flutter: ok 5",
            ]
        )
        self.assertEqual(
            app_error_lines(log),
            [
                "flutter: [http-error] [GET] https://example.invalid/v2/x",
                "flutter: Status: 403",
                "flutter: Data: {error: FORBIDDEN}",
                "flutter: ok 1",
                "flutter: ok 2",
                "flutter: ok 3",
                "flutter: ok 4",
            ],
        )


if __name__ == "__main__":
    unittest.main()
