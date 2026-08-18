# 同梱 Asset Pack を Flutter assets 展開にしたことによる副作用を解消する

## 背景

`packages/assets_util`（iOS/Android ネイティブ実装）を削除し、同梱 Asset Pack の
解決を `BundledAssetPackRepository`（`rootBundle` から実ファイルへ展開）へ
置き換えた。ネイティブ依存は消えたが、次の副作用が残っている。

## 課題

### 1. 展開時のピークメモリ

`rootBundle.load()` は asset 全体を一度メモリへ載せる。基盤地図 PMTiles は
数十MB あるため、初回起動時のピークメモリが従来より増える。
書き出し後に `AssetBundle.evict` で解放しているが、単一 asset 分のピークは
avoid できない。低メモリ端末での実測が必要。

対策候補: 同梱物を R2 と同じ署名済み ZIP 1 ファイルにして、既存の
`AssetPackArchiveExtractor` でストリーム展開する。

### 2. ディスク使用量

iOS では従来 app bundle 内の `platform` ディレクトリを直接読んでいたため
コピーが不要だった。現在は IPA 内の asset とアプリ専用領域の展開結果で
Pack 1 個分が二重に載る。

### 3. pubspec のサブディレクトリ列挙

`flutter.assets` は再帰しないため、`app/pubspec.yaml` で
`assets/platform/`・`assets/platform/map/`・`assets/platform/parameters/` を
個別に列挙している。backend が Pack に新しいサブディレクトリを増やすと、
そのファイルは同梱されず manifest 検証で `AssetPackNotReadyException` になる
（loud に失敗するので偽データは出ないが、リリースまで気付けない）。

対策候補: `tool/asset_pack/stage_from_r2.sh` に、展開結果のサブディレクトリが
`app/pubspec.yaml` の宣言に収まっているか検証する手順を足す。

### 4. `.gitkeep` の運用

`stage_from_r2.sh` は `app/assets/platform` をディレクトリごと差し替えるため、
staging すると `map/.gitkeep`・`parameters/.gitkeep` が消える。Flutter は
宣言済み asset ディレクトリが存在しないとビルドを失敗させるので、clean
checkout ではこの `.gitkeep` が必要。
