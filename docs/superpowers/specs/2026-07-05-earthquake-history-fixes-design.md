# 地震履歴機能 全面修正 + 機能追加 設計書

日付: 2026-07-05
対象: `app/lib/feature/earthquake_history/`(データ層・UI層)、Home 履歴シート、関連チップコンポーネント
ベースコミット: `9db865797`(履歴データ層リファクタWIP固定)

## 背景

探索調査により、未コミットリファクタ由来の回帰バグ(地域フィルタ無反応、City検索の必発例外、リアルタイム反映の無効化、フィルタ未転送)と、データ層は完成済みなのにUIに露出していない機能群を確認した。本設計はそれらの全面修正と機能追加を対象とする。

## A. データ層バグ修正

### A-1. City検索の修正
`earthquake_history_data_source.dart` の `_fetch` 内 `EarthquakeHistoryParameterCity` 分岐が `searchByRegion` を呼んでおり、`Region not found` 例外が必発。`searchByCity` に変更する。

### A-2. フィルタ転送の復旧
`_fetch` が UI から設定されたフィルタを repository に転送していない。

- All 分岐: `statuses` / `datasource` / `telegramTypes` / `latitudeGte` / `latitudeLte` / `longitudeGte` / `longitudeLte` を追加転送(`fetchEarthquakeList` は受け口実装済み)。
- Region/Prefecture/City/Station 分岐: `statuses` を追加転送(searchBy* 全メソッドが受け口実装済み)。`datasource` / `telegramTypes` / `latlng` は API 非対応のため転送しない(UI側で非表示: B-2)。

### A-3. 既定ソートと upsert の整合
- 既定パラメータの `sortOrder` を `.asc` → `.desc`(新しい順)に変更。対象: `earthquake_history_page.dart`、`home_earthquake_history_parameter_provider.dart` ほか既定生成箇所すべて。
- `upsertItems` の早期 return ガード(`sortOrder != .desc` で全破棄)を廃止し、`sortBy == .eventId` であれば asc/desc いずれも eventId 比較で正しい位置へ挿入する。`sortBy` が eventId 以外のときのみスキップ(挿入位置が確定できないため)。

## B. UI層バグ修正

### B-1. 地域フィルタの復旧(最重要)
`earthquake_history_parameter_persistent_delegate.dart` の `RegionIntensityFilterChip.onChanged` に `result != null` の分岐が欠落しており、地域選択が無反応。`result.searchType` に応じて `.prefecture/.region/.city/.station` の sealed パラメータへ再構築し、既存フィルタ(magnitude/depth/originTime/lpgm/statuses/earthquakeType/epicenterCodes/sortOrder 等)を引き継ぐ。ピッカーの `result.intensityGte/Lte` はパラメータの `intensityGte/Lte` にマッピングする(地域検索APIでは当該地域での観測震度の意味)。`sortBy` は eventId に固定(B-2 参照)。

### B-2. 地域絞り込み中の無効チップ制御
地域系 API が受け付けないフィルタの UI を `parameter is! EarthquakeHistoryParameterAll` のとき非表示にする: `DatasourceFilterChip` / `TelegramTypeFilterChip` / `LatLngFilterChip`。ソートチップは地域絞り込み中 `sortBy` を eventId 固定にし、並び順(昇順/降順)のみ変更可能とする(API仕様: 地域系ソートは event_id のみ)。

### B-3. 地域名表示(TODO解消)
`earthquake_history_list_tile.dart:133` 付近の生コード表示(例:「330 震度4」)を、`jmaParameterProvider` の `earthquake.prefectures → regions → cities → stations` 階層および `jmaCodeTable.codeTables.areaInformationPrefectureEarthquake` から名称解決して表示する。解決不能時はコードをフォールバック表示。

### B-4. 推計震度カードの注意文言表示
`earthquake_intensity_card.dart` の estimated モードの `Placeholder` を廃止。`estimated_intensity_notice_dialog.dart` 内の注意文言(`_BulletText` 群 + 気象庁リンク)を共有ウィジェット `EstimatedIntensityNoticeContent` に抽出し、カード内に表示する。初回自動ダイアログ表示(`EstimatedIntensityNoticeShown`)の挙動は維持。

