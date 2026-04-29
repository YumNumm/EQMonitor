#!/usr/bin/env python3
"""
JMA vxse45 サンプルデータを EewItemWithRelations API 形式に変換して
app/assets/debug/eew/ に配置するスクリプト。

使い方:
  python3 scripts/convert_debug_eew.py
"""

import json
import os
import re
import ssl
from datetime import datetime, timezone
from urllib.request import urlopen
from urllib.error import URLError

# macOS の Python 3 は certifi を必要とすることがあるため SSL 検証を無効化
_SSL_CTX = ssl.create_default_context()
_SSL_CTX.check_hostname = False
_SSL_CTX.verify_mode = ssl.CERT_NONE

S3_BASE = "https://sample.dmdata.jp"
EEW_PREFIX = "eew/20240101161010/vxse45/json/"
OUTPUT_DIR = os.path.join(
    os.path.dirname(__file__), "..", "app", "assets", "debug", "eew", "noto_peninsula_20240101"
)

STATUS_MAP = {"通常": "NORMAL", "訓練": "TRAINING", "試験": "TEST"}
INFO_TYPE_MAP = {"発表": "PUBLICATION", "訂正": "CORRECTION", "遅延": "DELAY", "取消": "CANCELLATION"}
WARNING_CODE = "31"


def to_utc(dt_str: str | None) -> str | None:
    if not dt_str:
        return None
    dt = datetime.fromisoformat(dt_str)
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    return dt.astimezone(timezone.utc).strftime("%Y-%m-%dT%H:%M:%S.000Z")


def convert_intensity_value(jma_value: str) -> dict:
    """JMA 震度文字列 → {"value": "...", "is_over": bool}"""
    is_over = jma_value.endswith("以上")
    val = jma_value.replace("以上", "").strip()
    # 5弱 → 5-, 5強 → 5+, 6弱 → 6-, 6強 → 6+
    val = val.replace("弱", "-").replace("強", "+")
    return {"value": val, "is_over": is_over}


def convert_lpgm_value(jma_value: str | None) -> dict | None:
    if not jma_value:
        return None
    is_over = jma_value.endswith("以上")
    val = jma_value.replace("以上", "").strip()
    return {"value": val, "is_over": is_over}


def convert_hypocenter(hypo: dict) -> dict:
    coord = hypo.get("coordinate", {})
    lat_obj = coord.get("latitude", {})
    lng_obj = coord.get("longitude", {})
    lat = lat_obj.get("value") if lat_obj else None
    lng = lng_obj.get("value") if lng_obj else None
    condition = lat_obj.get("condition") if lat_obj else None

    depth_obj = hypo.get("depth", {})
    depth_val = depth_obj.get("value") if depth_obj else None

    mag_obj = hypo.get("magnitude", {})
    mag_val = mag_obj.get("value") if mag_obj else None

    result = {
        "value": {"code": hypo.get("code", ""), "name": hypo.get("name", "")},
        "coordinates": {
            "type": "LAT_LNG" if (lat is not None and lng is not None) else "UNKNOWN",
            "latitude": float(lat) if lat else None,
            "longitude": float(lng) if lng else None,
        },
        "magnitude": float(mag_val) if mag_val else None,
        "depth": int(depth_val) if depth_val else None,
    }
    if condition:
        result["coordinates"]["condition"] = condition
    if hypo.get("detailedCode") or hypo.get("detailedName"):
        result["detailed"] = {
            "code": hypo.get("detailedCode", ""),
            "name": hypo.get("detailedName", ""),
        }
    return result


def convert_accuracy(acc: dict | None) -> dict | None:
    if not acc:
        return None
    return {
        "epicenter": int(acc.get("epicenter", {}).get("value", 0) if isinstance(acc.get("epicenter"), dict) else acc.get("epicenter", 0)),
        "hypocenter": int(acc.get("hypocenter", {}).get("value", 0) if isinstance(acc.get("hypocenter"), dict) else acc.get("hypocenter", 0)),
        "depth": int(acc.get("depth", {}).get("value", 0) if isinstance(acc.get("depth"), dict) else acc.get("depth", 0)),
        "magnitude_calculation": int(acc.get("magnitudeCalculation", {}).get("value", 0) if isinstance(acc.get("magnitudeCalculation"), dict) else acc.get("magnitudeCalculation", 0)),
        "number_of_magnitude_calculation": int(acc.get("numberOfMagnitudeCalculation", {}).get("value", 0) if isinstance(acc.get("numberOfMagnitudeCalculation"), dict) else acc.get("numberOfMagnitudeCalculation", 0)),
    }


def convert_region(region: dict) -> dict:
    arrival_time_str = region.get("arrivalTime")
    if arrival_time_str == "到達":
        arrival_time = {"type": "ARRIVED"}
    elif arrival_time_str:
        arrival_time = {"type": "TIME", "value": to_utc(arrival_time_str)}
    else:
        arrival_time = {"type": "TIME"}

    intensity_obj = region.get("forecastMaxInt", {})
    intensity_val = intensity_obj.get("to") or intensity_obj.get("from", "0")

    lpgm_obj = region.get("forecastMaxLpgmInt")
    lpgm_val = lpgm_obj.get("to") if lpgm_obj else None

    kind = region.get("kind", {})
    is_warning = kind.get("code") == WARNING_CODE if kind else False

    return {
        "value": {"code": region.get("code", ""), "name": region.get("name", "")},
        "is_plum": region.get("isPlum", False),
        "is_warning": is_warning,
        "intensity": convert_intensity_value(intensity_val),
        "arrival_time": arrival_time,
        "lpgm_intensity": convert_lpgm_value(lpgm_val),
    }


