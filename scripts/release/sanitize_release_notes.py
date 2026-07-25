import re
import sys


CHANGE_LINE_PATTERN = re.compile(
    r"^(?P<title>\* .+?)(?P<suffix> by @[A-Za-z0-9-]+(?:\[bot\])? in "
    r"https://github\.com/[^/\s]+/[^/\s]+/(?:pull|commit)/[^\s]+)$"
)


def sanitize_release_notes(notes: str) -> str:
    return "".join(_sanitize_line(line) for line in notes.splitlines(keepends=True))


def _sanitize_line(line: str) -> str:
    content = line.rstrip("\r\n")
    line_ending = line[len(content) :]
    match = CHANGE_LINE_PATTERN.fullmatch(content)
    if match is None:
        return line
    title = match.group("title").replace("@", "&#64;")
    return f'{title}{match.group("suffix")}{line_ending}'


if __name__ == "__main__":
    sys.stdout.write(sanitize_release_notes(sys.stdin.read()))
