# App Intents・Widget・Live Activity

数値は元の優先度。署名した実機の Intent 解決・UI 表示は未検証。

## 930: App Intents の残る実機確認と契約

Issue: <https://github.com/YumNumm/EQMonitor/issues/1794>。対象: `app/ios/AppIntentExtension/`、`app/ios/Widget/`、`app/lib/feature/earthquake_history/`。

- `IS_PRODUCTION=true` / false の署名ビルドで切り替えを確認する。production では
  Siri / Shortcuts / Control Center に地震 Intent が公開されず、通知受信・通知タップ・
  起動 / resume / push token 同期失敗で Telemetry DB 作成・保存・API 送信がないことを確認する。
  ホーム画面 Widget の地域設定と Live Activity の表示は維持されることも確認する。
- production への更新時に、登録済み揺れ検知通知の無効化が同期されること、
  揺れ検知だけの位置監視が停止することを確認する。

- 署名実機で「EQMonitorで最新の地震を確認」、Snippet 表示/明示更新、Pro失効、保存地域変更、オフライン音声を確認する。メタデータ生成や Swift テストだけで登録成功とは判断しない。
- Control Center の「最新の地震を確認」「地震履歴を開く」を起動済み/終了状態から実タップし、履歴が開くことを確認する。
- Snippetの「アプリで開く」と各地震行を実タップし、foreground Intent経由で対象の詳細へ遷移することを確認する。履歴を閉じずに別の履歴・検索リンクを続けて実行する場合も確認する。
- Snippetの最大10件表示と長い地域名を、小さい画面幅・大きな文字サイズで確認する。ヘッダーの操作ボタンや下端が切れないかは未検証。
- Universal Linkへの移行は、`deeplink.eqmonitor.app` のDNS/AASAと実機導線を復旧・検証してから行う（2026-09-10の記録では名前解決失敗）。Widgetは`Link`、Snippetはforeground Intentで既存カスタムスキームを開く。
- 保存地域を将来「現在地」と扱うなら、Flutter の全保存経路で観測日時を共有し、取得失敗・期限切れ・権限取消の契約とテストを追加する。現行は保存地域のまま扱う。
- Flutter 履歴の時刻表示を `originTimePrecision` に従わせ、日時精度別の回帰テストを追加する。
- Swift の元スキーマにない旧 Live Activity 操作5件を整理し、限定生成から全生成へ戻す。下記800と合わせて契約を照合する。
- Siri の自然文の日付・震度・複合条件検索は未対応。採用する条件を定義して地域候補選択から拡張し、意図した query と結果をテストする。
- 完了条件: 上記の契約テスト・端末別結果を Issue に記録する。実機未確認のまま Issue を閉じない。

## 920: Widget deployment target 引き下げの検証

- `app/ios/Runner.xcodeproj/project.pbxproj` の Widget target は17.6、AppIntentExtension は26.0。availability 対応のビルド・表示検証は残る。
- `app/ios/` で Runner scheme の iOS Simulator build を実行し、17.6向け Widget コンパイルと AppIntents metadata processor を確認する。
- iOS 18〜26.0でLive Activityの対応判定・push-to-start token登録とAPNs Start→Update→Endを実機確認する。Vision判定をAPI利用可能なOS内へ限定する修正後も、iOS 26.1以降、Mac・Vision実行時の除外を確認する。
- 完了条件: iOS 18で Widget/Live Activity が表示され、26専用 Snippet Control は出ない。iOS 26で Widget/Live Activity/Control が表示される。必要な `@available` 漏れを修正し、結果を記録する。

## 850: ホーム画面 Widget（地震履歴）の実表示確認

対象: `app/ios/Widget/Widget.swift`、`Views/EarthquakeWidgetView.swift`、`EarthquakeWidgetCache.swift`。
背景は [ホーム画面 Widget](../knowledge/home_widget.md)。確認済みは macOS のオフスクリーン描画（件数・文字の切れ）、
WidgetExtension・AppIntentExtension・`EQMonitorPreview` の署名なし Simulator 向け build、`WidgetModelsTests` だけ。

