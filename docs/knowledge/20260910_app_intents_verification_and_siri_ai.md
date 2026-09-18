# App Intents の検証と Siri AI 連携

## 検証範囲を分ける

- iPhone 向け署名なし build はコンパイル・リンク・メタデータ生成の確認。
- macOS / Mac Catalyst の WidgetModelsTests は共有ロジックの確認。
- どちらも iPhone 上の Siri 呼び出し・Snippet 表示・App Group 読み取りの成功を証明しない。
- 拡張単体 build は Runner への埋め込み・署名・配布の検証ではない。
- Simulator を使わない検証では次のコマンドを利用できる。

```sh
xcodebuild -project app/ios/Runner.xcodeproj -target AppIntentExtension \
  -configuration Debug -sdk iphoneos CODE_SIGNING_ALLOWED=NO \
  SYMROOT=/private/tmp/eqmonitor-appintent-audit/products \
  OBJROOT=/private/tmp/eqmonitor-appintent-audit/intermediates build
xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO test
```

## 2026-09-10 の確認結果

- 対象 HEAD: `ca0ca5e11`。Xcode 27.0 beta 4 / 27A5228h。
- 拡張 build 成功。Mac Catalyst の既存テスト108件・10 suites成功。
- 拡張の MinimumOSVersion は26.0。AppShortcut 2件・Intent 3件・Entity 2件を生成。
- `Metadata.appintents/extract.actionsdata` の assistantIntents / assistantEntities は空。
- 同梱地域マスタは都道府県47件、市区町村4361件。フォントも同梱。
- `root.ssu.yaml` の applicationName 同義語は `AppIntentExtension`。
  メインアプリへの登録時にどう扱われるかは未確認。実機の呼び出し検証が必要。
- 公開APIの全国、region/350、prefecture/13、city/1310100 は curl で各HTTP 200。
  全国はlimit=1、地域系はlimit=1&intensityGte=1で確認。
  これはHTTP/JSON応答の確認であり、Swift経由の実行・デコード成功ではない。
- APIの地震データ自体の鮮度は、この疎通検査では保証しない。
- 今回は調査のみで動作コード・テストは追加しない。既存テストと拡張buildで確認した。
- Xcode実行によるPackage.resolved差分と`Runner.xcodeproj/-Xcc/`は調査後に除去した。

## Siri AI 連携の方針

- 既存は日本語の定型App ShortcutsとiOS 26のInteractive Snippet。
- `ProvidesDialog`で、確認済みの地震情報から読み上げ文を組み立てる。
  最大震度・地域震度・発生日時・情報取得日時を区別する。
- Entityは日時・数値・地域・電文状態を型付きで公開し、IDから復元できるようにする。
- `IndexedEntity`とCore Spotlightで、閲覧した地震を検索可能にする候補がある。
  更新・取消・訓練状態の反映を含めて設計する。
- 詳細画面は`NSUserActivity`、複数項目はView annotationでEntityと関連づける候補。
  Flutter画面にはSwiftUIのmodifierを直接適用できないため、ネイティブ連携が必要。
- `Transferable`で地震の説明・URLを公開し、他アプリへの共有につなげる候補。
- `.system.searchInApp`でSiriからアプリ内検索へ誘導できる。
  任意の地震検索Intentを追加するだけで自由な自然言語操作が保証されるわけではない。
  App Schemaは機能の意味に適合するものを選び、無関係なドメインへ当てはめない。
- 新しいAppIntentsTestingはUI操作なしでシステム経由の実行をテストできる。
  XCUITest bundleと同一Development Teamの署名を使い、実行対象アプリが必要。
  署名なしの拡張buildだけでこの統合テストが実施できるとは扱わない。
- Appleの2026-06-08発表ではSiri AIはiOS 27世代、初期betaは英語。
  Apple Intelligence全体の日本語対応と、新Siri AIの日本語提供を混同しない。
  提供時期・対象機種・言語は導入時点の公式情報で再確認する。

## 公式資料

- https://developer.apple.com/videos/play/wwdc2026/240/
- https://developer.apple.com/videos/play/wwdc2026/343/
- https://developer.apple.com/videos/play/wwdc2026/295/
- https://www.apple.com/jp/newsroom/2026/06/apple-introduces-siri-ai-a-profoundly-more-capable-and-personal-assistant/

実装修正課題: `docs/todo/930_app_intents_result_consistency.md`
