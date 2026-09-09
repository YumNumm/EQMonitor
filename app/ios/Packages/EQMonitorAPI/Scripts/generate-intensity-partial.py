#!/usr/bin/env python3
"""Regenerate IntensityPartial while preserving legacy device API contracts.

The checked-in OpenAPI snapshot omits legacy Live Activity operations that are
still present in GeneratedSources. A full regeneration would delete those APIs.
Generate the changed schema with Apple's generator and replace only that type.
Usage: python3 Scripts/generate-intensity-partial.py /path/to/swift-openapi-generator
"""

import pathlib
import subprocess
import sys
import tempfile


def declaration_span(source: str) -> tuple[int, int]:
    marker = "        public struct IntensityPartial:"
    start = source.index(marker)
    opening = source.index("{", start)
    depth = 0
    for index in range(opening, len(source)):
        if source[index] == "{":
            depth += 1
        elif source[index] == "}":
            depth -= 1
            if depth == 0:
                return start, index + 1
    raise ValueError("Incomplete generated IntensityPartial declaration")


def main() -> None:
    package = pathlib.Path(__file__).resolve().parent.parent
    source_dir = package / "Sources/EQMonitorAPI"
    target = source_dir / "GeneratedSources/Types.swift"
    with tempfile.TemporaryDirectory(prefix="eqmonitor-intensity-schema-") as directory:
        output = pathlib.Path(directory)
        config = output / "config.yaml"
        config.write_text("generate: [types]\naccessModifier: public\n")
        subprocess.run([
            sys.argv[1], "generate", str(source_dir / "openapi.json"),
            "--config", str(config), "--output-directory", str(output),
        ], check=True)
        original = target.read_text()
        generated = (output / "Types.swift").read_text()
        old_start, old_end = declaration_span(original)
        new_start, new_end = declaration_span(generated)
        target.write_text(original[:old_start] + generated[new_start:new_end] + original[old_end:])


if __name__ == "__main__":
    main()
