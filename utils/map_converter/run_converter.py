#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import time
import importlib
import subprocess
import logging
import shutil

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
logger = logging.getLogger("GIS_Converter_Runner")
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


def run_module(module_name):
    """指定されたモジュールを実行する"""
    logger.info(
        f"{Fore.CYAN}{Style.BRIGHT}---------- {module_name} の実行を開始 ----------"
    )
    try:
        # モジュールをインポート
        module = importlib.import_module(module_name)
        # モジュールのmain関数を実行
        module.main()
        logger.info(
            f"{Fore.CYAN}{Style.BRIGHT}---------- {module_name} の実行が完了しました ----------\n"
        )
        return True
    except Exception as e:
        logger.error(f"{module_name} の実行中に問題が発生しました: {e}")
        return False


def main():
    logger.info(
        f"{Fore.CYAN}{Style.BRIGHT}気象庁GISデータの変換プロセスを開始します..."
    )
    start_time = time.time()

    # 前回の実行でデータが残っている場合は、エラーを表示して終了
    if os.path.exists("data") and any(os.listdir("data")):
        logger.warning("前回の実行データが残っています")
        # ユーザーに確認
        response = input(f"{Fore.YELLOW}データを削除して続行しますか？ (y/n): ")
        if response.lower() == "y":
            logger.info("既存のデータを削除します...")
            shutil.rmtree("data")
        else:
            logger.info("処理を中止します")
            sys.exit(0)

    # 必要なディレクトリを作成
    create_directories()

    # 変換の各ステップを定義
    steps = [
        {"name": "JMA GISデータのダウンロードと解凍", "module": "download_jma_data"},
        {"name": "ShapeファイルからGeoJSONへの変換", "module": "convert_to_geojson"},
        {
            "name": "GeoJSONからPBF Tiles (XYZ)への変換",
            "module": "convert_to_pbf_tiles",
        },
    ]

    for i, step in enumerate(steps, 1):
        logger.info(
            f"{Fore.YELLOW}ステップ {i}/{len(steps)}: {step['name']}を開始します..."
        )
        success = run_module(step["module"])
        if not success:
            logger.error(f"{step['name']}に失敗しました。処理を中止します。")
            sys.exit(1)

    # 処理時間の表示
    elapsed_time = time.time() - start_time
    minutes, seconds = divmod(elapsed_time, 60)
    logger.info(
        f"{Fore.GREEN}{Style.BRIGHT}すべての処理が完了しました！処理時間: {int(minutes)}分 {int(seconds)}秒"
    )

    # 作成されたファイルの表示
    logger.info(f"\n{Fore.CYAN}作成されたファイル:")
    output_dirs = ["data/geojson", "data/pbf_tiles", "data/pmtiles"]
    for directory in output_dirs:
        if os.path.exists(directory):
            files = os.listdir(directory)
            if files:
                logger.info(f"\n{Fore.BLUE}{directory}:")
                for file in files:
                    file_path = os.path.join(directory, file)
                    size_mb = os.path.getsize(file_path) / (1024 * 1024)
                    logger.info(f"- {file} ({size_mb:.2f} MB)")


def create_directories():
    """必要なディレクトリを作成"""
    directories = [
        "data",
        "data/download",
        "data/extract",
        "data/shapefile",
        "data/geojson",
        "data/pbf_tiles",
        "data/pmtiles",
    ]

    for directory in directories:
        os.makedirs(directory, exist_ok=True)
        logger.info(f"ディレクトリを確認: {directory}")


if __name__ == "__main__":
    main()
