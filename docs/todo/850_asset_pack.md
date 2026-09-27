# Asset Pack の配布・描画・容量

数値は元の優先度。native 実機相当の release 検証と最新配信物の被覆確認は未完了。

## 850: native release 検証

- 対象: `app/lib/feature/asset_pack/`、`tool/asset_pack/stage_from_r2.sh`、Android/iOS build。
- Android SDK で APK/AAB、macOS/Xcode で iOS build を作り、同梱packのoffline起動、更新同意、download進捗、R2更新適用、破損時fallbackを確認する。
- 完了条件: platform/build mode/pack version と各シナリオの結果を記録する。R2/署名鍵/公開設定済みという旧記録を端末確認の代わりにしない。

## 800: Flutter assets 展開の副作用

- 対象: `app/lib/feature/asset_pack/data/repository/bundled_asset_pack_repository.dart`、`app/pubspec.yaml`、`tool/asset_pack/stage_from_r2.sh`。
- `rootBundle.load()` の単一asset全読みによる初回 peak RSS と、bundle＋展開先の二重ディスク容量を低メモリ端末で測る。予算超過時は署名ZIPのstream展開などを比較して改善する。
- Flutter assets は再帰しないため、stagingした全サブディレクトリが pubspec に宣言される gate を追加する。新しいディレクトリの fixture で同梱漏れを検出する。
- clean checkout に `platform/` の placeholder はない。staging 必須を保つか placeholder を導入するか決め、再stageでのディレクトリ交換も含めて同梱漏れを検出する。
- 完了条件: 起動時RSS/容量が端末予算内で、未知ディレクトリとclean checkoutの検証が自動化される。

## 700: assets_util の native 残骸

- Dart package は削除済みだが、`app/ios/Runner/Frameworks/AssetsUtil.xcframework`、`app/macos/Runner/Frameworks/AssetsUtil.xcframework` と各 `Runner.xcodeproj/project.pbxproj` の Frameworks/Embed 参照は残る。
- 呼び出し元がないことを再確認して native参照/バイナリを削除する。
- 完了条件: iOS/macOS build が通り、成果物に未使用 framework が同梱されない。

## 600: 更新チェック失敗カードの仕様

- 対象: `app/lib/feature/asset_pack/` の `AssetPackUpdateCard`、`app/test/feature/asset_pack/asset_pack_update_card_test.dart`。
- 自動更新チェック失敗（`AssetPackUpdateError(isUpdating: false)`）を常時表示するか決める。旧記録では widget は非表示、test は「Asset Pack の更新確認に失敗しました」とretryを期待している。
- 完了条件: widget/test が採用仕様に一致し、手動更新失敗・自動チェック失敗の通知/再試行経路をそれぞれ確認する。

## 500: 市区町村ポリゴンの配信物確認

- 対象: 配信packの `map/all.pmtiles`、`backend/tools/base-map-pmtiles/`、`app/lib/feature/intensity_history/`、`app/lib/feature/earthquake_history/`。
- backend PR [#980](https://github.com/YumNumm/eqmonitor-backend/pull/980)（tippecanoe固定）/ [#992](https://github.com/YumNumm/eqmonitor-backend/pull/992)（CD/GDAL）以降の修正が実際の配信物に含まれるかを確認する。古いv0.0.2の障害を現在の配信状態と断定しない。
- 完了条件: 実tileをdecodeして z8 の distinct `areaInformationCityQuake.regioncode` が元データの期待集合（旧fixtureは1894）と一致し、`areaForecastLocalE=530` / `areaForecastLocalEew=9280` が存在する。`tilestats.count` や layer ID 存在だけを gate にしない。
- Japan erase 済みで二重描画がないことを確認する。v0.0.0への単純なrollbackは日本を二重描画するため解決策にしない。
- `CITY_QUAKE_FEATURE_MINZOOM` と app の `BaseMapTileSpec.cityMinZoom` の一致を release gate にする。市区町村選択中に z6 未満へ戻った場合の強調枠消失のUXを決め、maxzoom変更時も被覆率を測る。

AGP/AAB確認は [ビルド・配布](950_build_and_release.md) を参照。
