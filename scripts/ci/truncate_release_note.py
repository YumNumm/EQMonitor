#!/usr/bin/env python3
"""Truncate release notes while preserving a trailing `rev: <40hex>` line."""

from __future__ import annotations

import argparse
import re
import sys

REV_LINE_RE = re.compile(r"(?:^|\n)(rev: [0-9a-f]{40})\s*$")


def truncate_release_note(text: str, max_chars: int) -> str:
    if max_chars < 1:
        raise ValueError("max_chars must be >= 1")

    match = REV_LINE_RE.search(text)
    if match is None:
        if len(text) <= max_chars:
            return text
        if max_chars <= 3:
            return "." * max_chars
        return text[: max_chars - 3] + "..."

    rev_line = match.group(1)
    body = text[: match.start(1)].rstrip("\n")
    suffix = f"\n\n{rev_line}\n"
    if len(body) + len(suffix) <= max_chars:
        return f"{body}{suffix}" if body else f"{rev_line}\n"

    # Reserve room for ellipsis + suffix
    budget = max_chars - len(suffix) - 3
    if budget < 0:
        # Extreme: keep only rev if it fits, else hard-cut rev (should not happen at 500+)
        if len(rev_line) + 1 <= max_chars:
            return f"{rev_line}\n"
        return (rev_line + "\n")[:max_chars]

    truncated_body = body[:budget] + "..."
    return f"{truncated_body}{suffix}"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-chars", type=int, required=True)
    args = parser.parse_args()
    text = sys.stdin.read()
    sys.stdout.write(truncate_release_note(text, args.max_chars))


if __name__ == "__main__":
    main()
