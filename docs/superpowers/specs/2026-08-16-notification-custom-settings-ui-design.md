# 通知カスタム設定 UI 改修設計

## 目的

通知カスタム設定を通知地域（スロット）中心の構成へ整理し、予報・地震情報・警報の条件を各スロット詳細画面で一貫して設定できるようにする。Live Activity と予報・地震情報のグローバル設定は UI から外し、通知プリセット適用時の不変条件として管理する。

加えて、緊急地震速報（警報）の全国通知を Free プランでも利用可能にし、Flutter、設定 API、実配信の契約を一致させる。

## Flutter UI

### カスタム設定一覧

- Pro 案内バナーを削除する。
- 「緊急地震速報（予報）」「地震情報」「緊急地震速報（警報）」の詳細タイルを削除する。
- Live Activity トグルを削除する。
- 「通知の種類」には次だけを残す。
  - 推計震度分布図
  - 通知音・割り込みレベル
  - 震度別の音設定
  - 低精度の緊急地震速報
- 到達不能になる `eew_forecast_settings_page.dart` と `earthquake_info_settings_page.dart`、警報専用詳細画面を削除する。

### 通知地域一覧

- 現在地は `Icons.my_location`、全国は `Icons.public`、地域は `Icons.location_on` を使用する。
- 字幕は中黒で連結せず、次の順で複数行表示する。
  - `緊急地震速報(予報): 震度◯以上` または `無効`
  - 条件を満たす場合だけ `緊急地震速報(警報): 有効`
  - `地震情報: 震度◯以上` または `無効`
- 現在地の警報表示は `warningEnabled == true`、全国の警報表示は `target == currentLocationAndNationwide` を条件とする。地域には表示しない。

### スロット詳細

- 現在地、全国、地域のすべてで予報と地震情報の最小震度を `DropdownMenu` から変更可能にする。
- 現在地の初期値は予報が震度4、地震情報が震度1とする。保存済み値がある場合は保存済み値を表示する。
- 現在地の警報セクションは `warningEnabled` を更新する「有効」トグルを表示する。
- 全国の警報セクションは `target` を `currentLocationOnly` と `currentLocationAndNationwide` の間で切り替える「有効」トグルを表示する。Free/Pro を問わず操作可能にする。
- 地域には警報セクションを表示しない。
- 警報セクション直下に「緊急地震速報（警報）は、現在地や全国を対象に重大な通知として配信されます。」という簡潔な説明を表示する。
- 各 Mutation のエラーは既存のエラーダイアログへ接続する。

## Flutter データフロー

- `NotificationSlotRepository.putCurrentLocation`、`NotificationSlotsNotifier.putCurrentLocation`、`SlotUpdateAction` の現在地分岐で `eewMinIntensity` と `earthquakeMinIntensity` を保持して API へ渡す。
- 最小震度の固定値は新規作成・プリセット適用時のデフォルトにのみ使用し、保存済みの現在地設定を上書きしない。
- `EewWarningConfigNotifier` が全国警報の `target`、`EewGlobalSettingsNotifier` が現在地警報の `warningEnabled` を更新する。

## グローバル設定とプリセット

- プリセット適用時は `eewGlobalSettings.enabled` と `earthquakeGlobalSettings.enabled` を常に `true` にする。
- `recommended`、`all`、`custom` では `startLiveActivity: true` を送信する。過去の custom 設定が false でも true に正規化する。
- `none` では `startLiveActivity: false` とし、一般通知のマスターを無効にする。
- 予報と地震情報の個別有効・無効はスロットの `eewEnabled` と `earthquakeEnabled` に一本化する。

## バックエンド

- `PATCH /v2/device/me/settings/eew-warning` から Free プランの全国警報を拒否する 402 分岐を削除する。
- Free の `eew_warning_nationwide` プラン制約を `true` にする。環境変数に依存して Free が再び無効にならない契約にする。
- 警報通知の対象抽出から、全国通知に対する `device_notification.is_pro = true` 条件を削除する。
- 現在地警報、全国警報とも既存どおり `interruptionLevel: critical` で配信する。
- API 仕様書と通知配信仕様書から Free 不可の記述を削除し、Free 対応へ更新する。

バックエンドは `eqmonitor-backend` サブモジュール内の独立ブランチで実装し、独立した Draft PR とする。Flutter 側も親リポジトリの独立ブランチと Draft PR にする。

## テスト

- Flutter Widget テストで、一覧の残存項目、Material Icon、予報・警報・地震情報の表示条件、警報説明文、スロット種別ごとの警報セクションを検証する。
- Flutter の Action/Repository テストで、現在地の選択した最小震度が API に渡ることを検証する。
- プリセットテストで、グローバル enabled と Live Activity の値を各プリセットについて検証する。
- バックエンドのルートテストで Free デバイスの全国警報設定が成功することを検証する。
- プラン制約テストで Free の全国警報が有効になることを検証する。
- 通知対象抽出テストで Free デバイスも全国警報の対象になることを検証する。

## エラー処理と安全性

- 生命に関わる設定のため、欠損値をランダム値や便宜的な固定値で補わない。
- API 更新失敗時は成功表示へ進まず、既存 Mutation のエラー表示を使う。
- Free 対応は API と配信処理を同時に変更し、「設定できるが配信されない」状態を防ぐ。
- 未完了事項やその場しのぎの実装は残さない。新たな既知の制約が判明した場合は `docs/todo/` に記録する。
