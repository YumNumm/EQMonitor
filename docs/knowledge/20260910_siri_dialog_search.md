# Siriの読み上げと地域検索の実装・検証ルール

## 読み上げは表示用フォールバックを事実として扱わない

- `EarthquakeIntentDialog`はAPIの震源名・詳細名と元の日時を使う。Widget見出しの「最大震度…」を震源として読まず、日時欠落を現在日時で補わない。
- 地域検索でも地震全体の最大震度を別に保持する。地域の震度と全体最大震度を区別する。
- Flutterと同じく`max_intensity_class`を優先し、歴史上の震度5・6を5弱・6弱に置換しない。非数値分類は分類名として伝える。
- 訓練・試験は詳細より先に伝える。遠地地震と火山噴火を区別し、欠けたM・深さを補わない。
- 発生時刻がない場合は検知時刻と区別する。`origin_time_precision`が月・日・時の場合は分まで読まない。Flutterの履歴表示には精度を尊重しない既存課題がある。
- 全件読み上げではなく、取得件数を伝えて最新の1件を読む。保存位置は「アプリに保存された現在地の地域」と伝える。位置の鮮度保証は別課題。

## 検索IntentはRunnerで実行する

- Xcode 27 beta 4の`.system.searchInApp`はiOS 27以上。`StringSearchCriteria.term`をアプリ内検索へ渡す。
- Appleの`OpenURLIntent`契約はUniversal Link限定で、カスタムスキームは対象外。`eqmonitor:///earthquake-history/search?query=...`はRunnerの`UIApplication.shared.open`から既存app_links導線へ渡す。
- URLは`URLComponents`で構築し、日本語・`&`・`+`・`/`・`#`を損失なく渡す。
- 検索は地域名に限定する。同名市区町村は所属地域とともに候補表示し、利用者が選択する。曖昧な自然文を全国検索に置換しない。
- 検索パラメータは既存`ParameterSet`を使う。読み込み失敗時に内部例外を表示せず、再読み込みを案内する。

## Swift API生成時の注意

現在の元スキーマには、生成済みClientに存在する旧Live Activity操作5件が含まれない。通常の全生成は既存APIを削除するため、契約整理まで対象型だけを生成器で更新する。

```sh
cd app/ios/Packages/EQMonitorAPI
python3 Scripts/generate-intensity-partial.py /path/to/swift-openapi-generator
```

今回使用したAppleの生成器は1.10.4。生成物を手編集せず、`openapi.json`の`IntensityPartial`を修正してから実行する。これは暫定手順であり、元契約の整理はIssue #1794で追跡する。

## Simulatorを使わない検証

```sh
xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO test
xcodebuild -project app/ios/Runner.xcodeproj -target AppIntentExtension \
  -configuration Debug -sdk iphoneos CODE_SIGNING_ALLOWED=NO
cd app
mise exec -- flutter test test/feature/earthquake_history/earthquake_region_search_test.dart \
  test/core/router/earthquake_history_search_route_test.dart \
  test/feature/earthquake_history/earthquake_history_search_page_test.dart
```

- Swift共有テスト122件、Flutter追加10件、Flutter既存表示・変換30件が成功。変更したDartソース・テストの静的解析成功。
- Flutterテストはworktree内の配信用parametersアセット未配置を警告したが、今回のテストはfixture/Provider overrideを用いて成功。配布アセットを使うE2E検証ではない。
- Flutterによるプラグインリンクの再生成とXcodeの依存解決を同時に実行しない。Firebaseのtargetがemptyと誤認される場合があり、再生成完了後の再実行で解消した。
- build_runnerの`--build-filter`指定でも範囲外の生成済みファイルが削除される場合がある。生成前後の差分を必ず確認し、無関係な生成物の削除・変更を含めない。
- AppIntentExtensionのiPhone向け署名なしbuild成功。Runnerの新しい検索IntentはiOS 27 SDKでマクロを含むSwift型検査成功。本体アプリの全体buildは実行していない。
- 署名なしbuild・型検査・単体テストは、実機Siriの登録・音声・画面遷移・日本語での認識を保証しない。Simulatorも実機Siriも今回実行していない。

## 公式資料

- https://developer.apple.com/videos/play/wwdc2026/343/
- https://developer.apple.com/documentation/appintents/openurlintent
- https://developer.apple.com/videos/play/wwdc2026/240/
