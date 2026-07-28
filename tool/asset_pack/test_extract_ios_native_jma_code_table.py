import json
import tempfile
import unittest
from pathlib import Path

from tool.asset_pack.extract_ios_native_jma_code_table import (
    ExtractError,
    extract_slim_jma_code_table,
)


def _full_fixture() -> dict:
    return {
        "metadata": {"type": "jma_code_table", "schema_version": "1"},
        "code_tables": {
            "area_information_prefecture_earthquake": [
                {"code": "13", "name": {"ja": "東京都"}},
            ],
            "area_information_city": [
                {"code": "1310100", "name": {"ja": "千代田区"}},
            ],
            "area_epicenter": [{"code": "999", "name": {"ja": "不要"}}],
        },
    }


class ExtractSlimJmaCodeTableTest(unittest.TestCase):
    def setUp(self) -> None:
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)

    def tearDown(self) -> None:
        self.tmp.cleanup()

    def test_keeps_only_prefecture_and_city_tables(self) -> None:
        source = self.root / "full.json"
        dest = self.root / "out" / "jma_code_table.json"
        source.write_text(json.dumps(_full_fixture()), encoding="utf-8")

        extract_slim_jma_code_table(source=source, destination=dest)

        slim = json.loads(dest.read_text(encoding="utf-8"))
        self.assertEqual(
            set(slim.keys()),
            {"code_tables"},
        )
        self.assertEqual(
            set(slim["code_tables"].keys()),
            {
                "area_information_prefecture_earthquake",
                "area_information_city",
            },
        )
        self.assertEqual(
            slim["code_tables"]["area_information_prefecture_earthquake"][0]["name"]["ja"],
            "東京都",
        )
        self.assertNotIn("area_epicenter", slim["code_tables"])
        self.assertNotIn("metadata", slim)

    def test_rejects_empty_prefecture_table(self) -> None:
        fixture = _full_fixture()
        fixture["code_tables"]["area_information_prefecture_earthquake"] = []
        source = self.root / "full.json"
        source.write_text(json.dumps(fixture), encoding="utf-8")

        with self.assertRaises(ExtractError):
            extract_slim_jma_code_table(
                source=source,
                destination=self.root / "out.json",
            )

    def test_rejects_missing_city_table(self) -> None:
        fixture = _full_fixture()
        del fixture["code_tables"]["area_information_city"]
        source = self.root / "full.json"
        source.write_text(json.dumps(fixture), encoding="utf-8")

        with self.assertRaises(ExtractError):
            extract_slim_jma_code_table(
                source=source,
                destination=self.root / "out.json",
            )


if __name__ == "__main__":
    unittest.main()
