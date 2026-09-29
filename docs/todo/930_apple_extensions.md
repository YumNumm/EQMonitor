# App Intents・Widget・Live Activity

数値は元の優先度。署名した実機の Intent 解決・UI 表示は未検証。

## 930: App Intents の残る実機確認と契約

Issue: <https://github.com/YumNumm/EQMonitor/issues/1794>。対象: `app/ios/AppIntentExtension/`、`app/ios/Widget/`、`app/lib/feature/earthquake_history/`。

- `IS_PRODUCTION=true` / false の署名ビルドで切り替えを確認する。production では
  Siri / Shortcuts / Control Center に地震 Intent が公開されず、通知受信・通知タップ・
  起動 / resume / push token 同期失敗で Telemetry DB 作成・保存・API 送信がないことを確認する。
  ホーム画面 Widget の地域設定と Live Activity の表示は維持されることも確認する。
- production への更新時に、登録済み揺れ検知通知の無効化が同期されること、
  揺れ検知だけの位置監視が停止すること、統合 Live Activity の揺れ検知表示が出ないことを確認する。

- 署名実機で「EQMonitorで最新の地震を確認」、Snippet 表示/明示更新、Pro失効、保存地域変更、オフライン音声を確認する。メタデータ生成や Swift テストだけで登録成功とは判断しない。
- Control Center の「最新の地震を確認」「地震履歴を開く」を起動済み/終了状態から実タップし、履歴が開くことを確認する。
- Snippetの「アプリで開く」と各地震行を実タップし、foreground Intent経由で対象の詳細へ遷移することを確認する。履歴を閉じずに別の履歴・検索リンクを続けて実行する場合も確認する。
- Snippetの最大10件表示と長い地域名を、小さい画面幅・大きな文字サイズで確認する。ヘッダーの操作ボタンや下端が切れないかは未検証。
- Universal Linkへの移行は、`deeplink.eqmonitor.app` のDNS/AASAと実機導線を復旧・検証してから行う（2026-09-10の記録では名前解決失敗）。Widgetは`Link`、Snippetはforeground Intentで既存カスタムスキームを開く。
- 保存地域を将来「現在地」と扱うなら、Flutter の全保存経路で観測日時を共有し、取得失敗・期限切れ・権限取消の契約とテストを追加する。現行は保存地域のまま扱う。
- Flutter 履歴の時刻表示を `originTimePrecision` に従わせ、日時精度別の回帰テストを追加する。
- Swift の元スキーマにない旧 Live Activity 操作5件を整理し、限定生成から全生成へ戻す。下記800と合わせて契約を照合する。
- Siri の自然文の日付・震度・複合条件検索は未対応。採用する条件を定義して地域候補選択から拡張し、意図した query と結果をテストする。
- Flutter map / `flutter_scene` の API が一致する pin で Runner 全体を再ビルドする。過去の `FmatType` / `parameterTypeOf` / `interfaceManifestFileName` 不整合は現行環境で再確認する。
- 完了条件: 上記の契約テスト・端末別結果を Issue に記録する。実機未確認のまま Issue を閉じない。

## 920: Widget deployment target 引き下げの検証

- `app/ios/Runner.xcodeproj/project.pbxproj` の Widget target は17.6、AppIntentExtension は26.0。availability 対応のビルド・表示検証は残る。
- `app/ios/` で Runner scheme の iOS Simulator build を実行し、17.6向け Widget コンパイルと AppIntents metadata processor を確認する。
- iOS 18〜26.0でLive Activityの対応判定・push-to-start token登録とAPNs Start→Update→Endを実機確認する。Vision判定をAPI利用可能なOS内へ限定する修正後も、iOS 26.1以降、Mac・Vision実行時の除外を確認する。
- 完了条件: iOS 18で Widget/Live Activity が表示され、26専用 Snippet Control は出ない。iOS 26で Widget/Live Activity/Control が表示される。必要な `@available` 漏れを修正し、結果を記録する。

## 800: backend Live Activity API の復元・再生成

- 対象: `backend/api/api/src/features/device/routes/live-activity-test.ts`、OpenAPI、`packages/eqmonitor_api/`、Swift EQMonitorAPI。backend commit `83448697` / `6757aee5` 周辺を参照し、現行 submodule と照合する。
- 旧記録で欠落していた `POST /v2/device/me/live-activity/test`、`/{id}/update`、`/{id}/end` と updateToken get/put/delete を復元または正式な現行契約へ統一する。
- 完了条件: `/v2/shake-detection/active` と共存し、OpenAPI→Dart/Swift 再生成後の start/update/end・token 同期回帰テストが通る。生成物だけを手修正しない。

## 500: EEW 最大長周期地震動階級

- backend Issue: <https://github.com/YumNumm/eqmonitor-backend/issues/1158>。`buildEewLiveActivityContentState` に全国最大階級を追加し、イベント変換をテストする。
- `app/ios/Widget/LiveActivity/Eew/` の受信モデルと旧 payload 互換テストを追加し、実値がある場合のみロック画面の発生時刻下へ表示する。現在地の `forecastLpgmIntensity` を全国最大へ流用しない。

## 400: Widget の検証・Android 対応

- `WidgetModelsTests` で判断ロジックを継続検証し、取消報・未入電バッジ・Dynamic Island 展開時の切れを Preview/実機で確認する。必要な SwiftUI snapshot fixture と macOS CI の採否を決める。
- 統合 Live Activity の実機表示は未検証。地震情報の M・深さが EEW と同じ余白・配置（展開時は縦積み）になり、ヘッダー右に最大観測震度がなく、State 9 の M8+ が白文字で収まることを確認する。
- 統合型 Live Activity の上下配置の最大震度で、`MAX` と数字・未発表の `-` が左右中央に揃うことを実機で確認する。5弱〜6強の配置も確認する。
- Mの数値部分の字間をフォントサイズの-22%に戻した表示を、Lock ScreenとDynamic Island Expandedの実機で確認する。共通部品を使う地震情報のM8+も確認する。
- Android Widget は未実装。採用する場合は `app/android/` に AppWidgetProvider/Glance を実装し、Pro未加入・未設定時の全国 fallback を iOS の `WidgetRegionResolver` と揃えてテストする。
- extension 版番号は [ビルド・配布](950_build_and_release.md) の300を参照。
