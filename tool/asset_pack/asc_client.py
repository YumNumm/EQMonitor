"""Minimal App Store Connect API client for Managed Background Assets.

Zero third-party dependencies on purpose: GitHub Actions runners always have
``python3`` and ``openssl`` preinstalled, but installing extra pip packages
(``cryptography``/``PyJWT``) adds a network dependency this workflow would
rather not need. ES256 JWT signing is done by shelling out to ``openssl``
(the App Store Connect ``.p8`` key is already a P-256 ECDSA PKCS8 key, the
same key ``deploy-app.yaml`` uses for ``xcrun altool``/``xcodebuild
-exportArchive``) and converting its DER signature to the raw r||s form the
JOSE ES256 spec requires. This exact approach was prototyped and cross
-verified against ``pyjwt``/``cryptography`` decoding a token built this way
during Task 7's implementation -- see task-7-report.md.

--------------------------------------------------------------------------
UNVERIFIED SURFACE WARNING (read before touching backgroundAsset* methods)
--------------------------------------------------------------------------
The resource *type names* used below (``backgroundAssets``,
``backgroundAssetVersions``, ``backgroundAssetUploadFiles``) are confirmed
to exist -- they are literal page titles / resource names on
https://developer.apple.com/documentation/AppStoreConnectAPI/managing-apple-hosted-background-assets
and were corroborated by multiple independent web searches during
implementation. The *exact* JSON:API attribute names inside each request
and response body were NOT verified against a verbatim doc fetch or a live
API call (Apple's ASC API reference is a JS-rendered SPA that this
environment's tooling could not retrieve in full; there is no live
Background Assets pack yet in App Store Connect for this app to probe
against). The shapes implemented here follow the *same*
reserve-upload-commit pattern used uniformly by every other ASC API asset
upload family (appScreenshots, appPreviews, buildIcons, ...) -- a stable,
years-old convention across the whole API surface -- so this is an
informed, structural best guess, not a random fabrication.

Every response is validated for the keys this client expects before use.
If the live API's shape differs, methods raise ``AscApiError`` with the
raw response body attached rather than silently proceeding on a wrong
assumption. **The first real workflow run against a live Background Assets
pack MUST confirm this against the live API** and this file must be fixed
immediately if any field name mismatches -- do not treat a passing dry run
of the surrounding workflow as proof this client is correct.

Manual fallback if this client turns out to be wrong on first use: upload
the archive produced by ``ba-package`` by hand with Transporter (drag and
drop) or ``xcrun altool --upload-asset-pack``, both documented in
docs/asset-pack-cd.md.
"""

from __future__ import annotations

import base64
import hashlib
import json
import subprocess
import time
import urllib.error
import urllib.request
from dataclasses import dataclass

API_BASE = "https://api.appstoreconnect.apple.com"
JWT_AUDIENCE = "appstoreconnect-v1"
JWT_TTL_SECONDS = 19 * 60  # ASC hard limit is 20 minutes; match scripts/testflight.


class AscApiError(RuntimeError):
    """Raised when the App Store Connect API responds with an unexpected
    status code or a response body missing keys this client relies on."""


def _b64url(data: bytes) -> str:
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode("ascii")


def _der_signature_to_raw(der_sig: bytes, coordinate_len: int = 32) -> bytes:
    """Convert an ECDSA DER signature (SEQUENCE of two INTEGERs) to the raw
    r||s encoding required by JOSE ES256 (32 bytes each for P-256)."""
    if der_sig[0] != 0x30:
        raise ValueError("not a DER SEQUENCE")
    idx = 2
    if der_sig[idx] != 0x02:
        raise ValueError("expected INTEGER (r)")
    r_len = der_sig[idx + 1]
    r = der_sig[idx + 2 : idx + 2 + r_len]
    idx = idx + 2 + r_len
    if der_sig[idx] != 0x02:
        raise ValueError("expected INTEGER (s)")
    s_len = der_sig[idx + 1]
    s = der_sig[idx + 2 : idx + 2 + s_len]

    def normalize(component: bytes) -> bytes:
        component = component.lstrip(b"\x00")
        if len(component) > coordinate_len:
            raise ValueError("integer component longer than curve order")
        return component.rjust(coordinate_len, b"\x00")

    return normalize(r) + normalize(s)


