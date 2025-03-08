#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import subprocess
import sys
import glob
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
logger = logging.getLogger("GIS_Converter")
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

# シェープファイルからGeoJSONへの変換スクリプト（Python版）


def check_ogr2ogr():
    """ogr2ogrがインストールされているか確認"""
    try:
        result = subprocess.run(
            ["ogr2ogr", "--version"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=False,
        )
        return result.returncode == 0
    except FileNotFoundError:
        return False


def convert_shapefile_to_geojson(input_dir, output_file, shp_file=None):
    """シェープファイルをGeoJSONに変換"""
    try:
        # 入力ファイルを指定（シェープファイルが見つかった場合）
        input_path = shp_file if shp_file and os.path.exists(shp_file) else input_dir

        # コマンドを構築
        cmd = [
            "ogr2ogr",
            "-f",
            "GeoJSON",
            "-s_srs",
            "EPSG:4326",  # 入力の座標系を指定
            "-t_srs",
            "EPSG:4326",  # 出力の座標系を指定
            "-skipfailures",  # エラーがあってもスキップ
            output_file,
            input_path,
        ]

        logger.info(f"実行コマンド: {' '.join(cmd)}")

        result = subprocess.run(
            cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True
        )
        return True
    except subprocess.CalledProcessError as e:
        logger.error(f"変換コマンドの実行中にエラーが発生しました: {e}")
        logger.error(f"STDERR: {e.stderr}")
        return False
    except Exception as e:
        logger.error(f"変換中に予期しないエラーが発生しました: {e}")
        return False


def find_shapefile_dirs():
    """data/rawディレクトリから関連するシェープファイルディレクトリを検索"""
    search_patterns = {
        "AreaInformationCity_quake": "市町村等（地震津波関係）",
        "AreaForecastLocalEEW": "緊急地震速報／府県予報区",
        "AreaForecastLocalE": "地震情報／細分区域",
        "AreaInformationPrefectureEarthquake": "地震情報／都道府県",
        "AreaTsunami": "津波予報区",
    }

    dirs = {}
    # 実際のディレクトリをリスト表示（デバッグ用）
    logger.info(f"{Fore.CYAN}検出されたディレクトリ:")
    for dirpath, dirnames, filenames in os.walk("data/raw"):
        for dirname in dirnames:
            full_path = os.path.join(dirpath, dirname)
            logger.debug(f"- {full_path}")

    # シェープファイルを含むディレクトリを検索
    for dirpath, dirnames, filenames in os.walk("data/raw"):
        # シェープファイルを直接検索
        shp_files = glob.glob(os.path.join(dirpath, "**/*.shp"), recursive=True)
        if shp_files:
            # パターンマッチングでデータの種類を決定
            matched = False
            for pattern, description in search_patterns.items():
                if pattern in dirpath:
                    dirs[pattern] = {
                        "path": dirpath,
                        "description": description,
                        "shp_file": shp_files[0],
                    }
                    matched = True
                    logger.debug(f"マッチしました: {pattern} -> {shp_files[0]}")
                    break

            # パターンが一致しない場合でも、シェープファイルが見つかればそれを使用
            if not matched and shp_files:
                # ディレクトリ名だけだと重複する可能性があるため、階層を追加
                base_name = os.path.basename(dirpath)
                for shp_file in shp_files:
                    # シェープファイル名から.shpを除いて識別子として使用
                    shp_base = os.path.splitext(os.path.basename(shp_file))[0]
                    key = f"{base_name}_{shp_base}"
                    # 日本語ファイル名を持つシェープファイルをスキップ
                    if not any(ord(c) > 127 for c in shp_base):
                        dirs[key] = {
                            "path": dirpath,
                            "description": f"未分類データ: {shp_base}",
                            "shp_file": shp_file,
                        }
                        logger.info(
                            f"{Fore.MAGENTA}未分類のシェープファイルが見つかりました: {dirpath} -> {shp_file}"
                        )

    # 見つかったシェープファイルの数を表示
    if dirs:
        logger.info(
            f"{Fore.GREEN}{len(dirs)}個のシェープファイル/ディレクトリが見つかりました"
        )
    else:
        logger.warning("シェープファイルが見つかりませんでした")

    return dirs


def main():
    logger.info(f"{Fore.CYAN}{Style.BRIGHT}シェープファイルをGeoJSONに変換します...")

    # ogr2ogrがインストールされているか確認
    if not check_ogr2ogr():
        logger.error("ogr2ogr (GDALツール) がインストールされていません")
        logger.info(
            "インストール方法: brew install gdal (macOS) または apt-get install gdal-bin (Ubuntu)"
        )
        sys.exit(1)

    # シェープファイルディレクトリを検索
    shapefile_dirs = find_shapefile_dirs()

    if not shapefile_dirs:
        logger.error("変換するシェープファイルが見つかりませんでした")
        logger.info(
            "まず download_jma_data.py を実行して、データをダウンロードしてください"
        )
        sys.exit(1)

    # 変換処理
    success_count = 0
    for pattern, info in tqdm(
        shapefile_dirs.items(),
        desc=f"{Fore.CYAN}変換中",
        bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.BLUE, Fore.RESET),
    ):
        input_dir = info["path"]
        description = info["description"]
        shp_file = info.get("shp_file")
        output_file = f"data/geojson/{pattern}.geojson"

        logger.info(f"{Fore.YELLOW}変換中: {description} ({pattern})")
        if convert_shapefile_to_geojson(input_dir, output_file, shp_file):
            logger.info(f"{Fore.GREEN}  成功: {output_file}")
            success_count += 1
        else:
            logger.error(f"  失敗: {pattern}")

    # 結果表示
    if success_count == len(shapefile_dirs):
        logger.info(
            f"{Fore.GREEN}{Style.BRIGHT}すべての変換が完了しました（{success_count}/{len(shapefile_dirs)}）"
        )
    else:
        logger.warning(
            f"変換が一部失敗しました（成功: {success_count}/{len(shapefile_dirs)}）"
        )

    if success_count > 0:
        logger.info(f"{Fore.CYAN}変換されたGeoJSONファイル:")
        for geojson_file in glob.glob("data/geojson/*.geojson"):
            logger.info(f"- {geojson_file}")
    else:
        logger.error("GeoJSONファイルが生成されませんでした")
        sys.exit(1)


if __name__ == "__main__":
    main()
