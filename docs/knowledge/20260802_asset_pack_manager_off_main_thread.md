# AssetPackManager は main thread で呼ばない

## ルール

iOS Managed Background Assets の `AssetPackManager.url(for:)`（およびその前後の
manifest 読込・`stat`）は、呼び出し元スレッドではなく専用の background queue
で実行する。Dart 側の公開 API は completion ハンドラ経由の `Future` にする。

```swift
private static let workQueue = DispatchQueue(
  label: "net.yumnumm.assets-util.asset-pack",
  qos: .userInitiated,
  attributes: .concurrent
)

public func resolveAssetPackFile(
  relativePath: String,
  packIdentifier: String,
  completion: @escaping (NSString?) -> Void
) {
  Self.workQueue.async {
    completion(self.resolveAssetPackFilePath(...) as NSString?)
  }
}
```

`resolveLocalPath` のように `Bundle.main` だけを読む同期 API は例外でよい。

## 理由

Apple の `BAAssetPackManager` ヘッダは明示している:

> Don't use this method to block the main thread.

Flutter 3.29 以降、iOS では UI thread と platform (main) thread が統合され、
Dart isolate は main thread 上で動く。そのため同期 `@objc` メソッドを ffi で
直接呼ぶと、そのまま `url(for:)` が main thread で走り、次の警告が出る:

```text
Warning: AssetPackManager.url(for:) was called on the main thread, which could cause UI hangs.
```

`AssetsUtil.resolvePackFile` / `resolvePackRoot` / `diagnosePack` は起動時の
パラメータ・地図読み込みやデバッグ診断で呼ばれるため、UI ハングになりうる。

## 検証

実機またはシミュレータで Asset Pack を解決し、上記 Warning が出ないこと。
