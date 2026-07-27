import tempfile
import unittest
from pathlib import Path

from tool.asset_pack.check_asset_pack_id import (
    REPO_ROOT,
    AssetPackIdError,
    collect_declared_ids,
    verify,
)


def _write_fixture(root: Path, *, workflow_id: str, dart_id: str) -> None:
    workflow = root / ".github" / "workflows"
    workflow.mkdir(parents=True)
    (workflow / "upload-asset-pack.yaml").write_text(
        "env:\n"
        '  ASC_APP_ID: "6447546703"\n'
        f'  IOS_BACKGROUND_ASSET_PACK_ID: "{workflow_id}"\n'
        '  IOS_ASSET_PACK_XCODE_VERSION: "26.3"\n',
        encoding="utf-8",
    )
    dart = root / "packages" / "assets_util" / "lib"
    dart.mkdir(parents=True)
    (dart / "assets_util.dart").write_text(
        f"const _iosAssetPackIdentifier = '{dart_id}';\n"
        "const _androidAssetPackName = 'eqmonitor_assets';\n",
        encoding="utf-8",
    )


class VerifyTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp_dir = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp_dir.name)

    def tearDown(self) -> None:
        self.tmp_dir.cleanup()

    def test_passes_when_every_declaration_agrees(self) -> None:
        _write_fixture(self.root, workflow_id="eqmonitor-assets", dart_id="eqmonitor-assets")

        self.assertEqual(verify("eqmonitor-assets", self.root), "eqmonitor-assets")

    def test_rejects_reverse_dns_ids_that_app_store_connect_refuses(self) -> None:
        _write_fixture(
            self.root,
            workflow_id="net.yumnumm.eqmonitor.assets",
            dart_id="net.yumnumm.eqmonitor.assets",
        )

        with self.assertRaises(AssetPackIdError) as ctx:
            verify("net.yumnumm.eqmonitor.assets", self.root)

        self.assertIn("ITMS-91133", str(ctx.exception))

    def test_rejects_ids_with_underscores_or_edge_hyphens(self) -> None:
        _write_fixture(self.root, workflow_id="eqmonitor-assets", dart_id="eqmonitor-assets")

        for invalid in ("eqmonitor_assets", "-eqmonitor-assets", "eqmonitor-assets-", ""):
            with self.subTest(asset_pack_id=invalid), self.assertRaises(AssetPackIdError):
                verify(invalid, self.root)

    def test_reports_the_drifting_declaration_site(self) -> None:
        _write_fixture(self.root, workflow_id="eqmonitor-assets", dart_id="eqmonitor-legacy")

        with self.assertRaises(AssetPackIdError) as ctx:
            verify("eqmonitor-assets", self.root)

        message = str(ctx.exception)
        self.assertIn("packages/assets_util/lib/assets_util.dart", message)
        self.assertIn("eqmonitor-legacy", message)
        self.assertNotIn("upload-asset-pack.yaml", message)

    def test_fails_loudly_when_a_declaration_disappears(self) -> None:
        _write_fixture(self.root, workflow_id="eqmonitor-assets", dart_id="eqmonitor-assets")
        (self.root / "packages" / "assets_util" / "lib" / "assets_util.dart").write_text(
            "const _androidAssetPackName = 'eqmonitor_assets';\n", encoding="utf-8"
        )

        with self.assertRaises(AssetPackIdError) as ctx:
            verify("eqmonitor-assets", self.root)

        self.assertIn("_iosAssetPackIdentifier", str(ctx.exception))


class RealRepositoryTest(unittest.TestCase):
    def test_the_checked_in_declarations_are_consistent(self) -> None:
        declared = set(collect_declared_ids(REPO_ROOT).values())

        self.assertEqual(declared, {"eqmonitor-assets"})


if __name__ == "__main__":
    unittest.main()
