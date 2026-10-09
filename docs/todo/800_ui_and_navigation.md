# 表示・ナビゲーションの残課題

数値は元の優先度。実機表示の確認は未完了。

## 800: 通知設定の権限導線の実機確認

- iOS・Android実機で、通常時の下部権限設定、不足時の上部カード、推奨・すべて保存後のModalを確認する。
- 「あとで」、OS側の拒否、設定アプリからの復帰後もプリセットと通知条件を維持し、許可後はカードが消えることを確認する。
- iOSの重大な通知の初回要求・拒否後の設定変更、Androidの初回要求・再要求不可時の設定変更を確認する。非対応端末では重大な通知を表示しない。
- 権限取得のタイムアウト・再試行、通知受け取りOFF、文字拡大・Light/Darkも確認する。実機検証は未実施。
- テスト通知画面で、Android では Live Activity タブ・表示テスト・設定画面の案内が表示されず、6 種類のプッシュ通知を選択できることを確認する。iOS では両タブと Live Activity の表示テストを確認する。実機検証は未実施。
- Android でホーム画面ウィジェットの設定入口が表示されず、警報テストの確認文と現在地の警報設定が通知チャンネルの案内になることを確認する。iOS ではウィジェット設定と重大な通知の説明を維持する。実機検証は未実施。

## 800: ファイルから追加する通知音

