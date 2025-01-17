#!/bin/sh

# environmentディレクトリをtar.gzに圧縮し、base64エンコードするスクリプト
# GitHub Actionsの環境変数を生成するために使用します

# カレントディレクトリをenvディレクトリに移動
PROJECT_DIR=$(cd $(dirname $0)/..; pwd)
cd $PROJECT_DIR

# exit code 0以外で終了したコマンドがあった場合、スクリプトを終了する
set -e

TMP_FILE="env.tar.gz"
TMP_DIR="tmp"

# 既に生成されたファイルがある場合は削除
if [ -e $TMP_FILE ]; then
  rm $TMP_FILE
fi

# 一時ディレクトリを作成
if [ -e $TMP_DIR ]; then
  rm -rf $TMP_DIR
fi
mkdir -p $TMP_DIR/environment
cp environment/.env.dev $TMP_DIR/environment/.env.dev
cp environment/.env.prod $TMP_DIR/environment/.env.prod

# environmentディレクトリを圧縮
cd $TMP_DIR
tar -czf $TMP_FILE environment


# 生成されたファイルがあるか確認
if [ ! -e $TMP_FILE ]; then
  echo "Failed to generate $TMP_FILE"
  exit 1
fi

# encode base64
base64 $TMP_FILE

# 生成したファイルを削除
rm $TMP_FILE
cd $PROJECT_DIR
rm -rf $TMP_DIR
