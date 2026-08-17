# assets_util

アプリに同梱されたローカル Asset Pack（FlutterGen の `Assets` とは別物）の絶対パスを解決する。

- iOS / macOS: Native Assets + Swift + ffigen（`EQMAssetsUtil` を共有。`live_activity_util` と同型）
- Android: Flutter plugin + Kotlin + jnigen

## API

```dart
// Platform-managed local asset の絶対パスを解決する（例: バンドル同梱ファイル）。
final path = AssetsUtil.resolveLocalPath(fileName: 'example.bin');

// Asset Pack (manifest.json / map/all.pmtiles / parameters/*.json) のルート。
// - iOS / macOS: Bundle.main 内の `platform/` フォルダ
// - Android: APK assets/platform を app-private storage へ一度展開
// 存在しない場合は AssetPackNotReadyException を投げる。
final packRoot = await AssetsUtil.resolvePackRoot();
```

R2 更新の署名検証・ダウンロード・展開・切り替えは EQMonitor アプリ層が担う。
この package は更新済み Pack を管理せず、異常時に必ず残る同梱 Pack だけを解決する。

## Codegen

- iOS/macOS bindings: `flutter build ios` / `flutter build macos` 時に
  `hook/build.dart` が再生成（iOS は device+simulator の xcframework、
  macOS は arm64+x86_64 universal の xcframework を
  `app/{ios,macos}/Runner/Frameworks/AssetsUtil.xcframework` へ出力）
- Android bindings: example をビルド後に `dart run tool/jnigen.dart`
  （Kotlin はソースではなく classes jar から要約する）