- Runner へ組み込んだ署名ビルドでは未確認。ホーム画面へ追加して表示を確認する。
- ホーム画面の色つき・クリア表示、iPad のロック画面、夜間のスタンバイで、震度バッジの枠線表示と文字が
  読めることを確認する。描画モードごとの分岐は macOS の近似描画でしか見ていない。
- 昼のスタンバイと CarPlay はフルカラーのまま背景だけが外れる。文字色と区切り線がどう見えるかは未確認。
- ライトの背景に重ねた青い光が、実機の画面と壁紙の上でどう見えるかを確認する。macOS の描画でしか見ていない。
- Dynamic Type を大きくして、件数が 3 件から 2 件へ減るだけで文字が切れないことを確認する。
  macOS では文字倍率を掛けた近似だけ。iPhone SE（148pt）は xLarge で small・medium とも 2 件になる見込み。
- iPad の寸法表にある Device 側の高さ（120〜136pt）で配置されるなら small・medium は 2 件になる。
  Canvas 側の寸法で配置されるかを実機で確認する。
- 訓練・テストの電文が出ないことを、訓練報が配信された日に確認する。API への `statuses=NORMAL` の付与は
  テスト用の通信差し替えで確認したが、backend が絞り込むことは未確認（表示前にも通常以外を落としている）。
- VoiceOver で各行が 1 要素として「震度・震源・マグニチュード・深さ・時刻」の順に読まれること、
  ヘッダーの取得時刻と更新失敗が読まれることを確認する。
- 行以外（ヘッダー・余白・エラー表示）のタップで地震履歴一覧が開くことを確認する。
- 通信を切って取得を失敗させ、前回分と警告表示が出ること、日付をまたいだ前回分に日付が付くことを確認する。
  App Group コンテナへの保存は署名したビルドでのみ確認できる。
- ウィジェットを追加した直後など、ギャラリー以外の一時表示で見本の地震が出ないことを確認する。
- 強い地震の直後に Smart Stack で前面へ出るかを確認する。
- 即時更新は VXSE 通知が届いた端末に限られ、通知を切っている端末は 15 分ごとの再取得に頼る。
  WidgetKit push（`apns-push-type: widgets`）で backend から再読み込みさせる対応は未着手。
  対応 OS と backend の配信経路を決めてから実装する。

## 800: backend Live Activity API の復元・再生成

- 対象: `backend/api/api/src/features/device/routes/live-activity-test.ts`、OpenAPI、`packages/eqmonitor_api/`、Swift EQMonitorAPI。backend commit `83448697` / `6757aee5` 周辺を参照し、現行 submodule と照合する。
- 旧記録で欠落していた `POST /v2/device/me/live-activity/test`、`/{id}/update`、`/{id}/end` と updateToken get/put/delete を復元または正式な現行契約へ統一する。
- 完了条件: `/v2/shake-detection/active` と共存し、OpenAPI→Dart/Swift 再生成後の start/update/end・token 同期回帰テストが通る。生成物だけを手修正しない。

## 500: EEW 最大長周期地震動階級

- backend Issue: <https://github.com/YumNumm/eqmonitor-backend/issues/1158>。`buildEewLiveActivityContentState` に全国最大階級を追加し、イベント変換をテストする。
- `app/ios/Widget/LiveActivity/Eew/` の受信モデルと旧 payload 互換テストを追加し、実値がある場合のみロック画面の発生時刻下へ表示する。現在地の `forecastLpgmIntensity` を全国最大へ流用しない。

## 400: Widget の検証・Android 対応

