#!/usr/bin/env python3
"""Fail fast when the Managed Background Assets pack id drifts.

The same identifier is declared in three independent places that no
compiler or type system ties together:

  * `.github/workflows/upload-asset-pack.yaml`'s `IOS_BACKGROUND_ASSET_PACK_ID`
    (what CI packages into the `.aar` manifest and uploads),
  * `packages/assets_util/lib/assets_util.dart`'s `_iosAssetPackIdentifier`
    (what the shipped app asks `AssetPackManager` for at runtime),
  * the App Store Connect `backgroundAssets` record.

A mismatch between the first two is invisible at build time and only shows
up as an asset pack that downloads but can never be resolved on device, so
this script asserts they agree before CI spends time packaging or uploading.

It also enforces App Store Connect's identifier charset: reverse-DNS ids
with dots are rejected with ITMS-91133 (see
docs/knowledge/20260728_asset_pack_id_charset.md), which is what forced the
move from `net.yumnumm.eqmonitor.assets` to `eqmonitor-assets`.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]

WORKFLOW_PATH = Path(".github/workflows/upload-asset-pack.yaml")
DART_PATH = Path("packages/assets_util/lib/assets_util.dart")

# App Store Connect rejects anything outside [A-Za-z0-9-], and an id may
# neither start nor end with a hyphen.
ASC_ASSET_PACK_ID_PATTERN = re.compile(r"^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?$")

_WORKFLOW_ID_PATTERN = re.compile(
    r"""^\s*IOS_BACKGROUND_ASSET_PACK_ID:\s*["']?([^"'\s#]+)["']?""",
    re.MULTILINE,
)
_DART_ID_PATTERN = re.compile(
    r"""^const\s+_iosAssetPackIdentifier\s*=\s*['"]([^'"]+)['"]\s*;""",
    re.MULTILINE,
)


class AssetPackIdError(Exception):
    """A declared asset pack id is malformed or inconsistent."""


def _extract(*, repo_root: Path, relative_path: Path, pattern: re.Pattern[str], label: str) -> str:
    path = repo_root / relative_path
    try:
        source = path.read_text(encoding="utf-8")
    except OSError as err:
        raise AssetPackIdError(f"cannot read {relative_path}: {err}") from err
    match = pattern.search(source)
    if match is None:
        raise AssetPackIdError(f"no {label} declaration found in {relative_path}")
    return match.group(1)


def collect_declared_ids(repo_root: Path = REPO_ROOT) -> dict[str, str]:
    """Returns every declared asset pack id keyed by its source location."""
    return {
        str(WORKFLOW_PATH): _extract(
            repo_root=repo_root,
            relative_path=WORKFLOW_PATH,
            pattern=_WORKFLOW_ID_PATTERN,
            label="IOS_BACKGROUND_ASSET_PACK_ID",
        ),
        str(DART_PATH): _extract(
            repo_root=repo_root,
            relative_path=DART_PATH,
            pattern=_DART_ID_PATTERN,
            label="_iosAssetPackIdentifier",
        ),
    }


def verify(expected_id: str, repo_root: Path = REPO_ROOT) -> str:
    """Validates [expected_id] and asserts every declaration site agrees.

    Raises [AssetPackIdError] on a charset violation or any mismatch.
    """
    if not ASC_ASSET_PACK_ID_PATTERN.match(expected_id):
        raise AssetPackIdError(
            f"asset pack id {expected_id!r} is not accepted by App Store Connect: "
            "only letters, digits and inner hyphens are allowed "
            "(dots produce ITMS-91133 — see "
            "docs/knowledge/20260728_asset_pack_id_charset.md)"
        )

    declared = collect_declared_ids(repo_root)
    mismatched = {source: value for source, value in declared.items() if value != expected_id}
    if mismatched:
        details = ", ".join(f"{source} declares {value!r}" for source, value in mismatched.items())
        raise AssetPackIdError(
            f"asset pack id mismatch: expected {expected_id!r} but {details}. "
            "An app built from a mismatched id downloads the pack but can never "
            "resolve it on device."
        )
    return expected_id


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--asset-pack-id",
        required=True,
        help="the id CI is about to package and upload (IOS_BACKGROUND_ASSET_PACK_ID)",
    )
    args = parser.parse_args(argv)
    try:
        verified = verify(args.asset_pack_id)
    except AssetPackIdError as err:
        print(f"::error::{err}", file=sys.stderr)
        return 1
    print(f"asset pack id {verified!r} is consistent across all declaration sites")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
