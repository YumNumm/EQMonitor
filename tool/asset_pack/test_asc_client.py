import base64
import json
import subprocess
import tempfile
import unittest
from pathlib import Path

from tool.asset_pack.asc_client import build_es256_jwt


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


if __name__ == "__main__":
    unittest.main()
