# App Intents の取得結果・地域・Entity の契約

Issue: https://github.com/YumNumm/EQMonitor/issues/1794

## 取得結果と更新

- 主Intentの戻り値・音声応答・初回カードは同じ取得結果を使う。カードの再描画で再取得しない。
- Snippetへ渡すのは取得結果ID。actorのセッション内キャッシュに地域・最小震度・件数・取得日時を保持する。
- 明示更新は同じ条件のカードを更新し、更新済みIDのSnippetを返す。後続アクションへ渡した値は変更しないことをカードに表示する。
- キャッシュ消失・1時間経過時は再実行を案内する。最新情報や全国情報へ無言で置き換えない。
- 1時間は描画キャッシュの保持期限であり、位置情報や地震情報の有効期限を意味しない。
- AppleはSnippetの繰り返し実行と表示中のプロセス保持を説明している。
  https://developer.apple.com/documentation/appintents/displaying-static-and-interactive-snippets

## 保存地域

- GPSを取得しないIntentで現在地と断定しない。常に「保存地域（実際の地域名）」とし、位置の取得時刻不明・現在地とは限らない旨を音声とカードで案内する。
- 既存の保存位置には取得時刻がないため、鮮度を推測した時刻やTTLは付与しない。
- 保存地域が未設定・名前不明・更新後にコードが変わった場合は再実行を案内する。古いカードを新しい地域へ無言で切り替えない。
- 任意の都道府県・市区町村は同梱コード表で検証し、主Intent・カード・更新の各入口でPro加入を確認する。
- 無料のregion指定は現在の保存コードと一致するものだけ。壊れた指定を全国へフォールバックしない。

## Entity と API

- 全体最大震度と地域震度を別プロパティにする。訓練・試験状態、日時、数値、震度分類も戻り値へ含める。
- 「M8超」「ごく浅い」「700km以上」等を正確な数値として扱わない。発生日時不明を現在時刻にしない。
- 過去の震度5・6、非数値分類、未入電はAppEnumでも区別する。
- IDの再解決は詳細APIの最新情報。地域検索ではないため地域震度はnil。404は結果から除外し、通信・デコード失敗を空の成功結果にしない。
- 詳細APIのIDが要求IDと異なる場合もエラーにする。
- 公開詳細APIでearthquake_typeの存在を確認。Swift元スキーマのEarthquake/Intensityを修正し、生成器で再生成した。
- 既存の限定生成スクリプトは型名を受け取れる。全生成で旧Live Activity操作が消える課題は引き続き別途整理する。

```sh
cd app/ios/Packages/EQMonitorAPI
python3 Scripts/generate-intensity-partial.py /path/to/swift-openapi-generator Earthquake Intensity
```

## 検証手順と到達範囲

```sh
xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=macOS' -derivedDataPath /private/tmp/eq1794-derived \
  CODE_SIGNING_ALLOWED=NO test
xcodebuild -project app/ios/Runner.xcodeproj -target AppIntentExtension -target WidgetExtension \
  -configuration Debug -sdk iphoneos CODE_SIGNING_ALLOWED=NO \
  SYMROOT=/private/tmp/eq1794-device/products OBJROOT=/private/tmp/eq1794-device/intermediates build analyze
```

- worktreeのXcode解決には生成済みFlutter/ephemeral/PackagesとEnvironment.xcconfig、Generated.xcconfigが必要。既存checkoutへのローカル参照はコミットしない。
- XcodeによるPackage.resolvedやRunner.xcodeproj/-Xcc/の副作用を機能差分へ混ぜない。
- Swift共有テスト148件（15 suites）、AppIntentExtension/WidgetExtensionのiPhone向け署名なしbuild・静的解析が成功。Flutterコードは変更していないためFlutterテストは追加していない。
- 拡張のCFBundleDisplayNameと生成NLUのapplicationName同義語はEQMonitorを確認。
- 署名なしbuild・共有テストは、Siri実機呼び出し・登録・Snippet更新・署名を証明しない。
- 2026-09-10の確認でdeeplink.eqmonitor.appが名前解決できなかった。既存OpenURLIntentのカスタムスキームは未解決。確認できないUniversal Linkへ置き換えない。
