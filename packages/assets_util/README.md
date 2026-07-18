# assets_util

Platform-managed local assets（FlutterGen の `Assets` とは別物）の絶対パスを解決する。

- iOS: Native Assets + Swift + ffigen（`live_activity_util` と同型）
- Android: Flutter plugin + Kotlin + jnigen

当面は `resolveLocalPath` のみ。将来の Background Assets / Play Asset Delivery もこのパッケージに載せる。

## API

```dart
final path = AssetsUtil.resolveLocalPath(fileName: 'earthquake_tsunami_all.pmtiles');
```

## Codegen

- iOS bindings: `flutter build ios` 時に `hook/build.dart` が再生成
- Android bindings: example をビルド後に `dart run tool/jnigen.dart`
  （Kotlin はソースではなく classes jar から要約する）
