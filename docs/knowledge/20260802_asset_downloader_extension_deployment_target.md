# AssetDownloader 拡張の Deployment Target は iOS 26.0 にする

## 症状

デバイス向けビルドが以下のエラーで失敗する。

```
Swift Compiler Error (Xcode): 'AssetPack' is only available in iOS 26 or newer
app/ios/AssetDownloader/BackgroundDownloadHandler.swift:13:37

Swift Compiler Error (Xcode): Protocol 'AppExtension' requires 'configuration' to be available in application extensions for iOS 17.6 and newer
app/ios/AssetDownloader/BackgroundDownloadHandler.swift:12:7
```

## 原因

`StoreDownloaderExtension` / `AssetPack`（Managed Background Assets）は **iOS 26 以降専用 API**。
`AssetDownloader` ターゲットの `IPHONEOS_DEPLOYMENT_TARGET` が Runner と同じ `17.6` のままだと、
`@main` の `AppExtension` 準拠が 17.6 で成立せずコンパイルエラーになる。

## 対処

`app/ios/Runner.xcodeproj/project.pbxproj` の `AssetDownloader` ターゲット
（Debug / Release / Profile の 3 構成すべて）で以下に変更する。

```
IPHONEOS_DEPLOYMENT_TARGET = 26.0;
```

ホストアプリ（Runner）は 17.6 のままでよい。App Extension は自身の最低 OS を
ホストより高く設定でき、iOS 26 未満の端末では単に拡張がロードされないだけ。
`@available(iOS 26.0, *)` を付ける回避策は `@main` の `AppExtension` 準拠と両立しないため使わない。

## 検証方法

プロジェクト全体をビルドせずに、単一ファイルの型チェックだけで再現・確認できる。

```bash
cd app/ios
xcrun swiftc -typecheck -parse-as-library -application-extension \
  -target arm64-apple-ios26.0-simulator \
  -sdk "$(xcrun --sdk iphonesimulator --show-sdk-path)" \
  AssetDownloader/BackgroundDownloadHandler.swift
```

`-target arm64-apple-ios17.6-simulator` に変えると上記 2 つのエラーが再現する。

なお `xcodebuild -project Runner.xcodeproj -target AssetDownloader` は
SPM の binary target 解決に失敗するため、単体ターゲットの検証には上記 `swiftc` を使う。
