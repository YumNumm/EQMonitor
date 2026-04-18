# ホーム地震履歴カード（スコープ切替）のフォローアップ

## 背景

ホームの地震履歴では「全国 / 現在地 / 指定地域」の切替を追加した。指定地域は `EarthquakeHistoryListConfig` にフィールドを用意しているが、ユーザーが設定する UI は未実装である。また一覧画面との表示条件の一致や、例外時の見せ方は今後詰める余地がある。

## やること

1. **指定地域の設定フロー**
   - 削除した「地域から検索」相当の画面を要件に沿って再設計・実装し、都道府県または市区町村の選択結果を `EarthquakeHistoryListConfig`（`designatedRegionSearchType` / `designatedRegionCode` / `designatedRegionName`）へ保存する。
   - 設定画面（地震履歴設定など）から遷移できる導線を決め、未設定時の案内文言と整合させる。

2. **「さらに表示」と地震履歴一覧の整合**
   - ホームで選んだスコープと、`EarthquakeHistoryRoute`（一覧）の検索条件が一致するようにする（ルート引数・クエリ・共通 Notifier など、実装方針を決めてから対応）。
   - 全国以外のスコープで一覧を開いたときのフィルタ UI の要否を検討する。

3. **読み込み・エラー・未設定時の表示**
   - 位置情報が取得できない、JMA 市区町村にマッピングできない、指定地域が未設定、API エラーなど、それぞれに overflow しない短い説明と再試行の導線を整理する（文言はプロダクト・デザインと確定させる）。

4. **テスト**
   - `homeEarthquakeHistoryParameterProvider` の分岐（全国 / 現在地 / 指定地域・未設定）を単体テストで押さえる。
   - `HomeEarthquakeHistorySheet` の代表的な状態（ローディング、エラー、空、3件表示）を Widget テストでカバーする範囲を決めて追加する。

## 参照

- `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart`
- `app/lib/feature/home/data/provider/home_earthquake_history_parameter_provider.dart`
- `app/lib/feature/home/data/model/home_configuration_model.dart`（`HomeEarthquakeHistoryScope`）
- `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`（指定地域フィールド）
