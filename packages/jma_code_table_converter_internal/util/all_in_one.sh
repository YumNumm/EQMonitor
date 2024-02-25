#!/bin/bash
rm -rf tmp
mkdir tmp

echo "------ Downloading base XLS sheet ------"
wget https://xml.kishou.go.jp/jmaxml_20240216_Code.zip \
    -O tmp/jmaxml_20240216_Code.zip \
    --no-check-certificate \
    --quiet
echo "unzipping..."
unzip -O sjis tmp/jmaxml_20240216_Code.zip -d tmp > /dev/null

echo "------ Converting XLS to CSV ------"
cd util/xls_to_csv
echo "syncing rye..."
rye sync > /dev/null
echo "converting..."
rye run python3 src/xls_to_csv/main.py \
   -i ../../tmp/地震火山関連コード表.xls \
   -o ../../tmp/output
cd ../..

echo "------ Generating code table ------"
rm -rf output
dart run

echo "------ Copy to Application Assets ------"
cp output/jma_code_table.pb ../../assets/
echo "OK."

echo "------ Cleaning up ------"
rm -rf tmp

echo "------ Done ------"