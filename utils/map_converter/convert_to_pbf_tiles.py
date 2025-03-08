#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import subprocess
import sys
import glob
import logging
import shutil
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
logger = logging.getLogger("GIS_PBF_Tiles_Converter")
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

# GeoJSONからPBF Tiles・PMTiles形式に変換するスクリプト（Python版）


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


def convert_to_pbf_xyz(input_files, output_dir, min_zoom, max_zoom, options=None):
    """GeoJSONファイルをPBF XYZ形式に変換"""
    if options is None:
        options = []

    try:
        # フォルダが存在する場合は削除して再作成
        if os.path.exists(output_dir):
            logger.info(f"{Fore.YELLOW}出力先ディレクトリを削除します: {output_dir}")
            shutil.rmtree(output_dir)
        os.makedirs(output_dir, exist_ok=True)

        # -eオプションでディレクトリ出力形式にする
        cmd = (
            [
                "tippecanoe",
                "-e",
                output_dir,  # ディレクトリ出力（XYZ形式）
                f"-Z{min_zoom}",
                f"-z{max_zoom}",
                "--force",
                "--no-tile-compression",  # PBF形式で出力
            ]
            + options
            + input_files
        )

        logger.info(f"実行コマンド: {' '.join(cmd)}")

        # 標準出力と標準エラー出力を直接表示するように変更
        result = subprocess.run(cmd, check=True)
        return True
    except subprocess.CalledProcessError as e:
        logger.error(f"変換コマンドの実行中にエラーが発生しました: {e}")
        return False
    except Exception as e:
        logger.error(f"変換中に予期しないエラーが発生しました: {e}")
        return False


def convert_to_pmtiles(input_files, output_file, min_zoom, max_zoom, options=None):
    """GeoJSONファイルをPMTiles形式に変換"""
    if options is None:
        options = []

    try:
        cmd = (
            [
                "tippecanoe",
                "-o",
                output_file,  # 単一ファイル出力
                f"-Z{min_zoom}",
                f"-z{max_zoom}",
                "--force",
            ]
            + options
            + input_files
        )

        logger.info(f"実行コマンド: {' '.join(cmd)}")

        # 標準出力と標準エラー出力を直接表示するように変更
        result = subprocess.run(cmd, check=True)
        return True
    except subprocess.CalledProcessError as e:
        logger.error(f"変換コマンドの実行中にエラーが発生しました: {e}")
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
    logger.info(
        f"{Fore.CYAN}{Style.BRIGHT}GeoJSONからPBF Tiles (XYZ)・PMTiles形式に変換します..."
    )

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
    os.makedirs("data/pbf_tiles", exist_ok=True)
    os.makedirs("data/pmtiles", exist_ok=True)

    # 個別ファイルの変換
    logger.info(f"{Fore.YELLOW}個別ファイルをPBF Tiles (XYZ)形式に変換しています...")
    success_individual = 0
    for geojson_file in tqdm(
        geojson_files,
        desc=f"{Fore.BLUE}個別変換",
        bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.CYAN, Fore.RESET),
    ):
        filename = os.path.basename(geojson_file)
        basename = os.path.splitext(filename)[0]
        output_dir = f"data/pbf_tiles/{basename}"

        logger.info(f"{Fore.YELLOW}変換中: {basename}")
        if convert_to_pbf_xyz(
            [geojson_file], output_dir, 1, 14, ["--drop-densest-as-needed"]
        ):
            logger.info(f"{Fore.GREEN}  成功: {output_dir}")
            success_individual += 1
        else:
            logger.error(f"  失敗: {basename}")

    # 統合ファイルの変換（PBF XYZ）
    logger.info(
        f"\n{Fore.YELLOW}すべてのデータを統合したPBF Tiles (XYZ)を作成しています..."
    )
    output_combined_dir = "data/pbf_tiles/earthquake_tsunami_all"
    success_combined_xyz = convert_to_pbf_xyz(
        geojson_files, output_combined_dir, 1, 14, ["--drop-densest-as-needed"]
    )

    if success_combined_xyz:
        logger.info(f"{Fore.GREEN}成功: {output_combined_dir}")
    else:
        logger.error(f"失敗: {output_combined_dir}")

    # 統合ファイルの変換（PMTiles）
    logger.info(f"\n{Fore.YELLOW}すべてのデータを統合したPMTilesを作成しています...")
    output_combined_pmtiles = "data/pmtiles/earthquake_tsunami_all.pmtiles"
    success_combined_pmtiles = convert_to_pmtiles(
        geojson_files, output_combined_pmtiles, 1, 14, ["--drop-densest-as-needed"]
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
    logger.info(
        f"- 統合PBF Tiles (XYZ)ファイル: {'成功' if success_combined_xyz else '失敗'}"
    )
    logger.info(
        f"- 統合PMTilesファイル: {'成功' if success_combined_pmtiles else '失敗'}"
    )

    # XYZタイルのディレクトリサイズ計算関数
    def get_dir_size(path):
        total_size = 0
        for dirpath, dirnames, filenames in os.walk(path):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                total_size += os.path.getsize(fp)
        return total_size / (1024 * 1024)  # MB単位

    # 作成されたファイルを表示
    if success_individual > 0 or success_combined_xyz or success_combined_pmtiles:
        logger.info(f"\n{Fore.CYAN}作成されたファイル:")
        if success_individual > 0:
            for pbf_dir in glob.glob("data/pbf_tiles/*"):
                if os.path.isdir(pbf_dir) and pbf_dir != output_combined_dir:
                    dir_size = get_dir_size(pbf_dir)
                    # ズームレベル数とタイル数も表示
                    zoom_levels = len(
                        [
                            d
                            for d in os.listdir(pbf_dir)
                            if os.path.isdir(os.path.join(pbf_dir, d))
                        ]
                    )
                    tile_count = sum(len(files) for _, _, files in os.walk(pbf_dir))
                    logger.info(
                        f"- {pbf_dir} ({dir_size:.2f} MB, ズームレベル: {zoom_levels}, タイル数: {tile_count})"
                    )

        if success_combined_xyz:
            dir_size = get_dir_size(output_combined_dir)
            zoom_levels = len(
                [
                    d
                    for d in os.listdir(output_combined_dir)
                    if os.path.isdir(os.path.join(output_combined_dir, d))
                ]
            )
            tile_count = sum(len(files) for _, _, files in os.walk(output_combined_dir))
            logger.info(
                f"- {output_combined_dir} ({dir_size:.2f} MB, ズームレベル: {zoom_levels}, タイル数: {tile_count})"
            )

        if success_combined_pmtiles:
            for pmtiles_file in glob.glob("data/pmtiles/*.pmtiles"):
                size = os.path.getsize(pmtiles_file) / (
                    1024 * 1024
                )  # サイズをMB単位で計算
                logger.info(f"- {pmtiles_file} ({size:.2f} MB)")
    else:
        logger.error("PBF Tiles・PMTilesファイルが生成されませんでした")
        sys.exit(1)


if __name__ == "__main__":
    main()
