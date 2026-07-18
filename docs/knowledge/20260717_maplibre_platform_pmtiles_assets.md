# MapLibre のローカル PMTiles は file:// 絶対パスで解決する

## ルール

- `pmtiles://asset://` は Android 公式でも未サポート。使わない。
- iOS/Android のベースマップは `packages/assets_util` で絶対パスを取り、`pmtiles://file://...` にする。
- Flutter Asset へのコピー経路や MethodChannel は使わない（FFI / JNI）。
- HTTPS へのサイレントフォールバックはしない。
- 将来の Background Assets / PAD は `assets_util` 内で差し替える。

## 構成確認

```bash
rg -n "earthquake_tsunami_all.pmtiles|pmtiles://|assets_util" \
  app/lib/feature/map \
  packages/assets_util \
  app/android/app/build.gradle.kts \
  app/ios/Runner.xcodeproj/project.pbxproj
```