def build_es256_jwt(key_id: str, issuer_id: str, private_key_path: str) -> str:
    """Build an ES256 JWT for the App Store Connect API using ``openssl``
    to sign with the given PKCS8 EC private key file (a ``.p8`` file)."""
    header = {"alg": "ES256", "kid": key_id, "typ": "JWT"}
    now = int(time.time())
    payload = {
        "iss": issuer_id,
        "iat": now,
        "exp": now + JWT_TTL_SECONDS,
        "aud": JWT_AUDIENCE,
    }
    signing_input = (
        _b64url(json.dumps(header, separators=(",", ":")).encode())
        + "."
        + _b64url(json.dumps(payload, separators=(",", ":")).encode())
    )
    der_signature = subprocess.run(
        ["openssl", "dgst", "-sha256", "-sign", private_key_path],
        input=signing_input.encode(),
        capture_output=True,
        check=True,
    ).stdout
    raw_signature = _der_signature_to_raw(der_signature)
    return signing_input + "." + _b64url(raw_signature)


@dataclass
class AscResponse:
    status: int
    body: dict


class AscClient:
    def __init__(self, key_id: str, issuer_id: str, private_key_path: str) -> None:
        self._key_id = key_id
        self._issuer_id = issuer_id
        self._private_key_path = private_key_path

    def _token(self) -> str:
        return build_es256_jwt(self._key_id, self._issuer_id, self._private_key_path)

    def request(
        self,
        method: str,
        path: str,
        json_body: dict | None = None,
        extra_headers: dict[str, str] | None = None,
        raw_body: bytes | None = None,
    ) -> AscResponse:
        url = path if path.startswith("http") else API_BASE + path
        headers = {"Authorization": f"Bearer {self._token()}"}
        headers.update(extra_headers or {})
        data: bytes | None = None
        if json_body is not None:
            data = json.dumps(json_body).encode()
            headers["Content-Type"] = "application/json"
        elif raw_body is not None:
            data = raw_body
        req = urllib.request.Request(url, data=data, headers=headers, method=method)
        try:
            with urllib.request.urlopen(req) as resp:  # noqa: S310 (trusted Apple host)
                status = resp.status
                text = resp.read().decode("utf-8", errors="replace")
        except urllib.error.HTTPError as err:
            status = err.code
            text = err.read().decode("utf-8", errors="replace")
        body: dict = {}
        if text:
            try:
                body = json.loads(text)
            except json.JSONDecodeError:
                body = {"raw": text}
        return AscResponse(status=status, body=body)

    # -- Managed Background Assets ---------------------------------------

    def find_background_asset_id(self, app_id: str, asset_pack_identifier: str) -> str | None:
        """Find the ``backgroundAssets`` resource id for ``asset_pack_identifier``
        under the given app, if one has been created in App Store Connect.

        See the UNVERIFIED SURFACE WARNING above: the attribute holding the
        pack's identifier is a best guess (tries a few plausible keys). If
        none match but at least one backgroundAssets resource exists for the
        app, the full raw list is logged so a human can confirm the right
        attribute name and identifier by inspection.
        """
        res = self.request("GET", f"/v1/apps/{app_id}/backgroundAssets")
        if res.status != 200:
            raise AscApiError(
                f"listing backgroundAssets for app {app_id} failed: "
                f"{res.status} {json.dumps(res.body)}"
            )
        items = res.body.get("data")
        if items is None:
            raise AscApiError(
                f"unexpected backgroundAssets response shape (no 'data' key): "
                f"{json.dumps(res.body)}"
            )
        candidate_attribute_keys = ("assetPackIdentifier", "identifier", "assetPackID", "name")
        for item in items:
            attributes = item.get("attributes", {})
            if any(attributes.get(key) == asset_pack_identifier for key in candidate_attribute_keys):
                return item["id"]
        if items:
            print(
                "asc_client: no backgroundAssets item matched "
                f"'{asset_pack_identifier}' by any of {candidate_attribute_keys}; "
                f"raw items for manual inspection: {json.dumps(items, indent=2)}"
            )
        return None

    def create_background_asset_version(self, background_asset_id: str) -> str:
        res = self.request(
            "POST",
            "/v1/backgroundAssetVersions",
            json_body={
                "data": {
                    "type": "backgroundAssetVersions",
                    "relationships": {
                        "backgroundAsset": {
                            "data": {"type": "backgroundAssets", "id": background_asset_id}
                        }
                    },
                }
            },
        )
        if res.status not in (200, 201):
            raise AscApiError(
                f"create backgroundAssetVersions failed: {res.status} {json.dumps(res.body)}"
            )
        version_id = res.body.get("data", {}).get("id")
        if not version_id:
            raise AscApiError(
                f"backgroundAssetVersions response missing data.id: {json.dumps(res.body)}"
            )
        return version_id

    def reserve_background_asset_upload(
        self, version_id: str, file_name: str, file_size: int
    ) -> tuple[str, list[dict]]:
        res = self.request(
            "POST",
            "/v1/backgroundAssetUploadFiles",
            json_body={
                "data": {
                    "type": "backgroundAssetUploadFiles",
                    "attributes": {
                        "fileName": file_name,
                        "fileSize": file_size,
                        "assetType": "ARCHIVE",
                    },
                    "relationships": {
                        "backgroundAssetVersion": {
                            "data": {"type": "backgroundAssetVersions", "id": version_id}
                        }
                    },
                }
            },
        )
        if res.status not in (200, 201):
            raise AscApiError(
                f"reserve backgroundAssetUploadFiles failed: {res.status} {json.dumps(res.body)}"
            )
        data = res.body.get("data", {})
        upload_file_id = data.get("id")
        upload_operations = data.get("attributes", {}).get("uploadOperations")
        if not upload_file_id or upload_operations is None:
            raise AscApiError(
                "backgroundAssetUploadFiles response missing data.id or "
                f"data.attributes.uploadOperations: {json.dumps(res.body)}"
            )
        return upload_file_id, upload_operations

    def upload_file_parts(self, archive_path: str, upload_operations: list[dict]) -> None:
        with open(archive_path, "rb") as f:
            file_bytes = f.read()
        for op in upload_operations:
            method = op.get("method", "PUT")
            url = op["url"]
            offset = op.get("offset", 0)
            length = op.get("length", len(file_bytes) - offset)
            chunk = file_bytes[offset : offset + length]
            headers = {h["name"]: h["value"] for h in op.get("requestHeaders", [])}
            req = urllib.request.Request(url, data=chunk, headers=headers, method=method)
            with urllib.request.urlopen(req) as resp:  # noqa: S310 (trusted Apple upload host)
                if resp.status not in (200, 201, 204):
                    raise AscApiError(
                        f"upload part failed (offset={offset}, length={length}): {resp.status}"
                    )

    def commit_background_asset_upload(self, upload_file_id: str, archive_path: str) -> None:
        with open(archive_path, "rb") as f:
            md5_hash = hashlib.md5(f.read()).hexdigest()  # noqa: S324
        # ASC API 4.1+: `sourceFileChecksum` is deprecated; use `sourceFileChecksums`
        # (Checksums type). For a single-part archive upload, file and composite
        # both use the whole-file MD5. Checksums are optional per Apple, but we
        # still send them for integrity validation.
        source_file_checksums = {
            "file": {"hash": md5_hash, "algorithm": "MD5"},
            "composite": {"hash": md5_hash, "algorithm": "MD5"},
        }
        res = self.request(
            "PATCH",
            f"/v1/backgroundAssetUploadFiles/{upload_file_id}",
            json_body={
                "data": {
                    "type": "backgroundAssetUploadFiles",
                    "id": upload_file_id,
                    "attributes": {
                        "uploaded": True,
                        "sourceFileChecksums": source_file_checksums,
                    },
                }
            },
        )
        if res.status not in (200, 201):
            raise AscApiError(
                f"commit backgroundAssetUploadFiles failed: {res.status} {json.dumps(res.body)}"
            )

    # Terminal-success state names are unverified (see the module docstring's
    # UNVERIFIED SURFACE WARNING) -- both candidates below are plausible based
    # on ASC's naming conventions for other processing pipelines (builds use
    # PROCESSING/VALID/INVALID/FAILED, TestFlight beta review uses similar
    # READY_FOR_* naming). Kept as a class attribute (not a magic tuple inline)
    # so the "what counts as success" allow-list is easy to find and audit.
    KNOWN_SUCCESS_STATES = ("READY_FOR_TESTING", "PROCESSING_COMPLETE")
    KNOWN_FAILURE_STATES = ("FAILED_PROCESSING", "REJECTED", "INVALID")

    def poll_background_asset_version_state(
        self, version_id: str, timeout_seconds: int = 20 * 60, interval_seconds: int = 20
    ) -> str:
        """Poll until the backgroundAssetVersion reaches a known terminal state.

        Raises ``AscApiError`` -- never returns normally -- unless the state
        lands in ``KNOWN_SUCCESS_STATES``. This includes the timeout case: an
        unrecognized (not explicitly known-good, not explicitly known-bad)
        state at deadline is treated as a failure, not a silent pass, because
        the terminal state name is unverified (see class docstring) and a
        real stuck/failed upload must not make this job report green.
        """
        deadline = time.time() + timeout_seconds
        last_state = "UNKNOWN"
        while time.time() < deadline:
            res = self.request("GET", f"/v1/backgroundAssetVersions/{version_id}")
            if res.status != 200:
                raise AscApiError(
                    f"poll backgroundAssetVersions failed: {res.status} {json.dumps(res.body)}"
                )
            attributes = res.body.get("data", {}).get("attributes", {})
            last_state = attributes.get("state") or attributes.get("assetPackState") or "UNKNOWN"
            print(f"asc_client: backgroundAssetVersion {version_id} state={last_state}")
            if last_state in self.KNOWN_FAILURE_STATES:
                raise AscApiError(
                    f"backgroundAssetVersion {version_id} processing failed: "
                    f"state={last_state}. Check App Store Connect manually -- see "
                    "docs/asset-pack-cd.md 'Manual verification if polling fails "
                    "or times out'."
                )
            if last_state in self.KNOWN_SUCCESS_STATES:
                return last_state
            time.sleep(interval_seconds)
        raise AscApiError(
            f"timed out after {timeout_seconds}s waiting for backgroundAssetVersion "
            f"{version_id} to reach a known terminal state (last observed state="
            f"{last_state!r}, not in KNOWN_SUCCESS_STATES={self.KNOWN_SUCCESS_STATES}). "
            "The terminal state name is unverified against the live API (see this "
            "module's UNVERIFIED SURFACE WARNING) -- this may mean the upload is "
            "still processing normally under a state name this client doesn't "
            "recognize yet, OR that it is genuinely stuck/failed. Either way this "
            "must not be silently treated as success: check App Store Connect "
            "manually -- see docs/asset-pack-cd.md 'Manual verification if polling "
            "fails or times out' -- and, if the observed state is a legitimate "
            "success state, add it to KNOWN_SUCCESS_STATES above."
        )
