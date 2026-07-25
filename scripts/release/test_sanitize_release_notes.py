import unittest

from scripts.release.sanitize_release_notes import sanitize_release_notes


class SanitizeReleaseNotesTest(unittest.TestCase):
    def test_escapes_at_signs_only_in_pull_request_title(self) -> None:
        notes = (
            "* fix: @Default(ja) and @example by @YumNumm in "
            "https://github.com/YumNumm/EQMonitor/pull/1234\n"
        )

        self.assertEqual(
            sanitize_release_notes(notes),
            "* fix: &#64;Default(ja) and &#64;example by @YumNumm in "
            "https://github.com/YumNumm/EQMonitor/pull/1234\n",
        )

    def test_escapes_at_sign_in_direct_commit_message(self) -> None:
        notes = (
            "* fix: avoid @mention by @dependabot[bot] in "
            "https://github.com/YumNumm/EQMonitor/commit/abc123"
        )

        self.assertEqual(
            sanitize_release_notes(notes),
            "* fix: avoid &#64;mention by @dependabot[bot] in "
            "https://github.com/YumNumm/EQMonitor/commit/abc123",
        )

    def test_preserves_new_contributor_mentions(self) -> None:
        notes = (
            "## New Contributors\n"
            "* @cursor[bot] made their first contribution in "
            "https://github.com/YumNumm/EQMonitor/pull/1161\n"
        )

        self.assertEqual(sanitize_release_notes(notes), notes)

    def test_preserves_unrecognized_bullet(self) -> None:
        notes = "* contact @team when publishing\n"

        self.assertEqual(sanitize_release_notes(notes), notes)

    def test_is_idempotent(self) -> None:
        notes = (
            "* fix: @Default(ja) by @YumNumm in "
            "https://github.com/YumNumm/EQMonitor/pull/1234\n"
        )

        once = sanitize_release_notes(notes)

        self.assertEqual(sanitize_release_notes(once), once)


if __name__ == "__main__":
    unittest.main()
