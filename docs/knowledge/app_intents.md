# App Intents・Siri・Control Center

2026-09-21統合。取得結果の一貫性と保存地域の意味を優先する。
過去の署名なしbuild・共有テスト成功は、Siri実機登録や日本語認識の証明にしない。

## 取得結果と保存地域

- 主Intentの戻り値・音声・初回カードは同じ取得結果。Snippetには結果IDを渡し、再描画で再取得しない。
- actorのsession cacheへ地域・最小震度・件数・取得日時を保存する。明示更新は同じ条件のカードを更新し、
  後続アクションへ渡した値は変わらないことを表示する。
- cache消失/1時間経過時は再実行を案内する。全国や最新データへ黙って置換しない。
  1時間は描画cache期限であり、位置・地震データの鮮度保証ではない。
- GPS取得をしないIntentは「保存地域（実際の地域名）」とし、現在地とは限らず取得時刻不明と音声/カードで伝える。
  保存位置にない時刻やTTLを推測しない。旧「保存された現在地」という表現よりこの区別を優先する。
- 地域未設定・名前不明・更新後コード変更は再実行案内。古いカードを別地域へ切り替えない。
- 任意の都道府県/市区町村は同梱コード表で検証し、主Intent・カード・更新の各入口でProを確認する。
  Freeのregion指定は現在保存コードと一致するものだけ。壊れた指定を全国へフォールバックしない。

## Entityと読み上げ

- 全体最大震度と地域震度を別propertyへ保持し、日時・数値・分類・訓練/試験状態も公開する。
- max_intensity_classを優先し、歴史上の震度5/6を5弱/6弱に置換しない。
  非数値分類、未入電、M8超、ごく浅い、700km以上を正確な数値に変換しない。
- EarthquakeIntentDialogは元の震源名/詳細名・日時を使う。Widget見出しを震源名として読まず、
  発生時刻欠落を現在時刻で補わない。origin_time_precisionが月/日/時なら分まで読まない。
- 訓練/試験を先に伝え、遠地地震と火山噴火、発生と検知時刻を区別する。M/深さ欠落を補わない。
- 件数を伝え最新1件を読む。取得日時と地震発生日時を区別する。
- ID再解決は詳細APIの最新情報。地域検索ではないので地域震度はnil。
  404は除外、通信/デコード失敗や要求IDとの不一致はエラーとし、空の成功へ変換しない。

## 検索・Control Center

- RunnerのSearchEarthquakesIntentはiOS 27以上の.system.searchInAppを使う。
  StringSearchCriteria.termを既存地域検索へ渡し、任意自然文を全国検索に置換しない。
- URLComponentsで日本語や`& + / #`を保持する。既存ParameterSetで地域候補を解決し、
  同名市区町村は所属地域とともに利用者へ選択させる。読込失敗は再読込を案内する。
- OpenURLIntentのUniversal Link契約へカスタムスキームを渡さない。
  RunnerのUIApplication.openから既存app_linksへ渡す。未確認のUniversal Linkへ置き換えない。
- Control CenterはSnippetを表示できない。画面を開くOpenIntentをRunner/WidgetExtension両方へ含め、kindを保つ。
- UIKitアクセスはRunnerでAppDependencyManagerへ登録し、共有Intentへ直接持ち込まない。
- 単体テストでperformを直接呼ぶ場合は、アクセス前にintent.navigationへ依存を注入する。
  システム実行時の@Dependency自動解決を直接呼出しでも期待するとクラッシュする。

## コード確認と生成契約

- 確認済み: `app/ios/AppIntentExtension/EarthquakeSnippetIntent.swift`はsnapshot IDと
  request/limit/minIntensityを照合し、明示更新でも同じ条件を確認する。
- `app/ios/Shared/OpenEarthquakeHistoryIntent.swift`はOpenIntentと注入navigationを使用する。
  `app/ios/Runner/SearchEarthquakesIntent.swift`はUIApplication経由で検索URLを開く。
- 旧Swift API元スキーマに既存Live Activity操作が欠け、全生成で操作が消える事例がある。
  現在の元契約と生成Clientを照合し、生成物を手編集しない。
- 暫定の型限定生成は`app/ios/Packages/EQMonitorAPI/Scripts/generate-intensity-partial.py`。
  元スキーマを変更してからgeneratorへEarthquake/Intensity等の対象型を渡す。
  旧欠落が今もあるかは再確認し、限定生成を恒久的な契約修復とみなさない。

## 検証手順と到達範囲

```sh
# repository rootから
xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO test
xcodebuild -project app/ios/Runner.xcodeproj -target AppIntentExtension -target WidgetExtension \
  -configuration Debug -sdk iphoneos CODE_SIGNING_ALLOWED=NO build analyze
# app/から
mise exec -- flutter test test/feature/earthquake_history/earthquake_region_search_test.dart \
  test/core/router/earthquake_history_search_route_test.dart \
  test/feature/earthquake_history/earthquake_history_search_page_test.dart --dart-define=CI=true
```

- Runner全体は`-scheme Runner`でbuildし、Flutter準備を飛ばしたnative型検査を全体成功と報告しない。
- 署名なし拡張buildはcompile/link/metadata、共有テストはlogicの検証。
  Runner埋め込み・署名・App Group読出し・Siri登録/音声・Snippet更新・Control実タップは別途確認する。
- 実機では保存地域変更、cache期限切れ、Pro条件変更、終了状態からのControl起動も確認する。
- Flutterのpluginリンク再生成とXcode依存解決を同時に走らせない。
  依存解決の副作用や既存checkoutへのローカル参照を機能差分へ混ぜない。
- 本統合では上記を再実行していない。残件の入口は[Apple拡張](../todo/930_apple_extensions.md)。

## 将来候補

- IndexedEntity/Core Spotlight、NSUserActivity、View annotation、Transferableは候補であって実装済みではない。
  更新/取消/訓練状態を考慮し、Flutter画面とnativeの接続を設計する。
- App Schemaは機能の意味に合うものを選ぶ。検索Intent追加だけで自由な自然言語操作を保証しない。
- AppIntentsTestingは同一Development Teamの署名と実行対象アプリを伴う統合試験。
  署名なし拡張buildで代替しない。Siri AIの言語/機種/提供時期は導入時に公式情報を再確認する。

公式資料: [Snippet](https://developer.apple.com/documentation/appintents/displaying-static-and-interactive-snippets)、
[OpenURLIntent](https://developer.apple.com/documentation/appintents/openurlintent)、
[Controls](https://developer.apple.com/documentation/widgetkit/creating-controls-to-perform-actions-across-the-system)。
