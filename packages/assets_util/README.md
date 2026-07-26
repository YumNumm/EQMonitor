# assets_util

Platform-managed local assets（FlutterGen の `Assets` とは別物）の絶対パスを解決する。

- iOS / macOS: Native Assets + Swift + ffigen（`EQMAssetsUtil` を共有。`live_activity_util` と同型）
- Android: Flutter plugin + Kotlin + jnigen

## API

```dart
final path = AssetsUtil.resolveLocalPath(fileName: 'earthquake_tsunami_all.pmtiles');

// Asset Pack (manifest.json / map/all.pmtiles / parameters/*.json) のルート。
// - iOS: Managed Background Assets（`net.yumnumm.eqmonitor.assets`）
// - Android: Play Asset Delivery install-time pack（`eqmonitor_assets`）
// - macOS: Bundle.main 内の `platform/` フォルダ（常に利用可能）
// 未取得・存在しない場合は AssetPackNotReadyException を投げる（フォールバックなし）。
final packRoot = await AssetsUtil.resolvePackRoot();
```

iOS の Managed Background Assets 側の実 API 調査結果・既知の制約
（`AssetPackManager` に「パックのルートディレクトリを取得する」API が無いこと、
Background Download App Extension が別途必要なこと等）は
`docs/knowledge/20260727_background_assets_api_surface.md` と
`docs/ios-background-assets.md` を参照。

## Codegen

- iOS/macOS bindings: `flutter build ios` / `flutter build macos` 時に
  `hook/build.dart` が再生成（iOS は device+simulator の xcframework、
  macOS は arm64+x86_64 universal の xcframework を
  `app/{ios,macos}/Runner/Frameworks/AssetsUtil.xcframework` へ出力）
- Android bindings: example をビルド後に `dart run tool/jnigen.dart`
  （Kotlin はソースではなく classes jar から要約する）
