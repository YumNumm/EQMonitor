import re
import sys


COMMIT_LINK_PATTERN = re.compile(
    r"\s*\(\[[0-9a-f]{7,40}]\([^)]+\)\)\s*$",
    re.IGNORECASE,
)


def dedupe_release_please_notes(notes: str) -> str:
    seen_entries: set[str] = set()
    lines: list[str] = []
    for line in notes.splitlines(keepends=True):
        if line.startswith("#"):
            seen_entries = set()
        elif line.startswith("* "):
            entry = COMMIT_LINK_PATTERN.sub("", line.rstrip("\r\n"))
            if entry in seen_entries:
                continue
            seen_entries.add(entry)
        lines.append(line)
    return "".join(lines)


if __name__ == "__main__":
    sys.stdout.write(dedupe_release_please_notes(sys.stdin.read()))
