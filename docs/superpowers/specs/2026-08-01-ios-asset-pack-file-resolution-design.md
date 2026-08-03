# iOS Asset Pack 個別ファイル解決の設計

## 背景

TestFlight端末で `eqmonitor-assets` v0.0.2は
`assetPackIsAvailableLocally(withID:) == true`と判定され、
`manifest.json`も読み取れている。しかし、manifest URLの親を
pack rootとみなしてrelative pathを連結する現行実装では、
manifestに記載された6ファイルがすべて未存在と判定された。

Background Assetsが保証するのは、共有名前空間内のrelative pathを
`AssetPackManager.url(for:)` または `contents(at:)` / `descriptor(for:)`で
解決できることである。解決したmanifest URLの物理的な親が、
他のassetに共通するfilesystem rootであることは保証されない。

## 目的

- iOSではmanifestと各assetをrelative pathごとにBackground Assets APIで解決する。
- デバッグ診断と通常の地図・parameter読込で同じ解決方式を使う。
- Android Play Asset DeliveryとmacOS bundle assetsの現行動作を維持する。
- bundled dataや固定値へのフォールバックは追加しない。

## 採用アプローチ

`assets_util` にrelative pathから個別ファイルの絶対pathを解決する
APIを追加する。

- iOS: Swiftが `AssetPackManager.url(for: FilePath(relativePath))`を呼び、
  実在する通常ファイルのみpathを返す。
- Android/macOS: 従来の `resolvePackRoot()` とrelative pathを結合し、
  通常ファイルであることを確認する。

`resolvePackRoot()` は互換性のため残すが、iOSのアプリ内読込と
診断では使用しない。

## データフロー

1. `AssetPackRepository.readManifest()` が `manifest.json`を個別解決する。
2. manifestを解析し、必要な `AssetPackAssetId` のrelative pathを得る。
3. `resolveAsset()` がそのrelative pathを個別解決する。
4. 既存のsize・SHA-256検証を行ってから `File`を呼出元へ返す。

Repositoryは注入可能な `ResolveAssetPackFile` を受け取る。これにより、
「manifestとassetの物理的な親が異なる」ケースをfixtureで再現する。

## 診断

iOS診断はmanifestの各pathに対して `url(for:)` を呼び、次を記録する。

- relative path
- 解決した個別URL
- 存在有無
- 期待sizeと実size
- 解決または読込のnative error

JSON schemaはversion 2とし、file診断に `resolved_url` と
`native_error`を追加する。Dartはschema 1も後方互換でdecodeし、
schema 2の追加情報をデバッグ画面に表示する。

## エラー処理

- URL解決失敗、未存在、size不一致を区別する。
- manifestに記載されたすべてのassetを検査し、最初の失敗で中断しない。
- Repositoryは個別解決に失敗したpathを
  `AssetPackNotReadyException`に含める。
- 個別URLをプロセス寿命を超えて保存しない。

## テスト

- Swift: manifest URLの親にassetがなくても、個別resolverが返した
  URLでreadyになること。解決失敗とsize不一致も検証する。
- Dart package: schema 1の後方互換、schema 2の個別URL・errorのdecode。
- App repository: manifestとassetが別directoryにあるfixtureで、
  read・size・SHA-256検証が成功すること。
- Widget: 個別URLとfileごとのnative errorが折返し・コピー可能であること。
- Android/macOS: rootベースの既存テスを維持する。

## 完了条件

- TestFlight端末で6assetが個別URLと正しいsizeを表示する。
- 地図とparameterが物理root推定に依存せず読み込まれる。
- 個別解決に失敗した場合は証拠を表示し、障害を隠さない。
- AndroidとmacOSのasset読込に回帰がない。
