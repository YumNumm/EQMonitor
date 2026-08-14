#!/usr/bin/env python3
from __future__ import annotations

import unittest

from scripts.ci.truncate_release_note import truncate_release_note


class TruncateReleaseNoteTest(unittest.TestCase):
    def test_keeps_rev_when_truncating(self) -> None:
        rev = "a" * 40
        body = "あ" * 480 + "\n\nrev: " + rev + "\n"
        out = truncate_release_note(body, 500)
        self.assertIn("rev: " + rev, out)
        self.assertLessEqual(len(out), 500)
        self.assertTrue(out.rstrip().endswith("rev: " + rev))

    def test_short_text_unchanged(self) -> None:
        text = "変更点\n・#1 x\n\nrev: " + "b" * 40 + "\n"
        self.assertEqual(truncate_release_note(text, 500), text)

    def test_without_rev_truncates_with_ellipsis(self) -> None:
        text = "x" * 100
        out = truncate_release_note(text, 50)
        self.assertEqual(len(out), 50)
        self.assertTrue(out.endswith("..."))


if __name__ == "__main__":
    unittest.main()
