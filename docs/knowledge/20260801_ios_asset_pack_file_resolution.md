# iOS Asset Pack はファイル単位で解決する

## ルール

iOS Managed Background Assets のファイルを読む際は、各相対パスごとに
`AssetPackManager.url(for:)` を呼ぶ。`manifest.json` の URL の親を pack root
とみなし、そこへ `map/...` や `parameters/...` を連結してはならない。

```swift
let manifestURL = try manager.url(for: FilePath("manifest.json"))
let assetURL = try manager.url(for: FilePath(relativePath))
```

Dart からは次を使う。

```dart
final manifest = await AssetsUtil.resolvePackFile(
  relativePath: 'manifest.json',
);
final asset = await AssetsUtil.resolvePackFile(relativePath: item.path);
```

## 理由

`url(for:)` はダウンロード済み pack 群を統合した論理名前空間の API で、
pack ごとの物理 root を提供しない。また、整形式 URL が返っても対象の存在は
保証されないため、解決後に regular file であることも確認する。

2026-08-01 の TestFlight 診断では `manifest.json` は読めた一方、その親から
導出した 6 ファイルがすべて `exists: false` になった。診断 schema v2 は各
ファイルの `resolved_url` と `native_error` を記録し、URL 解決失敗・ファイル
欠落・サイズ不一致を区別する。
