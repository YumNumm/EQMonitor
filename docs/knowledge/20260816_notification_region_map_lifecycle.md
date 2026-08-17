# 通知地域地図のデータとライフサイクル

## 地域データの正本

- 通知の `regionId` は `areaForecastLocalEew` のコードを使う。
- 表示する市区町村名・ふりがなは `EarthquakeParameter` を正本とする。
- `jma_code_table.areaInformationCity` は観測点名を含むため表示には使わない。
  観測点コードから親 `areaForecastLocalEew` を結合する用途に限定する。
- 結合できない市区町村を固定値や近隣地域へ補完しない。除外してログに残す。

## MapLibre と非同期検索

- JMAポリゴン検索はUI isolateで展開せず、常駐 `JmaMapIsolate` を事前読込して使う。
- タップごとに世代番号を発行し、検索完了時に最新世代かつWidgetがmountedか確認する。
- カメラ操作は直列キューへ積み、実行開始時にも世代を確認する。古い検索結果で新しい
  フォーカスを上書きしない。
- `dispose` では世代を無効化し、MapController参照を破棄する。待機中のカメラ操作は
  実行しない。
- style layerの追加・filter更新・削除は `MapOperationQueueScope` の共有キューで直列化する。
  cleanupでは変更した既存filterを復元し、追加したlayerをIDごとに削除する。
- 全国表示では市区町村境界を隠す。regionフォーカス後だけ配下の市区町村コードで
  filterし、選択中の市区町村は別layerの太線で重ねる。
- 市区町村タイルを表示できるよう、regionフォーカス時のzoomは6未満にしない。

## 検証コマンド

```bash
cd app
mise exec -- flutter test --no-pub test/feature/settings/features/notification_settings
mise exec -- flutter analyze --no-pub
cd ..
git --no-pager diff --check
git --no-pager diff origin/develop...HEAD -- app/lib/feature/intensity_history
```
