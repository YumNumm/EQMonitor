"""Guard Flutter setup against repo archive extraction and private submodule fetches."""

import json
from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[2]


class FlutterJobSetupTest(unittest.TestCase):
    def test_public_submodule_after_checkout(self):
        cases = {
            "deploy-app.yaml": ("build-ios", "build-android"),
            "wc-check-dart-analyze.yaml": ("flutter-analyze",),
            "wc-check-dart-test.yaml": ("flutter-test",),
        }
        for filename, jobs in cases.items():
            workflow = json.loads(subprocess.check_output(
                ["mise", "exec", "yq", "--", "yq", "-o=json", ".",
                 str(ROOT / ".github/workflows" / filename)], text=True,
            ))
            for job in jobs:
                with self.subTest(workflow=filename, job=job):
                    steps = workflow["jobs"][job]["steps"]
                    checkout = next(i for i, step in enumerate(steps)
                                    if step.get("uses", "").startswith("actions/checkout@"))
                    init = next(i for i, step in enumerate(steps)
                                if step.get("name") == "Init flutter_scene submodule")
                    self.assertLess(checkout, init)
                    self.assertNotIn("submodules", steps[checkout].get("with", {}))
                    self.assertEqual(
                        steps[init]["run"],
                        "git submodule update --init --depth 1 third_party/flutter_scene",
                    )
                    for step in steps:
                        self.assertFalse(step.get("uses", "").startswith(
                            ("$/", "YumNumm/EQMonitor@", "YumNumm/EQMonitor/")),
                            "Repo action downloads encounter dangling symlinks")


if __name__ == "__main__":
    unittest.main()
