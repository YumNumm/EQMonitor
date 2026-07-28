#!/usr/bin/env python3
"""Extract AppIntent-only tables from a full jma_code_table.json."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any

PREFECTURE_KEY = "area_information_prefecture_earthquake"
CITY_KEY = "area_information_city"


class ExtractError(Exception):
    """Required tables are missing, empty, or the source is unreadable."""


def _require_non_empty_list(code_tables: dict[str, Any], key: str) -> list[Any]:
    value = code_tables.get(key)
    if not isinstance(value, list) or len(value) == 0:
        raise ExtractError(f"code_tables.{key} must be a non-empty array")
    return value


def extract_slim_jma_code_table(*, source: Path, destination: Path) -> None:
    try:
        raw = json.loads(source.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as err:
        raise ExtractError(f"cannot read source JSON {source}: {err}") from err

    if not isinstance(raw, dict):
        raise ExtractError("root must be a JSON object")
    code_tables = raw.get("code_tables")
    if not isinstance(code_tables, dict):
        raise ExtractError("code_tables must be an object")

    slim = {
        "code_tables": {
            PREFECTURE_KEY: _require_non_empty_list(code_tables, PREFECTURE_KEY),
            CITY_KEY: _require_non_empty_list(code_tables, CITY_KEY),
        }
    }

    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(
        json.dumps(slim, ensure_ascii=False, separators=(",", ":")) + "\n",
        encoding="utf-8",
    )


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--destination", required=True, type=Path)
    args = parser.parse_args(argv)
    try:
        extract_slim_jma_code_table(source=args.source, destination=args.destination)
    except ExtractError as err:
        print(f"::error::{err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
