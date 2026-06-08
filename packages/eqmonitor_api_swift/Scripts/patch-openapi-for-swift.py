#!/usr/bin/env python3
"""Patch openapi.json for swift-openapi-generator compatibility.

swift-openapi-generator doesn't handle:
1. anyOf: [{type: X}, {type: null}] (OpenAPI 3.1 nullable)
2. nullable: true (OpenAPI 3.0 style, invalid in 3.1)

This script recursively walks the entire spec and converts both patterns
to the non-null type + removing from required array.
"""

import json
import sys
import copy


def patch_nullable_anyof(obj):
    """If obj has anyOf: [{type/ref}, {type: null}], collapse to non-null type."""
    if not isinstance(obj, dict) or "anyOf" not in obj:
        return obj, False

    any_of = obj["anyOf"]
    null_items = [i for i in any_of if isinstance(i, dict) and i.get("type") == "null"]
    non_null_items = [i for i in any_of if not (isinstance(i, dict) and i.get("type") == "null")]

    if not null_items:
        return obj, False

    result = copy.deepcopy(obj)
    del result["anyOf"]

    if len(non_null_items) == 1:
        result.update(non_null_items[0])
    elif len(non_null_items) > 1:
        result["anyOf"] = non_null_items

    return result, True


def walk_and_patch(obj, parent_schema=None, prop_name=None):
    """Recursively walk and patch all nullable patterns."""
    if not isinstance(obj, dict):
        if isinstance(obj, list):
            total = 0
            result = []
            for item in obj:
                patched, count = walk_and_patch(item)
                result.append(patched)
                total += count
            return result, total
        return obj, 0

    result = {}
    total = 0

    for key, value in obj.items():
        if key == "properties" and isinstance(value, dict):
            required = set(obj.get("required", []))
            patched_props = {}
            for pname, pdef in value.items():
                patched_def, was_anyof_patched = patch_nullable_anyof(pdef)
                if was_anyof_patched:
                    required.discard(pname)
                    total += 1

                if isinstance(patched_def, dict) and patched_def.get("nullable") is True:
                    patched_def = {k: v for k, v in patched_def.items() if k != "nullable"}
                    required.discard(pname)
                    total += 1

                patched_def, sub_count = walk_and_patch(patched_def)
                total += sub_count
                patched_props[pname] = patched_def

            result["properties"] = patched_props
            if required:
                result["required"] = sorted(required)
            continue

        if key == "required" and "properties" in obj:
            continue

        if key == "nullable":
            total += 1
            continue

        if key == "anyOf" and isinstance(value, list):
            patched_parent, was_patched = patch_nullable_anyof(obj)
            if was_patched:
                for pk, pv in patched_parent.items():
                    if pk not in result:
                        patched_v, sub_count = walk_and_patch(pv)
                        result[pk] = patched_v
                        total += sub_count + 1
                return result, total

        patched_value, sub_count = walk_and_patch(value)
        result[key] = patched_value
        total += sub_count

    return result, total


def main():
    input_path = sys.argv[1] if len(sys.argv) > 1 else "openapi.json"
    output_path = sys.argv[2] if len(sys.argv) > 2 else input_path

    with open(input_path) as f:
        spec = json.load(f)

    patched, count = walk_and_patch(spec)
    print(f"Patched {count} nullable patterns", file=sys.stderr)

    with open(output_path, "w") as f:
        json.dump(patched, f, indent=2, ensure_ascii=False)
        f.write("\n")


if __name__ == "__main__":
    main()
