"""Exercise mise-action's curl invocation with transient and persistent failures."""

from http.server import BaseHTTPRequestHandler, HTTPServer
import os
from pathlib import Path
import subprocess
import tempfile
import threading
import unittest

ROOT = Path(__file__).resolve().parents[2]


class MiseDownloadRetryTest(unittest.TestCase):
    def download(self, failures):
        attempts = []

        class Handler(BaseHTTPRequestHandler):
            def do_GET(self):
                attempts.append(self.path)
                failed = len(attempts) <= failures
                self.send_response(503 if failed else 200)
                self.end_headers()
                self.wfile.write(b"unavailable" if failed else b"verified-download")

            def log_message(self, *args):
                pass

        with HTTPServer(("127.0.0.1", 0), Handler) as server:
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            try:
                with tempfile.TemporaryDirectory() as directory:
                    target = Path(directory) / "mise.tar.zst"
                    result = subprocess.run(
                        ["curl", "-fsSL", f"http://127.0.0.1:{server.server_port}/mise",
                         "--output", str(target)],
                        env={**os.environ,
                             "CURL_HOME": str(ROOT / "scripts/ci/mise-curl"),
                             "NO_PROXY": "127.0.0.1"},
                        capture_output=True, timeout=20,
                    )
                    content = target.read_bytes() if target.exists() else b""
            finally:
                server.shutdown()
                thread.join()
        return result.returncode, content, len(attempts)

    def test_recovers_from_transient_download_errors(self):
        code, content, attempts = self.download(failures=2)
        self.assertEqual(code, 0)
        self.assertEqual(content, b"verified-download")
        self.assertEqual(attempts, 3)

    def test_persistent_error_still_fails_after_bounded_retries(self):
        code, content, attempts = self.download(failures=10)
        self.assertEqual(code, 22)
        self.assertEqual(content, b"")
        self.assertEqual(attempts, 4)


if __name__ == "__main__":
    unittest.main()
