# Map Converter

気象庁の地図データをGeoJSON形式、PBF(Protocol Buffers Binary Format)形式、PMTiles形式に変換するツールです。

## 対象データ

このツールは特に以下の地震・津波関連データに特化しています：

- 市町村等（地震津波関係）
- 緊急地震速報／府県予報区
- 地震情報／細分区域
- 津波予報区

## 前提条件

以下のツールがインストールされている必要があります：

- curl：データのダウンロード用
- unzip：ZIPファイルの展開用
- ogr2ogr (GDALツール)：シェープファイルからGeoJSONへの変換用
  - macOS: `brew install gdal`
  - Ubuntu: `apt-get install gdal-bin`
- tippecanoe：GeoJSONからPBF・PMTiles形式への変換用
  - macOS: `brew install tippecanoe`
  - その他: [GitHub - felt/tippecanoe](https://github.com/felt/tippecanoe)からインストール

## 使い方

### 全プロセスの実行

以下のコマンドで、ダウンロードから変換までの全プロセスを実行できます：

```bash
chmod +x run_all.sh
./run_all.sh
```

### 個別ステップの実行

各ステップを個別に実行することも可能です：

1. データのダウンロードと解凍：

   ```bash
   ./download_jma_data.sh
   ```

2. シェープファイルからGeoJSONへの変換：

   ```bash
   ./convert_to_geojson.sh
   ```

3. GeoJSONからPBF・PMTilesへの変換：

   ```bash
   ./convert_to_pbf.sh
   ```

## 出力ファイル

- GeoJSONファイル: `data/geojson/` ディレクトリ
- PBFファイル: `data/pbf/` ディレクトリ
- PMTilesファイル: `data/pmtiles/` ディレクトリ

## データ元

気象庁ホームページ：[予報区等GISデータの一覧](https://www.data.jma.go.jp/developer/gis.html)
