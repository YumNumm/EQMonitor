# MapLibre Native 更新と PMTiles abort

## ピンの場所

EQMonitor は `josxha/flutter-maplibre` ではなく **`YumNumm/flutter-maplibre`** を git 依存する。
`app/pubspec.yaml` の `dependency_overrides` で `ref` を commit SHA に固定する。

upstream (`josxha/flutter-maplibre`) へ PR / Issue を作らない。

## 2026-08-23 時点の Native 版

Fork PR: https://github.com/YumNumm/flutter-maplibre/pull/4

| プラットフォーム | パッケージ | 版 |
|---|---|---|
| Android | `org.maplibre.gl:android-sdk-opengl` | 13.5.1 |
| iOS | `MapLibre` (SPM / CocoaPods) | 6.28.0 |

iOS SPM の実体は `maplibre/maplibre-gl-native-distribution` の tag `6.28.0`
（commit `5ee345ca5d65238a6fce29bba87816204be7df20`）。
`app/ios/**/Package.resolved` も合わせて更新する。

## PMTiles `incorrect header check` SIGABRT

`PMTilesFileSource` スレッドで gzip 解凍が失敗すると、古い Native は
`std::runtime_error` を捕捉せずプロセスが abort する。

metadata 解凍失敗を error response にする修正は
[maplibre-native#4399](https://github.com/maplibre/maplibre-native/pull/4399) で、

- Android **13.4.0** 以降
- iOS **6.28.0** 以降

に入っている。13.3.x / 6.27.x では入らない。

## 更新手順

```bash
# fork（YumNumm のみ）
# packages/maplibre_android/android/build.gradle.kts
# packages/maplibre_ios/ios/maplibre_ios.podspec
# packages/maplibre_ios/ios/maplibre_ios/Package.swift

# アプリ側
# app/pubspec.yaml の maplibre* git ref を fork の main SHA に合わせる
cd app && mise exec -- dart pub get
```
