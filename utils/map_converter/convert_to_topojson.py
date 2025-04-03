#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import glob
import json
import logging
from tqdm import tqdm

# coloramaをインポート（色付きの出力用）
try:
    from colorama import init, Fore, Style

    init(autoreset=True)  # カラー出力の初期化
    COLORS_ENABLED = True
except ImportError:
    # coloramaがインストールされていない場合のフォールバック
    class DummyFore:
        RED = YELLOW = GREEN = BLUE = CYAN = MAGENTA = ""

    class DummyStyle:
        BRIGHT = RESET_ALL = ""

    Fore = DummyFore()
    Style = DummyStyle()
    COLORS_ENABLED = False
    print("注意: 色付き出力を有効にするには 'pip install colorama' を実行してください")

# ロガーの設定
logger = logging.getLogger("TopoJSON_Converter")
logger.setLevel(logging.INFO)

# コンソールハンドラの作成
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# フォーマッタの作成（色付き）
class ColoredFormatter(logging.Formatter):
    """色付きのフォーマッタ"""

    FORMATS = {
        logging.DEBUG: f"{Fore.BLUE}[DEBUG] %(message)s{Style.RESET_ALL}",
        logging.INFO: f"{Fore.GREEN}[INFO] %(message)s{Style.RESET_ALL}",
        logging.WARNING: f"{Fore.YELLOW}[警告] %(message)s{Style.RESET_ALL}",
        logging.ERROR: f"{Fore.RED}[エラー] %(message)s{Style.RESET_ALL}",
        logging.CRITICAL: f"{Fore.RED}{Style.BRIGHT}[致命的] %(message)s{Style.RESET_ALL}",
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


console_handler.setFormatter(ColoredFormatter())
logger.addHandler(console_handler)


def ensure_output_dir():
    """出力ディレクトリの確保"""
    output_dir = "data/topojson"
    os.makedirs(output_dir, exist_ok=True)
    return output_dir


def read_geojson(file_path):
    """GeoJSONファイルを読み込む"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        logger.error(f"GeoJSONファイルの読み込み中にエラーが発生しました: {e}")
        return None


def fix_geojson(geojson_data):
    """GeoJSONデータを修正する"""
    if not geojson_data:
        return None

    # 必要なプロパティが含まれているか確認
    if "type" not in geojson_data:
        geojson_data["type"] = "FeatureCollection"

    # featuresの確認と修正
    if "features" not in geojson_data or not geojson_data["features"]:
        return None

    # 各フィーチャーを確認
    valid_features = []
    for feature in geojson_data["features"]:
        if "geometry" in feature and feature["geometry"] and "type" in feature:
            valid_features.append(feature)

    if not valid_features:
        return None

    geojson_data["features"] = valid_features
    return geojson_data


def convert_to_topojson(geojson_path, output_file, prequantize=False):
    """GeoJSONをTopoJSONに変換"""
    try:
        import topojson

        # GeoJSONを読み込む
        with open(geojson_path, 'r', encoding='utf-8') as f:
            geojson_data = json.load(f)

        # 特定のファイルに対する個別処理
        file_name = os.path.basename(geojson_path)
        if file_name == "AreaForecastLocalE.geojson":
            geojson_data = fix_geojson(geojson_data)
            if not geojson_data:
                logger.warning(f"ファイルの修正に失敗しました: {file_name}")
                return False

        # TopoJSONに変換
        # prequantize=Falseで事前量子化を無効化
        # 必要に応じてtoposimplifyを適用することも可能
        topo = topojson.Topology(geojson_data, prequantize=prequantize)

        # TopoJSONとしてファイルに保存（to_dictメソッドでJSONシリアライズ可能な辞書に変換）
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(topo.to_dict(), f, ensure_ascii=False)

        return True
    except Exception as e:
        logger.error(f"TopoJSONへの変換中にエラーが発生しました: {e}")
        return False


def main():
    logger.info(f"{Fore.CYAN}{Style.BRIGHT}GeoJSONをTopoJSONに変換します...")

    # 出力ディレクトリの確保
    output_dir = ensure_output_dir()

    # 縮小されたGeoJSONファイルのパターン
    geojson_dir = "data/geojson_shrinked"
    geojson_files = glob.glob(f"{geojson_dir}/*.geojson")

    if not geojson_files:
        logger.error(f"変換するGeoJSONファイルが見つかりませんでした: {geojson_dir}")
        sys.exit(1)

    # 変換処理
    success_count = 0
    for geojson_file in tqdm(
        geojson_files,
        desc=f"{Fore.CYAN}変換中",
        bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.BLUE, Fore.RESET),
    ):
        file_name = os.path.basename(geojson_file)
        output_file = os.path.join(output_dir, file_name.replace(".geojson", ".topojson"))

        logger.info(f"{Fore.YELLOW}変換中: {file_name}")

        # TopoJSONに変換
        if convert_to_topojson(geojson_file, output_file):
            logger.info(f"{Fore.GREEN}  成功: {output_file}")
            success_count += 1
        else:
            logger.error(f"  失敗: {file_name}")

    # 結果表示
    if success_count == len(geojson_files):
        logger.info(
            f"{Fore.GREEN}{Style.BRIGHT}すべての変換が完了しました（{success_count}/{len(geojson_files)}）"
        )
    else:
        logger.warning(
            f"変換が一部失敗しました（成功: {success_count}/{len(geojson_files)}）"
        )

    if success_count > 0:
        logger.info(f"{Fore.CYAN}変換されたTopoJSONファイル:")
        for topojson_file in glob.glob(f"{output_dir}/*.topojson"):
            logger.info(f"- {topojson_file}")
    else:
        logger.error("TopoJSONファイルが生成されませんでした")
        sys.exit(1)


if __name__ == "__main__":
    main()
