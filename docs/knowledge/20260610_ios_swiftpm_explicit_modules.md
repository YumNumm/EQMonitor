---
alwaysApply: true
---

# iOS release build と SwiftPM explicit modules

Xcode 26/27 系では SwiftPM の explicit modules まわりで、`swift-collections` の hidden target `InternalCollectionsUtilities` を解決できず iOS build が失敗することがある。

確認されたエラー例:

```text
Swift Compiler Error (Xcode): Unable to resolve module dependency: 'InternalCollectionsUtilities'
.../SourcePackages/checkouts/swift-collections/Sources/DequeModule/Deque+Collection.swift
```

`swift-openapi-generator` を build-tool plugin として iOS build 時に実行すると、同じ問題を踏みやすい。`app/ios/Packages/EQMonitorAPI` では OpenAPI 生成物を事前生成して commit し、アプリの iOS build では generator plugin を走らせない。

生成物を更新する場合:

```bash
cd app/ios/Packages/EQMonitorAPI
mise exec -- swift package plugin --allow-writing-to-package-directory generate-code-from-openapi
```

iOS 側では `app/ios/Flutter/*.xcconfig` で explicit modules を無効化する。`WidgetExtension` のように `Flutter/*.xcconfig` を base configuration にしていない target が SwiftPM dependency を持つ場合は、その target の build settings にも `SWIFT_ENABLE_EXPLICIT_MODULES = NO` を明示する。

```xcconfig
SWIFT_ENABLE_EXPLICIT_MODULES = NO
```

release build の確認コマンド:

```bash
cd app
mise exec -- flutter build ios --release --dart-define-from-file=../environment/.env.prod
```

`xcodebuild archive` で SwiftPM checkout を `app/build/ios/SourcePackages` に固定する場合は、必ず `-clonedSourcePackagesDirPath build/ios/SourcePackages` を渡す。Xcode project の build phase で checkout 内のファイルに workaround patch を当てる場合、CI の checkout 先と build phase の参照先がずれると patch が成功扱いでスキップされる。
