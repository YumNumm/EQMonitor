import base64
import json
import subprocess
import tempfile
import unittest
from pathlib import Path

from tool.asset_pack.asc_client import AscApiError, AscClient, AscResponse, build_es256_jwt


def _b64url_decode(segment: str) -> bytes:
    padding = "=" * (-len(segment) % 4)
    return base64.urlsafe_b64decode(segment + padding)


class BuildEs256JwtTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp_dir = tempfile.TemporaryDirectory()
        self.key_path = str(Path(self.tmp_dir.name) / "key.p8")
        ec_path = str(Path(self.tmp_dir.name) / "ec.pem")
        subprocess.run(
            ["openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", ec_path],
            check=True,
        )
        subprocess.run(
            ["openssl", "pkcs8", "-topk8", "-nocrypt", "-in", ec_path, "-out", self.key_path],
            check=True,
        )

    def tearDown(self) -> None:
        self.tmp_dir.cleanup()

    def test_produces_a_verifiable_es256_jwt_with_expected_claims(self) -> None:
        token = build_es256_jwt("KID123", "ISS456", self.key_path)

        header_b64, payload_b64, signature_b64 = token.split(".")
        header = json.loads(_b64url_decode(header_b64))
        payload = json.loads(_b64url_decode(payload_b64))
        signature = _b64url_decode(signature_b64)

        self.assertEqual(header, {"alg": "ES256", "kid": "KID123", "typ": "JWT"})
        self.assertEqual(payload["iss"], "ISS456")
        self.assertEqual(payload["aud"], "appstoreconnect-v1")
        self.assertGreater(payload["exp"] - payload["iat"], 0)
        self.assertLessEqual(payload["exp"] - payload["iat"], 20 * 60)
        # ES256 raw signature is exactly 64 bytes (32-byte r || 32-byte s).
        self.assertEqual(len(signature), 64)

    def test_signature_is_actually_verifiable_by_the_matching_public_key(self) -> None:
        # Round-trip through openssl itself: rebuild the DER signature from
        # the raw r||s this module emits, and ask openssl to verify it
        # against the public key derived from the same private key. This
        # guards against a subtly-wrong DER<->raw conversion that would
        # otherwise only be caught by a live App Store Connect API call.
        token = build_es256_jwt("KID123", "ISS456", self.key_path)
        signing_input, signature_b64 = token.rsplit(".", 1)
        raw_signature = _b64url_decode(signature_b64)
        r, s = raw_signature[:32], raw_signature[32:]

        def encode_der_integer(component: bytes) -> bytes:
            value = component.lstrip(b"\x00")
            if value and value[0] & 0x80:
                value = b"\x00" + value
            if not value:
                value = b"\x00"
            return b"\x02" + bytes([len(value)]) + value

        der_body = encode_der_integer(r) + encode_der_integer(s)
        der_signature = b"\x30" + bytes([len(der_body)]) + der_body

        pub_path = str(Path(self.tmp_dir.name) / "pub.pem")
        subprocess.run(
            [
                "openssl",
                "ec",
                "-in",
                str(Path(self.tmp_dir.name) / "ec.pem"),
                "-pubout",
                "-out",
                pub_path,
            ],
            check=True,
            capture_output=True,
        )
        sig_path = str(Path(self.tmp_dir.name) / "sig.der")
        with open(sig_path, "wb") as f:
            f.write(der_signature)

        verify = subprocess.run(
            [
                "openssl",
                "dgst",
                "-sha256",
                "-verify",
                pub_path,
                "-signature",
                sig_path,
            ],
            input=signing_input.encode(),
            capture_output=True,
        )
        self.assertEqual(verify.returncode, 0, verify.stdout + verify.stderr)
        self.assertIn(b"Verified OK", verify.stdout)


class _ScriptedAscClient(AscClient):
    """AscClient whose `request` returns a scripted sequence of states,
    without any real network I/O -- used to test polling logic in isolation."""

    def __init__(self, states: list[str]) -> None:
        # Deliberately skip AscClient.__init__: no real key material needed
        # since `request` is fully overridden below.
        self._states = list(states)

    def request(self, method, path, json_body=None, extra_headers=None, raw_body=None):  # noqa: D401
        del method, path, json_body, extra_headers, raw_body
        state = self._states.pop(0) if self._states else self._states_last
        self._states_last = state
        return AscResponse(status=200, body={"data": {"attributes": {"state": state}}})


class PollBackgroundAssetVersionStateTest(unittest.TestCase):
    def test_returns_state_on_known_success_state(self) -> None:
        client = _ScriptedAscClient(["PROCESSING", "READY_FOR_TESTING"])
        result = client.poll_background_asset_version_state(
            "v1", timeout_seconds=5, interval_seconds=0
        )
        self.assertEqual(result, "READY_FOR_TESTING")

    def test_raises_immediately_on_known_failure_state(self) -> None:
        client = _ScriptedAscClient(["FAILED_PROCESSING"])
        with self.assertRaises(AscApiError) as ctx:
            client.poll_background_asset_version_state("v1", timeout_seconds=5, interval_seconds=0)
        self.assertIn("FAILED_PROCESSING", str(ctx.exception))

    def test_raises_on_timeout_with_unrecognized_state_instead_of_silently_passing(self) -> None:
        # This is the Important-1 fix under test: an unknown state that is
        # neither a known success nor a known failure must NOT be treated as
        # success just because the poll loop timed out.
        client = _ScriptedAscClient(["SOME_UNKNOWN_STATE_NAME"])
        with self.assertRaises(AscApiError) as ctx:
            client.poll_background_asset_version_state(
                "v1", timeout_seconds=0.05, interval_seconds=0.01
            )
        message = str(ctx.exception)
        self.assertIn("SOME_UNKNOWN_STATE_NAME", message)
        self.assertIn("docs/asset-pack-cd.md", message)


class CommitBackgroundAssetUploadTest(unittest.TestCase):
    def test_commits_with_uploaded_true_and_without_checksum_attributes(self) -> None:
        captured: dict = {}

        class _CaptureClient(AscClient):
            def request(self, method, path, json_body=None, extra_headers=None, raw_body=None):
                del extra_headers, raw_body
                captured["method"] = method
                captured["path"] = path
                captured["json_body"] = json_body
                return AscResponse(status=200, body={})

        with tempfile.NamedTemporaryFile(suffix=".aar") as tmp:
            tmp.write(b"hello-asset-pack")
            tmp.flush()
            client = _CaptureClient("kid", "iss", "/dev/null")
            client.commit_background_asset_upload("upload-file-id", tmp.name)

        attributes = captured["json_body"]["data"]["attributes"]
        self.assertEqual(captured["method"], "PATCH")
        self.assertTrue(attributes["uploaded"])
        self.assertNotIn("sourceFileChecksum", attributes)
        self.assertNotIn("sourceFileChecksums", attributes)


if __name__ == "__main__":
    unittest.main()
