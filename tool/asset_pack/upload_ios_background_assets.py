#!/usr/bin/env python3
"""Upload a Managed Background Assets archive to App Store Connect.

Two modes, both used by .github/workflows/upload-asset-pack.yaml:

  ensure-exists  Ensure App Store Connect has a backgroundAssets resource
                 for --asset-pack-id under --app-id. Creates one via
                 POST /v1/backgroundAssets when missing (WWDC25 / ASC API
                 "Create an asset pack record").

  check-exists   Legacy alias of ensure-exists (kept so older workflow
                 revisions keep working).

  upload         Ensure the pack exists, then create a new
                 backgroundAssetVersion, reserve+upload the archive,
                 commit it, and poll for a terminal state.

See tool/asset_pack/asc_client.py's module docstring for the load-bearing
"UNVERIFIED SURFACE WARNING" about which parts of this flow are doc/WWDC
-confirmed vs. best-effort inference from ASC API conventions. If this
script fails partway through "upload", nothing has silently gone through:
every ASC call is checked for the response shape this script expects, and
failures point back to the manual fallback in docs/asset-pack-cd.md
(Transporter / `xcrun altool --upload-asset-pack`).
"""

from __future__ import annotations

import argparse
import os
import sys

from tool.asset_pack.asc_client import AscApiError, AscClient


def _client_from_env(args: argparse.Namespace) -> AscClient:
    return AscClient(
        key_id=args.key_id,
        issuer_id=args.issuer_id,
        private_key_path=args.key_path,
    )


def cmd_ensure_exists(args: argparse.Namespace) -> int:
    client = _client_from_env(args)
    background_asset_id = client.ensure_background_asset_id(args.app_id, args.asset_pack_id)
    print("found")
    print(f"background_asset_id={background_asset_id}")
    return 0


def cmd_upload(args: argparse.Namespace) -> int:
    client = _client_from_env(args)
    background_asset_id = client.ensure_background_asset_id(args.app_id, args.asset_pack_id)
    print(f"using background_asset_id={background_asset_id}")

    file_size = os.path.getsize(args.archive_path)
    file_name = os.path.basename(args.archive_path)

    print(f"creating backgroundAssetVersion for backgroundAsset {background_asset_id}")
    version_id = client.create_background_asset_version(background_asset_id)
    print(f"created backgroundAssetVersion {version_id}")

    print(f"reserving upload for {file_name} ({file_size} bytes)")
    upload_file_id, upload_operations = client.reserve_background_asset_upload(
        version_id, file_name, file_size
    )
    print(f"reserved upload {upload_file_id} ({len(upload_operations)} part(s))")

    client.upload_file_parts(args.archive_path, upload_operations)
    print("all parts uploaded")

    client.commit_background_asset_upload(upload_file_id, args.archive_path)
    print("upload committed")

    final_state = client.poll_background_asset_version_state(version_id)
    print(f"final backgroundAssetVersion state: {final_state}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--key-id", required=True, help="App Store Connect API key id")
    parser.add_argument("--issuer-id", required=True, help="App Store Connect API issuer id")
    parser.add_argument("--key-path", required=True, help="path to the .p8 private key file")
    parser.add_argument("--app-id", required=True, help="App Store Connect app id (ASC_APP_ID)")
    parser.add_argument(
        "--asset-pack-id",
        required=True,
        help="Managed Background Assets pack identifier (assetPackID in the ba-package manifest)",
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    subparsers.add_parser("ensure-exists")
    subparsers.add_parser("check-exists")  # legacy alias of ensure-exists

    upload_parser = subparsers.add_parser("upload")
    upload_parser.add_argument("--archive-path", required=True, help="path to the packaged archive")

    return parser


def main(argv: list[str]) -> int:
    args = build_parser().parse_args(argv)
    try:
        if args.command in ("ensure-exists", "check-exists"):
            return cmd_ensure_exists(args)
        if args.command == "upload":
            return cmd_upload(args)
        raise AssertionError(f"unhandled command: {args.command}")
    except AscApiError as err:
        print(f"::error::{err}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
