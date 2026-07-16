# iOS Widget を worktree で検証する際の注意点

## Flutter テスト前に SourcePackages の親ディレクトリを作る

新しい worktree では、Flutter の依存解決時に iOS/macOS プラグインの Swift Package を配置する親ディレクトリが存在せず、コピー処理が失敗する場合がある。

```sh
cd app
mkdir -p build/ios/SourcePackages build/macos/SourcePackages
mise exec -- flutter test \
  test/core/provider/widget_current_location_loader_test.dart \
  test/core/provider/app_group_settings_writer_test.dart
```

## Widget の共通 Swift ロジックを軽量に検証する

`WidgetModelsTests` の `xcodebuild test` は Runner の Swift Package 全体を解決するため、Firebase や広告 SDK を含む大きなキャッシュを作る。空き容量が限られる環境では、まず Widget とテストターゲットが共有する Foundation ベースの実装を `swiftc` で直接コンパイル・実行する。

```sh
cd app/ios
xcrun swiftc \
  Shared/WidgetLayoutPolicy.swift \
  Shared/EarthquakeDetailURL.swift \
  /private/tmp/eqmonitor_widget_behavior_check.swift \
  -o /private/tmp/eqmonitor_widget_behavior_check
/private/tmp/eqmonitor_widget_behavior_check
```

これは共通ロジックの高速確認であり、SwiftUI を含むターゲット統合の確認は CI の `WidgetModelsTests` で行う。
