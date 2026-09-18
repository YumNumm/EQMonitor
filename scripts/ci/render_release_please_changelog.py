#!/usr/bin/env python3
"""Render one Release Please changelog section as TestFlight plain text."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

RELEASE_HEADING_RE = re.compile(r"^## \[([^]]+)]")
COMMIT_LINK_RE = re.compile(
    r"\s*\(\[[0-9a-f]{7,40}]\([^)]+\)\)\s*$",
    re.IGNORECASE,
)
MARKDOWN_LINK_RE = re.compile(r"\[([^]]+)]\([^)]+\)")
BOLD_RE = re.compile(r"\*\*([^*]+)\*\*")
CODE_RE = re.compile(r"`([^`]+)`")

SECTION_TITLES = {
    "Features": "新機能",
    "Bug Fixes": "不具合修正",
    "Performance Improvements": "パフォーマンス改善",
    "Reverts": "変更の取り消し",
    "Documentation": "ドキュメント",
    "Miscellaneous Chores": "その他",
}


def plain_text(markdown: str) -> str:
    without_commit = COMMIT_LINK_RE.sub("", markdown)
    without_links = MARKDOWN_LINK_RE.sub(r"\1", without_commit)
    without_bold = BOLD_RE.sub(r"\1", without_links)
    return CODE_RE.sub(r"\1", without_bold).strip()


def render_release_section(changelog: str, version: str) -> str:
    target_version = version.removeprefix("v")
    in_target = False
    output: list[str] = []

    for line in changelog.splitlines():
        release_match = RELEASE_HEADING_RE.match(line)
        if release_match is not None:
            if in_target:
                break
            in_target = release_match.group(1) == target_version
            continue

        if not in_target:
            continue

        if line.startswith("### "):
            title = line.removeprefix("### ").strip()
            if output and output[-1] != "":
                output.append("")
            output.append(SECTION_TITLES.get(title, plain_text(title)))
            continue

        if line.startswith("* "):
            output.append(f"・{plain_text(line.removeprefix('* '))}")

    if not in_target:
        raise ValueError(f"changelog section was not found: {target_version}")

    rendered = "\n".join(output).strip()
    if not rendered:
        raise ValueError(f"changelog section is empty: {target_version}")
    return f"{rendered}\n"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--changelog-path", type=Path, required=True)
    parser.add_argument("--version", required=True)
    args = parser.parse_args()

    try:
        changelog = args.changelog_path.read_text(encoding="utf-8")
        print(render_release_section(changelog, args.version), end="")
    except (OSError, ValueError) as error:
        parser.error(str(error))


if __name__ == "__main__":
    main()
