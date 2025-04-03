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
logger = logging.getLogger("GIS_MVT_Converter")
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

# GeoJSONからMVT・PMTiles形式に変換するスクリプト（Python版）


def check_tippecanoe():
    """tippecanoeがインストールされているか確認"""
    try:
        result = subprocess.run(
            ["tippecanoe", "--version"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=False,
        )
        return result.returncode == 0
    except FileNotFoundError:
        return False


def convert_to_mvt(input_files, output_file, min_zoom, max_zoom, options=None):
    """GeoJSONファイルをMVT形式に変換"""
    if options is None:
        options = []

    try:
        cmd = (
            [
                "tippecanoe",
                "-o",
                output_file,
                f"-Z{min_zoom}",
                f"-z{max_zoom}",
                "--force",
            ]
            + options
            + input_files
        )

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


def find_geojson_files():
    """GeoJSONファイルを検索"""
    geojson_files = glob.glob("data/geojson/*.geojson")

    if not geojson_files:
        logger.error("GeoJSONファイルが見つかりませんでした")
        logger.info("まず convert_to_geojson.py を実行してください")
        return []

    logger.info(f"{Fore.GREEN}{len(geojson_files)}個のGeoJSONファイルが見つかりました")
    return geojson_files


def main():
    logger.info(f"{Fore.CYAN}{Style.BRIGHT}GeoJSONからMVT・PMTiles形式に変換します...")

    # tippecanoeがインストールされているか確認
    if not check_tippecanoe():
        logger.error("tippecanoe がインストールされていません")
        logger.info("インストール方法: brew install tippecanoe (macOS)")
        logger.info("または https://github.com/felt/tippecanoe からインストール")
        sys.exit(1)

    # GeoJSONファイルを検索
    geojson_files = find_geojson_files()

    if not geojson_files:
        sys.exit(1)

    # 出力ディレクトリを作成
    os.makedirs("data/mvt", exist_ok=True)
    os.makedirs("data/pmtiles", exist_ok=True)

    # 個別ファイルの変換
    logger.info(f"{Fore.YELLOW}個別ファイルをMVT形式に変換しています...")
    success_individual = 0
    for geojson_file in tqdm(
        geojson_files,
        desc=f"{Fore.BLUE}個別変換",
        bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.CYAN, Fore.RESET),
    ):
        filename = os.path.basename(geojson_file)
        basename = os.path.splitext(filename)[0]
        output_mvt = f"data/mvt/{basename}.mvt"

        logger.info(f"{Fore.YELLOW}変換中: {basename}")
        if convert_to_mvt([geojson_file], output_mvt, 1, 14, []):
            logger.info(f"{Fore.GREEN}  成功: {output_mvt}")
            success_individual += 1
        else:
            logger.error(f"  失敗: {basename}")

    # 統合ファイルの変換（MVT）
    logger.info(f"\n{Fore.YELLOW}すべてのデータを統合したMVTを作成しています...")
    output_combined_mvt = "data/mvt/earthquake_tsunami_all.mvt"
    success_combined_mvt = convert_to_mvt(geojson_files, output_combined_mvt, 1, 14, [])

    if success_combined_mvt:
        logger.info(f"{Fore.GREEN}成功: {output_combined_mvt}")
    else:
        logger.error(f"失敗: {output_combined_mvt}")

    # 統合ファイルの変換（PMTiles）
    logger.info(f"\n{Fore.YELLOW}すべてのデータを統合したPMTilesを作成しています...")
    output_combined_pmtiles = "data/pmtiles/earthquake_tsunami_all.pmtiles"
    success_combined_pmtiles = convert_to_mvt(
        geojson_files, output_combined_pmtiles, 1, 14, []
    )

    if success_combined_pmtiles:
        logger.info(f"{Fore.GREEN}成功: {output_combined_pmtiles}")
    else:
        logger.error(f"失敗: {output_combined_pmtiles}")

    # 結果表示
    logger.info(f"\n{Fore.CYAN}変換結果:")
    logger.info(
        f"- 個別ファイル: {success_individual}/{len(geojson_files)}ファイル成功"
    )
    logger.info(f"- 統合MVTファイル: {'成功' if success_combined_mvt else '失敗'}")
    logger.info(
        f"- 統合PMTilesファイル: {'成功' if success_combined_pmtiles else '失敗'}"
    )

    # 作成されたファイルを表示
    if success_individual > 0 or success_combined_mvt or success_combined_pmtiles:
        logger.info(f"\n{Fore.CYAN}作成されたファイル:")
        if success_individual > 0:
            for mvt_file in glob.glob("data/mvt/*.mvt"):
                size = os.path.getsize(mvt_file) / (1024 * 1024)  # サイズをMB単位で計算
                logger.info(f"- {mvt_file} ({size:.2f} MB)")
        if success_combined_pmtiles:
            for pmtiles_file in glob.glob("data/pmtiles/*.pmtiles"):
                size = os.path.getsize(pmtiles_file) / (
                    1024 * 1024
                )  # サイズをMB単位で計算
                logger.info(f"- {pmtiles_file} ({size:.2f} MB)")
    else:
        logger.error("MVT・PMTilesファイルが生成されませんでした")
        sys.exit(1)


if __name__ == "__main__":
    main()