- iOS 向けの取り込み・変換・保存・試聴・選択・管理を実装。通知音導入時の Apple SDK archive・IPA 作成・TestFlight アップロードは [CD](https://github.com/YumNumm/EQMonitor/actions/runs/36690312733) で成功。実機検証は未実施。
- [設計案](../superpowers/specs/2026-09-30-custom-notification-sounds-design.md) と [実装計画](../superpowers/plans/2026-09-30-custom-notification-sounds.md) を参照する。
- 対象: `app/lib/feature/settings/features/notification_settings/`、`app/ios/Runner/`、`app/ios/Packages/NotificationSounds/`、App Group の `Library/Sounds/`。
- macOS で Runner・FcmServiceExtension の Simulator build を確認する。通知音モデルの JSON キー修正後に、iOS 実機で Files からの取り込み・変換・保存・管理を確認する。実機での取り込みと再生は CD のビルド成功だけでは検証できない。
- MP3・AAC/M4A・WAV・AIFF・CAF、mono/stereo、異なる sample rate、29.9秒・30秒・長い音、破損・DRM・クラウド source の失敗を確認する。容量不足・カタログ保存失敗・変換中の終了・再起動後の回収と file protection も未検証。
- 報告された元の WAV・MP3 を使い、iOS 27.2 と iOS 17.6 実機で Files からの取り込み・試聴・保存を確認する。iOS 27.0 Simulator ではテスト用音声による修正前の失敗・修正後の成功を確認済みだが、報告端末・元ファイルでの確認は未実施。
- 通知音の失敗時に、リリース版の「詳細」表示と「まとめてコピー」で処理名・失敗箇所・取得できた OS エラーの domain/code を確認する。通常の案内に技術情報が混ざらないことと、ファイル名・パスが診断情報に含まれないことを iOS 実機で確認する。未検証。
- Light/Dark・大きい文字・長い日本語名・VoiceOver・Pro 失効時を確認する。使用中・snapshot 内・未保存編集の音の削除禁止、通信失敗・壊れたカタログ・欠損ファイルからの再追加を確認する。
- EEW 予報・地震情報・震度別 override の実通知で保存名・最終 APNs payload・再生音を照合する。前面・バックグラウンド・アプリ終了・ロック中・再起動後（初回 unlock 前後）、passive の無音、critical、続報上書き、欠損時 fallback を確認する。試聴や APNs HTTP 200 だけでは完了としない。

## 900: 複数通知地域が一致した場合の震度別設定の優先順位

- 通常の EEW 予報・地震情報の最終選択は、候補配列の最後の音・割り込みを採用する。SQL に並び順の指定がなく、異なる対象震度でも、全国の重大な通知が現在地のデフォルトへ下がる場合を純粋な選択関数で確認した。
- 優先順位の方針を決め、backend の候補選択を決定的にする。音と割り込みは選択した同じ候補から採用し、EEW 警報・Live Activity の別経路と混同しない。
- [backend の既存 TODO](https://github.com/YumNumm/eqmonitor-backend/blob/a9a1d7987a0e4e8000d04ba3b464b1997e5f685f/docs/todo/250_notification_slots_minor_findings.md#L25-L30) の同値 tier に限らず、異なる対象震度の競合も対象にする。決定規則を修正するまでは UI で現在地優先・強い通知優先を保証しない。

## 800: 通知トークン同期の実機確認

- 対象: `app/lib/feature/devices/`。起動時の更新中表示が消え、登録・同期は継続することを iOS・Android 実機で確認する。未検証。
- FCM・通知用 APNs・APNs Push-to-Start ごとに、同値で24時間未満は送信なし、変更時と24時間経過後は送信ありになることを再起動・復帰後の通信で確認する。失敗後の再試行とデバイス再登録も確認する。実機検証は未実施。

## 800: Android 前面通知の実機確認

- 対象: `app/lib/core/fcm/local_notification_repository.dart`、`firebaseMessagingForegroundProvider`、通知タップ処理。
- アイコン保持指定を含む release AAB / APK で `drawable/ic_notification_icon` の画像とリソース登録が残ることを確認する。その成果物を Android 実機に入れ、テスト通知の前面表示時に `invalid_icon` が発生しないことを確認する。修正後の成果物・実機検証は未実施。
- Android 実機でアプリ表示中の通常・重大テスト通知と地震通知を送り、通知欄への表示・音・チャンネルの利用者設定を確認する。前面・バックグラウンド・アプリ終了後に通知をタップし、リンク先へ遷移することを確認する。実機検証は未実施。
- 同じ tag の通知を前面・バックグラウンドをまたいで更新した場合の重複を確認する。ローカル通知はタップ先の上書きを避けるため通知ごとの ID を使い、FCM の通知 ID `0` と一致しない。
- 配信側の `test` / `test_critical` などの旧チャンネル ID を現行 registry と照合し、現行 ID へ更新する。未登録 ID の通知が既定チャンネルへ流れる状態を解消する。

## 800: 揺れ検知通知の細分化地域設定

- 実機で権限、OS終了後の位置同期、APNs／FCMの通知文面を確認する。実機検証は未実施。

## 800: 地域選択の非表示フィルター修正後の実機確認

- 対象: `app/lib/feature/region_selection/`。iOS 実機で地図の初期表示、選択・全解除、地域種別切り替え、震央選択からの切り替えを確認する。クラッシュせず、解除後のハイライトと不要な震央領域が消えることを完了条件とする。実機の画面操作は未検証。

## 800: material_ui 境界

- `app/lib/feature/settings/children/application_info/{about_this_app,term_of_service_page,privacy_policy_page}.dart` の Markdown に明示的なstyleまたは共通rendererを渡し、`feature/changelog/ui/page/changelog_page.dart` と共通化する。完了条件: Light/Darkで本文/リンクが読める。
- `app/lib/core/router/` と onboarding/paywall の Hero は go_router が Flutter本体 MaterialApp を検出できず、素の `HeroController` となる問題を確認する。対応controllerの供給方法を決め、Hero軌跡を確認する。
- 新たな material依存hook/localizations の導入時は型境界を確認する。既存の DefaultTabController、明示的delegate import、MaterialPageMixin は維持する。

## 650: onboarding 権限読み取りの実機確認

- 対象: `PermissionRepository.getNotificationPermission()` と onboarding の権限ステップ。
- iOS 27.0 Simulatorで通知設定取得が未完了となり、通知サービス再起動で復帰する事象を確認。OSサービス側の根因は未確定。
- iOS / Android実機で、通常の許可・拒否・復帰時再取得と、取得失敗時のエラー表示・再試行・戻る操作を確認する。実機検証は未実施。

## 650: onboarding 通知プリセットの build 中更新

- 対象: `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`、`app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart`。
- `useEffect` から親の ValueNotifier を同期更新する初期化を build 前へ移すか、初回 build 後一度だけ通知する。
- 完了条件: 新規ユーザー相当のテストで初期プリセット/変更値が正しく、`setState() or markNeedsBuild() called during build` が出ない。iOS初回画面も確認する。

## 500: 地震履歴詳細の地図設定

- 対象: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_details_settings_sheet.dart` と詳細地図の観測点・震央レイヤー。
- iOS/Android 実機で右上の設定シートを開き、通常の観測点表示と推計震度への観測点の重ね合わせを独立して切り替えられること、震央との重なり順、画面を開き直した後・再起動後の設定保持を確認する。推計震度への重ね合わせは初期値オフ。実機表示は未検証。
- 防災情報XML・長周期地震動・推計震度・震度データベースで、アイコンの遅延読み込み後と表示元切り替え後も重なり順が保たれ、非表示の観測点をタップできないことを確認する。地図の拡大率・中心の維持と、Light/Dark・文字拡大時のシート操作も確認する。
- iOS/Android実機で、Sheet初期位置の上の凡例が地図モードに合い、タップで最大階級を手前にした上位3枚の重ね合わせへ往復することを確認する。推計震度の地図と凡例の専用配色、未確定の「5弱以上」の除外、Sheet背面への配置、Sheet移動量に応じたフェードと復帰、非表示時の地図操作、縦横・狭いペイン・文字拡大・アニメーションを減らす設定を確認する。実機検証は未実施。
- 凡例を重ねた各アイコンの薄い影と、展開・折りたたみ時の軽い触覚フィードバックを実機で確認する。展開中は影が消え、単独アイコンには影が付かないことも確認する。未検証。

## 500: 地震/EEW履歴のタブレット検証

- 対象: `app/lib/feature/earthquake_history/ui/`、`app/lib/feature/eew/ui/`。以前の静的解析は表示確認の根拠ではない。
- 完了条件: 839/840dp、縦横/OS分割、縦横ヒンジ・幅0折り目・狭い片側で操作が隠れない。選択後の幅変更で選択/一覧位置/地図/シートを維持する。
- loading/error/empty/retry と読み込み中scroll、文字拡大、Light/Dark、選択枠、EEW各報横scroll、地図tap/zoom/シート/戻る/詳細URLを確認する。別イベント選択・詳細閉じる時はEEW再生が止まる。

## 450: 火山噴火の表示の実機確認

- iOS / Android 実機で、履歴一覧・近傍地震カード・詳細ヘッダーの噴火情報に M がない場合、マグニチュード欄が表示されず、補足に「大規模な火山の噴火」が表示されることを確認する。実機表示は未検証。
- M がある噴火と通常地震・遠地地震の既存表示を維持し、Light/Dark・文字拡大時も補足が読めることを確認する。
- 関連する既存 Widget テストとブラウザープレビューは、ディスク容量不足で実行が完了していない。空き容量を確保した環境で確認する。

## 400: 現在地震度カードの市区町村名

- 対象: `app/lib/feature/earthquake_history/ui/components/current_location_intensity_card.dart`。iOS / Android 実機で、江戸川区・府中市・利島村の見出しが「東京都江戸川区」「東京都府中市」「東京都利島村」となり、観測点名と震度表示を維持することを確認する。実機表示は未検証。
- 東京都以外にも、気象庁の識別用名称を連結した「青森県青森南部町」「大阪府大阪堺市堺区」などが表示されうる。正式市区町村名との対応を地域コードで照合し、表示方針を決める。完了条件: 識別用の県名接頭辞と政令市名の省略を適切に扱い、「青森市」「大阪狭山市」などの正式名称を損なわない。

## 400: iOS swipe back と PopScope

- 対象: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`、`intensity_history/ui/intensity_history_page.dart`、`live_monitor/ui/page/live_monitor_page.dart`（後2つは同feature root）。
- `canPop: false` ではiOS gesture自体が開始しない。並び替え/地域focus解除を画面内UIへ移してpop可能にするか決める。LiveMonitor終了確認は維持する必要性を判断する。
- 完了条件: iOS edge swipeとAndroid system backの意図した動作を各状態で確認し、解除/終了確認のテストを維持する。

## 400 / 200: scroll と共有見出し

- 400: `theme_settings_page.dart` のスクロール内容に `SafeArea` を追加済み。Android の3ボタン・ジェスチャーナビゲーションと iOS 実機で、末尾の「JSONをインポート」をシステムUIに重ねず表示・操作できることを確認する。横画面・文字拡大時のスクロールも未検証。
- 400: 地震詳細・EEW履歴・津波詳細のシート内スクロールを Home と同じ `BottomBouncingScrollPhysics` に設定済み。iOS / Android 実機で上端からのシート縮小、下端のバウンド、EEW表の横スクロールを確認する。実機検証は未実施。
- 400: `app/lib/page/home_page.dart` の `_SheetBody` を遅延list/sliverへ移す場合は、sheet drag・`BottomBouncingScrollPhysics` の追従/bounceを確認する。
- 400: `app/lib/feature/home/ui/component/sheet/sheet_header.dart` を利用featureに依存しない `app/lib/core/component/` へ移し、earthquake history / kyoshin monitor の呼び出しとspacing/typographyを揃える。
- 200: `LiveMonitorEarthquakeCard` の全行先行生成をindexからのpresenter/遅延構築へ変更する。完了条件: 通常/大文字/縦横分割でcard高さ・内部scrollを維持し、画面外行を先行生成しない。

## 300: IntensityHistoryState の命名

- `app/lib/feature/intensity_history/data/model/intensity_history_state.dart` の `prefecture()`→`nationwide()`、`city(...)`→`prefectureFocused(...)`、controllerの `backToPrefecture()`→`backToNationwide()` を検討する。
- 完了条件: controller/map action/page/fill layer/region panelと `app/test/feature/intensity_history/` を追従しFreezed再生成。別都道府県tapの既存修正を回帰させない。

## 800: M3E 移行後の実機表示・操作確認

- 緊急地震速報の履歴は、地震履歴と同じ `Scaffold.appBar` とフィルター行の構造に変更済み。iOS / Android 実機で初期表示・引っ張って更新中も見出しとフィルターの位置がズレず、発表中の EEW・絞り込み・追加読み込み・詳細表示が動作することを確認する。実機検証は未実施。
- `telegram_list_by_event_id_page.dart` の緊急地震速報カードはクリップを設定済み。iOS / Android の Light・Dark で、押下時のハイライトがカードの角丸からはみ出さず、行全体のタップで該当イベントの EEW 詳細へ遷移することを確認する。実機検証は未実施。
- `home_earthquake_history_sheet.dart` の現在地更新中に既存一覧が維持され、「最近の地震」の右側の進捗表示だけが切り替わることを確認する。同一市区町村での再取得抑止は Widget Test で確認済み、実機検証は未実施。
- iOS / Android の Light・Dark、文字拡大、VoiceOver / TalkBack で、選択値・無効状態・ボタン表示とスライダーの増減を確認する。Widget Test の成功と実機検証を区別する。
- モーダルのキーボード表示時、画面分割時の高さ・スクロール、地図操作パネルとの重なりを確認する。
- `shindo_db_station_detail_sheet.dart` は実機未検証。最大加速度・周期を含む観測点で、縦横画面・文字拡大時に末尾までスクロールでき、Light / Dark の表の文字を読めることを確認する。
- 通知上書き設定の削除失敗時に項目が復元され、別の項目が消えないことを実通信でも確認する。
- iOS 実機で、地震情報の通常設定・震度別設定の優先度が「サイレント」「デフォルト」「即時通知」のみであることと、通知の上書きの説明が地震情報向けに表示されることを確認する。実機検証は未実施。
