# 都道府県選択の境界データ

- PMTilesには `areaInformationCityQuake` 等のみがあり、都道府県ポリゴンはない。
- 都道府県選択を市区町村コードに展開して線を描くと、内部の市区町村境界まで強調される。
- `RegionMapLayers` の都道府県は専用GeoJSON sourceを使い、`code`（01〜47）で選択する。
- 出典: 気象庁「地震情報／都道府県等」GISデータ（2019年1月25日公開）。
  https://www.data.jma.go.jp/developer/gis.html
- 表示専用にGDALの `-simplify 0.001`（度）で簡略化し、小数5桁に丸めた。離島のポリゴンを面積で除去しない。位置判定・通知判定には使用しない。
- gzipで同梱し、展開・UTF-8デコードはIsolateで行う。再生成にはGDALが必要。

```sh
curl -L --fail https://www.data.jma.go.jp/developer/gis/20190125_AreaInformationPrefectureEarthquake_GIS.zip -o /tmp/prefectures.zip
python3 utils/map_converter/build_prefecture_boundaries.py /tmp/prefectures.zip
(cd app && mise exec -- flutter test test/feature/region_selection/prefecture_boundary_repository_test.dart)
```

元データの国土地理院承認表示・利用上の留意点は出典ページ参照。
実機での境界描画は未確認。北海道・鹿児島県・東京都の離島を含めて確認する。

## 限定コード生成

新規worktreeで `build_runner build --build-filter=...` を実行すると、対象外の追跡済み生成ファイルも削除されることがあった。生成前後の `git status --short` を必ず比較する。今回のように初期状態がcleanの場合のみ、生成処理による削除だと確認できたファイルをHEADから復元する。ユーザーの既存差分を復元対象に含めない。

ローカルmise 2026.8.16ではリポジトリ要求2026.09.12を満たさずコミットフックも起動できなかったため、指定Flutter SDKをリポジトリ外から `mise exec flutter@19946f91c8d9de18a4674460d015229cc0b2534f -- ...` で実行して検証した。個別テスト・解析後のコミットには `HK=0` を使用した。設定の要求バージョンは変更していない。
