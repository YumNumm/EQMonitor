# 表示・ナビゲーションの残課題

数値は元の優先度。実機表示の確認は未完了。

## 800: material_ui 境界

- `app/lib/feature/settings/children/application_info/{about_this_app,term_of_service_page,privacy_policy_page}.dart` の Markdown に明示的なstyleまたは共通rendererを渡し、`feature/changelog/ui/page/changelog_page.dart` と共通化する。完了条件: Light/Darkで本文/リンクが読める。
- `app/lib/core/router/` と onboarding/paywall の Hero は go_router が Flutter本体 MaterialApp を検出できず、素の `HeroController` となる問題を確認する。対応controllerの供給方法を決め、Hero軌跡を確認する。
- 新たな material依存hook/localizations の導入時は型境界を確認する。既存の DefaultTabController、明示的delegate import、MaterialPageMixin は維持する。

## 650: onboarding 通知プリセットの build 中更新

- 対象: `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`、`app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart`。
- `useEffect` から親の ValueNotifier を同期更新する初期化を build 前へ移すか、初回 build 後一度だけ通知する。
- 完了条件: 新規ユーザー相当のテストで初期プリセット/変更値が正しく、`setState() or markNeedsBuild() called during build` が出ない。iOS初回画面も確認する。

## 500: 地震/EEW履歴のタブレット検証

- 対象: `app/lib/feature/earthquake_history/ui/`、`app/lib/feature/eew/ui/`。以前の静的解析は表示確認の根拠ではない。
- 完了条件: 839/840dp、縦横/OS分割、縦横ヒンジ・幅0折り目・狭い片側で操作が隠れない。選択後の幅変更で選択/一覧位置/地図/シートを維持する。
- loading/error/empty/retry と読み込み中scroll、文字拡大、Light/Dark、選択枠、EEW各報横scroll、地図tap/zoom/シート/戻る/詳細URLを確認する。別イベント選択・詳細閉じる時はEEW再生が止まる。

## 450: 火山噴火一覧の「M不明」

- `app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart` の trailing を種別対応し、噴火時は省略または短い種別labelにする。文言を決めてから実装する。
- 完了条件: 履歴一覧/近傍地震カードの両方で噴火を地震のM欠損と誤表示せず、通常地震の既存表示は維持する。関連既存テストを確認する。

## 400: iOS swipe back と PopScope

- 対象: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`、`intensity_history/ui/intensity_history_page.dart`、`live_monitor/ui/page/live_monitor_page.dart`（後2つは同feature root）。
- `canPop: false` ではiOS gesture自体が開始しない。並び替え/地域focus解除を画面内UIへ移してpop可能にするか決める。LiveMonitor終了確認は維持する必要性を判断する。
- 完了条件: iOS edge swipeとAndroid system backの意図した動作を各状態で確認し、解除/終了確認のテストを維持する。

## 400 / 200: scroll と共有見出し

- 400: `app/lib/page/home_page.dart` の `_SheetBody` を遅延list/sliverへ移す場合は、sheet drag・`BottomBouncingScrollPhysics` の追従/bounceを確認する。
- 400: `app/lib/feature/home/ui/component/sheet/sheet_header.dart` を利用featureに依存しない `app/lib/core/component/` へ移し、earthquake history / kyoshin monitor の呼び出しとspacing/typographyを揃える。
- 200: `LiveMonitorEarthquakeCard` の全行先行生成をindexからのpresenter/遅延構築へ変更する。完了条件: 通常/大文字/縦横分割でcard高さ・内部scrollを維持し、画面外行を先行生成しない。

## 300: IntensityHistoryState の命名

- `app/lib/feature/intensity_history/data/model/intensity_history_state.dart` の `prefecture()`→`nationwide()`、`city(...)`→`prefectureFocused(...)`、controllerの `backToPrefecture()`→`backToNationwide()` を検討する。
- 完了条件: controller/map action/page/fill layer/region panelと `app/test/feature/intensity_history/` を追従しFreezed再生成。別都道府県tapの既存修正を回帰させない。

## 800: M3E 移行後の実機表示・操作確認

- iOS / Android の Light・Dark、文字拡大、VoiceOver / TalkBack で、選択値・無効状態・ボタン表示とスライダーの増減を確認する。Widget Test の成功と実機検証を区別する。
- モーダルのキーボード表示時、画面分割時の高さ・スクロール、地図操作パネルとの重なりを確認する。
- 通知上書き設定の削除失敗時に項目が復元され、別の項目が消えないことを実通信でも確認する。