- Live Activity の共通 `SourceMetricsView` で、深さ0が「ごく浅い」、700が「700km以上」と表示される変更はApple SDK・実機で未検証。EEWのLock Screen・Dynamic Island ExpandedをSimulatorと実機で確認する。
- `WidgetModelsTests` で判断ロジックを継続検証し、取消報・未入電バッジ・Dynamic Island 展開時の切れを Preview/実機で確認する。必要な SwiftUI snapshot fixture と macOS CI の採否を決める。
- Mの小数点前後だけを詰めた表示（-14%）、ヘッダー文字の高さ固定、Compact/Minimalの`MAX`左右余白を、Lock ScreenとDynamic Islandの実機で確認する。Compactの`MAX`はSimulatorのDynamic Islandで確認済み。
- Expandedは下段が高さを使い切ると、上段の最大震度（38pt）とM/深さ（21pt）が`minimumScaleFactor`で約0.7倍に縮む。現在地欄のある状態と無い状態で上段の大きさが変わるため、基準サイズを下げて揃えるか、現状の可変を許容するかを決める。
- Apple Watch（Smart Stack）とCarPlayの`.small`表示は実機・Simulatorとも未確認。オフスクリーン描画で崩れが無いことだけ確認済み。Watchの実寸、常時表示（`isLuminanceReduced`）時の見え方を確認する。
- Dynamic Typeを標準に固定したため、文字を大きくしている利用者にもLive Activityは標準の大きさで出る。Lock Screenの上限160ptの中で段階的に大きくできるか（要素を減らす専用レイアウトなど）は未検討。
- 現在地が警報対象のときLock Screenの地色を暗い赤にした。Lock Screenの余白・スタンバイの全面・常時表示で地色がどう出るかは実機未確認。
- `.small`の点滅（`BlinkBlock`）はSimulatorの実Dynamic Islandで動作確認しただけで、Apple Watch・CarPlayでは未確認。Watch側で専用フォントが使えない場合、枠いっぱいに数字が描かれるおそれがあるため、リリース前に実機で必ず確認する。本番のWidgetターゲットは未ビルドのため、`EQBlink.ttf`・`EQBlinkHalf.ttf`が拡張に入っているかも確認する。0.5秒おきの点滅（iOS 18以降）は実機のLock Screenで未確認。
- スタンバイは2倍描画での代用確認のみ。夜間モードの赤着色でヘッダー内の文字（帯色の上の70%白）が読めるか、実機で確認する。
- 幅が狭いDynamic Island（`isDynamicIslandLimitedInWidth`）はオフスクリーン描画のみ。実機の横向き・複数Activityで切り取りが無いか確認する。
- Lock Screenの実表示はSimulatorで未確認（ロックする手段がない）。実機で確認する。
- 到達カウントダウンの数字が実機で毎秒アニメーションするかを確認する。SimulatorのDynamic Islandでは動かない。
- 到達カウントダウンの0.1秒表示（iOS 18以降、`EQCountdown.ttf`）はSimulatorのCompact・Expanded・バナーで確認しただけ。実機のLock Screen・Apple Watch・CarPlayで、`0:08.5`のまま出たり数字や`秒`が欠けたりしないか確認する。現在地PLUMの`すぐに到達`も実機未確認。0.1秒ごとの描き直しによる電池への影響も未計測。
- Android Widget は未実装。採用する場合は `app/android/` に AppWidgetProvider/Glance を実装し、Pro未加入・未設定時の全国 fallback を iOS の `WidgetRegionResolver` と揃えてテストする。
- extension 版番号は [ビルド・配布](950_build_and_release.md) の300を参照。

## 800: テスト通知と旧EEW Live Activityの実機確認

- テスト通知画面で6種類のプッシュ通知を受信し、表示・音・テスト画面への遷移を確認する。通知条件が無効・不一致でも本人の端末だけに配信されることを確認する。
- 旧EEW専用の予報・警報・最終報・取消をローカルで開始・更新・終了し、ロック画面とDynamic Islandのテスト表記を確認する。画面の再表示・アプリ再起動後の復元、Live Activity許可を無効にした場合の終了も確認する。
- LinuxでのDart解析はApple SDKによるビルドや実機での表示・到着の検証を代替しない。今回のSwift変更はApple SDKで未ビルド。サーバからのLive Activity配信検証は別途行う。

## 800: 統合 Live Activity 撤去後の確認

- 統合専用 Widget と Preview を削除した構成で、`EQMonitorPreview` と Runner を Apple SDK でビルドする。Linux では未検証。
- 実機で従来の EEW Live Activity の開始・更新・終了と通常の地震 Widget の表示を確認する。