def convert_warning_zone(zone: dict) -> dict:
    kind = zone.get("kind", {})
    had_warning = kind.get("code") == WARNING_CODE if kind else False
    return {
        "value": {"code": zone.get("code", ""), "name": zone.get("name", "")},
        "had_warning": had_warning,
    }


def convert_jma_to_api(jma: dict) -> dict:
    body = jma.get("body", {})
    earthquake = body.get("earthquake", {})
    intensity_body = body.get("intensity", {})
    hypo = earthquake.get("hypocenter")

    # forecast_intensity
    forecast_intensity = None
    if intensity_body:
        max_int_obj = intensity_body.get("forecastMaxInt", {})
        max_int_val = max_int_obj.get("to") or max_int_obj.get("from")
        max_lpgm_obj = intensity_body.get("forecastMaxLpgmInt")
        max_lpgm_val = max_lpgm_obj.get("to") if max_lpgm_obj else None
        regions = [convert_region(r) for r in intensity_body.get("regions", [])]
        forecast_intensity = {
            "regions": regions,
            "max_intensity": convert_intensity_value(max_int_val) if max_int_val else None,
            "max_lpgm_intensity": convert_lpgm_value(max_lpgm_val),
        }

    # warning
    warning = None
    zones = body.get("zones", [])
    prefectures = body.get("prefectures", [])
    regions = body.get("regions", [])
    if zones or prefectures or regions:
        warning = {
            "zones": [convert_warning_zone(z) for z in zones],
            "prefectures": [convert_warning_zone(p) for p in prefectures],
            "regions": [convert_warning_zone(r) for r in regions],
        }

    result = {
        "event_id": jma.get("eventId", ""),
        "type": "VXSE45",
        "status": STATUS_MAP.get(jma.get("status", ""), "NORMAL"),
        "info_type": INFO_TYPE_MAP.get(jma.get("infoType", ""), "PUBLICATION"),
        "serial_no": int(jma.get("serialNo", "0")),
        "headline": jma.get("headline"),
        "is_canceled": body.get("isCanceled", False),
        "is_warning": body.get("isWarning"),
        "is_last_info": body.get("isLastInfo", False),
        "origin_time": to_utc(earthquake.get("originTime")),
        "arrival_time": to_utc(earthquake.get("arrivalTime")),
        "accuracy": convert_accuracy(earthquake.get("accuracy")),
        "is_plum": earthquake.get("isPlum", False),
        "editorial_office": jma.get("editorialOffice"),
        "report_time": to_utc(jma.get("reportDateTime")),
    }
    if hypo:
        result["hypocenter"] = convert_hypocenter(hypo)
    if forecast_intensity:
        result["forecast_intensity"] = forecast_intensity
    if warning:
        result["warning"] = warning

    return result


def fetch_s3_keys(prefix: str) -> list[str]:
    """S3 ListObjects XML から指定プレフィックス配下の .json キーを取得する"""
    url = f"{S3_BASE}/?prefix={prefix}"
    with urlopen(url, context=_SSL_CTX) as resp:
        xml = resp.read().decode("utf-8")
    keys = re.findall(r'<Key>([^<]+\.json)</Key>', xml)
    return sorted(keys)


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    print(f"Listing S3 keys for prefix: {EEW_PREFIX}")
    keys = fetch_s3_keys(EEW_PREFIX)
    if not keys:
        print("ERROR: No JSON keys found.")
        return

    print(f"Found {len(keys)} JSON files")

    converted = []
    file_names = []

    for i, key in enumerate(keys, start=1):
        url = f"{S3_BASE}/{key}"
        print(f"  [{i:02d}/{len(keys)}] {key}")
        with urlopen(url, context=_SSL_CTX) as resp:
            jma_data = json.loads(resp.read().decode("utf-8"))
        api_data = convert_jma_to_api(jma_data)
        serial = api_data["serial_no"]
        fname = f"{serial:02d}.json"
        out_path = os.path.join(OUTPUT_DIR, fname)
        with open(out_path, "w", encoding="utf-8") as f:
            json.dump(api_data, f, ensure_ascii=False, indent=2)
        converted.append(api_data)
        file_names.append(fname)

    # reportTime でソートしたファイル名リスト
    file_names_sorted = [
        f"{c['serial_no']:02d}.json"
        for c in sorted(converted, key=lambda x: x["report_time"] or "")
    ]

    index = {
        "name": "能登半島地震 EEW (2024-01-01)",
        "eventId": converted[0]["event_id"] if converted else "20240101161010",
        "files": file_names_sorted,
    }
    index_path = os.path.join(OUTPUT_DIR, "index.json")
    with open(index_path, "w", encoding="utf-8") as f:
        json.dump(index, f, ensure_ascii=False, indent=2)

    print(f"\nDone! {len(converted)} files saved to {OUTPUT_DIR}")
    print(f"Index: {index_path}")


if __name__ == "__main__":
    main()
