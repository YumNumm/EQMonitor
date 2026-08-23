#!/usr/bin/env python3
from __future__ import annotations

import unittest

from scripts.ci.render_release_please_changelog import render_release_section


class RenderReleasePleaseChangelogTest(unittest.TestCase):
    def test_renders_only_matching_release_as_plain_text(self) -> None:
        changelog = """\
## [3.0.0-beta.2](https://example.com/beta.2)
### Features
* **map:** 新機能 ([abcdef0](https://example.com/commit/abcdef0))
### Bug Fixes
* 不具合修正 ([1234567](https://example.com/commit/1234567))
## [3.0.0-beta.1](https://example.com/beta.1)
### Features
* 前回の変更 ([7654321](https://example.com/commit/7654321))
"""

        self.assertEqual(
            render_release_section(changelog, "v3.0.0-beta.2"),
            "新機能\n・map: 新機能\n\n不具合修正\n・不具合修正\n",
        )

    def test_rejects_missing_release(self) -> None:
        with self.assertRaisesRegex(ValueError, "3.0.0-beta.3"):
            render_release_section("## [3.0.0-beta.2]\n", "v3.0.0-beta.3")


if __name__ == "__main__":
    unittest.main()
