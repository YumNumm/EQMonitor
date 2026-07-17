# MapLibre NativeでPMTilesをPlatform Assetから参照する

## ルール

- iOS/AndroidのMapLibre Nativeは `pmtiles://asset://<filename>` でPMTilesを直接参照できる。
- Flutter AssetからApplication Supportへコピーする処理は不要。
- 単一ファイルをAndroid assets source setとiOS Bundle Resourcesへ登録し、重複管理しない。
- Android/iOSでAsset読込に失敗してもHTTPSへフォールバックしない。

## 構成確認

```bash
rg -n "earthquake_tsunami_all.pmtiles|assets/platform" \
  app/android/app/build.gradle.kts \
  app/ios/Runner.xcodeproj/project.pbxproj \
  app/lib/feature/map/data/provider/map_style_util.dart
```
