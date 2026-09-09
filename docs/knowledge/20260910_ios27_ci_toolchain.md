# iOS 27 App Intentを含むCIのXcode選択

- `SearchEarthquakesIntent`の`.system.searchInApp`はiOS 27 SDKが必要。
- `@available(iOS 27.0, *)`は実行OSの制約であり、Xcode 26.6で未知のマクロ引数をコンパイル可能にはしない。
- Actions run `34395488369`は、このスキーマが旧SDKに存在しないためarchiveに失敗した。
- iOSビルドには`runs-on: xcode-27`を使う。`macos-26`の標準イメージにはXcode 27が含まれない。
- `setup-xcode`の`latest`は、そのrunnerにインストール済みのbetaを含む最新版を選ぶ。Xcodeをダウンロードする指定ではない。
- 2026-09-10確認時、公式イメージの掲載版は27 beta 6（27A5252f）。RC導入済みとは扱わない。
- CIで選択後の`xcodebuild -version`とiOS SDKバージョンを出力し、SDKのmajorが27であることを確認する。
- RC・正式版の配備はrunnerの実ログで確認する。archive成功とTestFlightへの受理は別々に確認する。

## 対象Intentの型検査

```sh
export DEVELOPER_DIR=/Applications/Xcode-27.0.0-beta.4.app/Contents/Developer
xcrun swiftc -typecheck \
  -sdk "$(xcrun --sdk iphoneos --show-sdk-path)" \
  -target arm64-apple-ios18.0 \
  -module-cache-path /tmp/eqmonitor-ci-swift27 \
  app/ios/Runner/SearchEarthquakesIntent.swift \
  app/ios/Shared/EarthquakeSearchURL.swift
actionlint .github/workflows/deploy-app.yaml
```

## 公式資料

- https://github.com/actions/runner-images/issues/14404
- https://github.com/actions/runner-images/blob/main/images/macos/xcode-27-arm64-Readme.md
- https://github.com/maxim-lobanov/setup-xcode#available-parameters
