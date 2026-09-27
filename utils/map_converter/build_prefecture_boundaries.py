"""Convert the JMA prefecture ZIP to the bundled display-only GeoJSON asset.

Usage: python3 utils/map_converter/build_prefecture_boundaries.py INPUT.zip
Requires GDAL (ogr2ogr). Source and simplification policy: docs/knowledge/
20260927_prefecture_selection_boundaries.md.
"""

import gzip
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile


def main():
    with tempfile.TemporaryDirectory() as directory:
        work = Path(directory)
        with zipfile.ZipFile(sys.argv[1]) as archive:
            for name in archive.namelist():
                suffix = Path(name).suffix.lower()
                if suffix in {".shp", ".shx", ".dbf"}:
                    (work / f"prefectures{suffix}").write_bytes(archive.read(name))
        output = work / "prefectures.geojson"
        subprocess.run([
            "ogr2ogr", "-f", "GeoJSON", str(output),
            str(work / "prefectures.shp"), "-select", "code",
            "-simplify", "0.001", "-lco", "COORDINATE_PRECISION=5",
        ], check=True)
        data = json.loads(output.read_text())
        codes = [feature["properties"]["code"] for feature in data["features"]]
        assert sorted(codes) == [f"{code:02}" for code in range(1, 48)]
        encoded = json.dumps(data, ensure_ascii=False, separators=(",", ":")).encode()
        target = Path(__file__).resolve().parents[2] / "app/assets/prefecture_boundaries.geojson.gz"
        target.write_bytes(gzip.compress(encoded, mtime=0))


if __name__ == "__main__":
    main()