### B-5. 震源レイヤーのアイコン再登録ガード
`earthquake_history_hypocenter_layer.dart` の useEffect が再実行のたびに同一 id で `addImageFromAssets` を呼ぶ。画像登録を専用 useEffect(依存: style のみ)に分離し、layer/source の再構築と独立させる。

## C. Home シート統合(レガシー削除)

- `EarthquakeHistoryDataSource`(自作クラス)に読み込み済みアイテムを公開するインターフェイス(getter または `ValueListenable`)を追加。
- `home_earthquake_history_sheet.dart` を `earthquakeHistoryProvider`(レガシー)から `earthquakeHistoryDataSourceProvider(param)` 消費へ移行し、先頭N件(現行と同等の件数)を `HomeEarthquakeList` に渡す。エラー時リフレッシュは data_source の Refresh 経路を使用。
- 5分ポーリング・リアルタイム upsert・復帰時再取得は data_source プロバイダに内包済みのため、Home 側の個別配線は削除。
- `earthquake_history_notifier.dart`(+ `.g.dart`)を削除。

## D. 機能追加

### D-1. 地域ピッカー4種対応
`region_intensity_filter_chip.dart` の ChoiceChip を「都道府県 / 細分化地域 / 市区町村 / 観測点」の4択へ拡張。既存 `CitySelector`(`app/lib/core/component/selector/city_selector.dart`)のパターンを踏襲し、`RegionSelector` / `StationSelector` を新設。データ源は `parameterSetProvider` の `earthquake.prefectures` 階層(regions / cities / stations すべて存在確認済み)。

### D-2. 震央地名フィルタ
新チップ `EpicenterFilterChip`(order 12)を追加。`jmaCodeTable.codeTables.areaEpicenter`(`List<JmaCodeTableItem>`)から検索可能なマルチ選択モーダルで `epicenterCodes` を設定。`epicenterCodes` は全スコープの API が対応済みのため常時表示。

### D-3. マップ表示モード切替
- `EarthquakeHistoryConfig` に `map` サブ設定 `EarthquakeHistoryMapConfig` を追加: `fillMode`(`EarthquakeHistoryFillMode`)/ `stationDisplayMode`(`StationDisplayMode`)/ `hypocenterDisplayMode`(`HypocenterDisplayMode`)。既定値は現行のコンストラクタ既定値(auto / maxFocused / zoomFade)。
- 永続化は既存 `EarthquakeHistoryConfigNotifier`(SharedPreferences)経由。
- 切替UIは `earthquake_history_details_map_layer_modal.dart`(「マップレイヤー」モーダル)にセグメント/ラジオで追加。
- `earthquake_history_details_map_view.dart` のレイヤー構築時に設定値を渡す。

## E. クリーンアップ

- `earthquake_history_notifier.dart` + `.g.dart` 削除(C で移行後)
- `earthquake_list_response.dart` 削除(未使用)
- デバッグページ `debug_earthquake_history_list_tile_page.dart` の未使用 `_searchAreaSamples` 削除
- `EarthquakeHistoryListConfig` のデッドフィールド `designatedRegionSearchType` / `designatedRegionCode` / `designatedRegionName` 削除(全域 grep で参照ゼロ確認済み。JSON 互換: 未知キーは無視されるため既存永続化データへの影響なし)
- `earthquake_history_statuses_test.dart` の未使用 import 削除

## F. テスト・検証方針

- データ層: モック repository でパラメータ転送(A-1/A-2)・upsert 挿入順序(A-3)のユニットテスト。
- UI層: delegate の onChanged マッピング(B-1)、チップ表示制御(B-2)の widget テスト。名称解決(B-3)はロジックを関数に切り出してユニットテスト。
- 各タスクは TDD で実施し、`melos run generate` による生成ファイル更新をコミットに含める。
- 最終検証: ブランチ全体レビュー + `dart analyze`(警告ゼロ)+ `melos run test` + `dart format`。

## 制約

- コミットは develop へ直接積む(ユーザー承認済み)。
- backend サブモジュールポインタには触れない。
- PR を作る場合は `--repo YumNumm/EQMonitor`、ベース `develop`(CLAUDE.md 厳守)。
