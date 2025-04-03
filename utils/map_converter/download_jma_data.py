#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import requests
import zipfile
from bs4 import BeautifulSoup
from tqdm import tqdm
import re
import sys
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
logger = logging.getLogger("GIS_Downloader")
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

# 気象庁GISデータダウンロードスクリプト（Python版）


def create_dirs():
    """必要なディレクトリを作成"""
    os.makedirs("data/raw", exist_ok=True)
    os.makedirs("data/geojson", exist_ok=True)
    os.makedirs("data/pbf_tiles", exist_ok=True)
    os.makedirs("data/pmtiles", exist_ok=True)
    logger.debug("必要なディレクトリを作成しました")


def fetch_jma_links():
    """気象庁ウェブサイトからGISデータのリンクを取得"""
    # 更新: 気象庁GISデータの新しいURL
    url = "https://www.data.jma.go.jp/developer/gis.html"
    logger.info(f"{Fore.CYAN}気象庁ウェブサイト ({url}) からリンクを取得しています...")

    try:
        response = requests.get(url)
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        logger.error(f"ウェブサイトからのデータ取得に失敗しました: {e}")
        sys.exit(1)

    soup = BeautifulSoup(response.text, "html.parser")

    # URLパターンに基づいてマッピング (リンクのURLパターンから目的のデータを識別)
    url_patterns = {
        r"AreaForecastLocalEEW_GIS\.zip": r"緊急地震速報／府県予報区",
        r"AreaForecastLocalE_GIS\.zip": r"地震情報／細分区域",
        r"AreaTsunami_GIS\.zip": r"津波予報区",
        r"AreaInformationCity_quake_GIS\.zip": r"市町村等（地震津波関係）",
    }

    zip_links = {}

    # すべてのaタグを検索
    for link in soup.find_all("a", href=True):
        href = link.get("href")

        # ZIP拡張子を持つリンクだけを処理
        if href.endswith(".zip"):
            # URLパターンに一致するか確認
            for url_pattern, pattern_name in url_patterns.items():
                if re.search(url_pattern, href):
                    full_url = (
                        href
                        if href.startswith("http")
                        else f"https://www.data.jma.go.jp/developer/{href.lstrip('./')}"
                    )
                    zip_links[pattern_name] = full_url
                    logger.info(
                        f"{Fore.GREEN}見つかりました: {pattern_name} -> {full_url}"
                    )

    # パターン4つが見つからない場合はエラー
    needed_patterns = [
        r"緊急地震速報／府県予報区",
        r"地震情報／細分区域",
        r"津波予報区",
        r"市町村等（地震津波関係）",
    ]

    missing_patterns = [p for p in needed_patterns if p not in zip_links]
    if missing_patterns:
        logger.error(
            f"以下のデータリンクが見つかりませんでした: {', '.join(missing_patterns)}"
        )
        sys.exit(1)

    return zip_links


def download_file(url, dest_path):
    """ファイルをダウンロードし、進捗状況を表示"""
    # 既にファイルが存在する場合はスキップ
    if os.path.exists(dest_path):
        logger.info(
            f"{Fore.YELLOW}ファイルは既に存在します。スキップします: {os.path.basename(dest_path)}"
        )
        return True

    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()

        total_size = int(response.headers.get("content-length", 0))
        block_size = 1024  # 1KB

        with open(dest_path, "wb") as f, tqdm(
            desc=f"{Fore.BLUE}{os.path.basename(dest_path)}{Style.RESET_ALL}",
            total=total_size,
            unit="B",
            unit_scale=True,
            unit_divisor=1024,
            bar_format="{l_bar}%s{bar}%s{r_bar}" % (Fore.CYAN, Fore.RESET),
        ) as bar:
            for data in response.iter_content(block_size):
                f.write(data)
                bar.update(len(data))

        return True
    except requests.exceptions.RequestException as e:
        logger.error(f"{url} のダウンロード中にエラーが発生しました: {e}")
        return False


def unzip_file(zip_path, extract_to):
    """ZIPファイルを解凍"""
    try:
        # 解凍先ディレクトリが存在する場合は削除
        if os.path.exists(extract_to):
            logger.info(
                f"{Fore.YELLOW}既存の解凍先ディレクトリを削除します: {extract_to}"
            )
            shutil.rmtree(extract_to)

        # ディレクトリ作成
        os.makedirs(extract_to, exist_ok=True)

        # Shift-JISエンコーディングを指定して解凍
        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            # ファイル名のエンコーディングをShift-JISに指定
            logger.debug(f"解凍を開始: {zip_path}")
            for file_info in zip_ref.infolist():
                try:
                    file_info.filename = file_info.filename.encode("cp437").decode(
                        "cp932"
                    )  # Shift-JIS (CP932)
                    zip_ref.extract(file_info, extract_to)
                except UnicodeDecodeError:
                    # エンコーディングエラーの場合、別のエンコーディングを試す
                    try:
                        file_info.filename = file_info.filename.encode("cp437").decode(
                            "utf-8"
                        )
                        zip_ref.extract(file_info, extract_to)
                    except:
                        logger.warning(
                            f"ファイル名のエンコーディングを処理できませんでした: {file_info.filename}"
                        )
        return True
    except zipfile.BadZipFile as e:
        logger.error(f"{zip_path} は正しいZIPファイルではありません: {e}")
        return False
    except Exception as e:
        logger.error(f"{zip_path} の解凍中にエラーが発生しました: {e}")
        return False


def main():
    logger.info(
        f"{Fore.CYAN}{Style.BRIGHT}気象庁GISデータのダウンロードを開始します..."
    )

    # 必要なディレクトリを作成
    create_dirs()

    # GISデータのリンクを取得
    links = fetch_jma_links()

    # ダウンロードと解凍
    downloaded_dirs = []
    for pattern, url in links.items():
        filename = os.path.basename(url)
        dest_path = os.path.join("data/raw", filename)

        logger.info(f"{Fore.CYAN}ダウンロード中: {pattern}")
        if download_file(url, dest_path):
            # 解凍先のディレクトリ名を拡張子なしのファイル名にする
            extract_dir = os.path.join("data/raw", os.path.splitext(filename)[0])
            logger.info(f"{Fore.BLUE}解凍中: {dest_path} -> {extract_dir}")

            if unzip_file(dest_path, extract_dir):
                downloaded_dirs.append(extract_dir)
            else:
                logger.warning(f"{dest_path} の解凍に失敗しました")
        else:
            logger.warning(f"{url} のダウンロードに失敗しました")

    if downloaded_dirs:
        logger.info(f"{Fore.GREEN}以下のディレクトリにデータが展開されました:")
        for directory in downloaded_dirs:
            logger.info(f"- {directory}")
        logger.info(
            f"{Fore.GREEN}{Style.BRIGHT}すべてのデータのダウンロードと解凍が完了しました"
        )
    else:
        logger.error("データのダウンロードまたは解凍に失敗しました")
        sys.exit(1)


if __name__ == "__main__":
    main()
