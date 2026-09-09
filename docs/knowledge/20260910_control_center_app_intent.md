# Control Center の App Intent

## 実装ルール

- Control Center から起動する Intent は Snippet を表示できない。`SnippetIntent` の単体実行成功を Control Center の動作成功と解釈しない。
- 画面を開く Control は `OpenIntent` を使い、Intent の同じソースを Runner と WidgetExtension の両ターゲットに含める。
- 既存コントロールの配置を維持するため `kind` を変更しない。
- `OpenURLIntent` にカスタム URL スキームを渡さない。今回の履歴導線は Runner で登録した `AppDependencyManager` の依存を通じ、`UIApplication.open` で既存ルートを開く。
- UIApplication を参照する処理はアプリ側で登録し、共有 Intent に UIKit への依存を持たせない。
- `@Dependency` はシステムの Intent 実行時に解決される。単体テストで直接 `perform()` を呼ぶ場合、アクセス前に `intent.navigation = ...` と代入する。初期化されていない依存へのアクセスはクラッシュする。

## 検証

```sh
xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_UUID>' \
  -derivedDataPath /private/tmp/eq-control-derived CODE_SIGNING_ALLOWED=NO test
xcodebuild -project app/ios/Runner.xcodeproj -scheme Runner \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_UUID>' \
  -derivedDataPath /private/tmp/eq-control-derived CODE_SIGNING_ALLOWED=NO build
```

- Runner のビルドは `-scheme Runner` を使用する。`-target Runner` のみでは Flutter の準備処理が実行されず、プラグインで Flutter module の解決に失敗した。
- 2026-09-10: iOS 27 Simulator で Swift テスト 150 件・16 suite が成功。履歴 URL、foreground 実行設定、画面遷移失敗の伝播を追加検証した。
- Control Center の実タップ、終了状態からの起動、署名済み実機での画面表示は別途確認する。今回の UI 操作接続は起動に失敗し、テストを実タップ確認の代用とはしない。

- この worktree での Runner 全体ビルドは、既存 Flutter 地図パッケージと `flutter_scene` の API 不整合（`FmatType`、`parameterTypeOf`、`interfaceManifestFileName`）で失敗した。ネイティブ部分だけを既存 Flutter 成果物で検証しても、全体ビルド成功とは報告しない。

- 検証時のみ Flutter の build script を省き、既存生成ファイル・framework・assets を参照すると Runner の AppDelegate / 共有 OpenIntent と Widget の Swift コンパイルは通過した。アプリのパッケージングまで成功したわけではない。検証用の build script 変更はコミットしない。

## Apple 公式資料

- https://developer.apple.com/documentation/appintents/displaying-static-and-interactive-snippets
- https://developer.apple.com/documentation/widgetkit/creating-controls-to-perform-actions-across-the-system
