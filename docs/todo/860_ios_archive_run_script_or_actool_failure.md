# iOS archive: Flutter Run Script / actool 失敗の追跡

## 解決済み (2026-07-29)

### CI (Xcode 26.3) の `Run Script` 失敗 — 原因確定・修正済み

`flutter assemble` が `packages/assets_util` の build hook を実行し、
`swiftc` が iOS 26.2 SDK に存在しない
`AssetPackManager.assetPackIsAvailableLocally(withID:)` で失敗していた。

```
[assets_util] error: swiftc (iphoneos) failed:
  EQMAssetsUtil.swift:89:21: error: value of type 'AssetPackManager'
  has no member 'assetPackIsAvailableLocally'
Target dart_build failed: Error: Building native assets failed.
```

`#available(iOS 26.4, *)` は実行時ガードでしかなく、コンパイル時には
SDK にシンボルが必要。当該呼び出しは任意の早期リターンであり、実際の
readiness 判定は `verifyAllManifestAssetsExist` が担っているため削除した。
詳細は `docs/knowledge/20260729_ios_sdk_version_pinning_in_native_hook.md`。

### 診断手段

`xcbeautify` は `Run Script` の出力を落とすため、`deploy-app.yaml` の
`Create XCArchive` は失敗時に生ログを `xcodebuild-archive-log` artifact
としてアップロードするようにした。

## 未解決

### actool のクラッシュ（クリーンビルド時）

DerivedData を消したローカル cold build で再現。

```
Could not open “AppIcon-dev.icon”.
error: Exception while running actool:
  *** -[__NSPlaceholderArray initWithObjects:count:]:
  attempt to insert nil object from objects[0]
  ... IBICAbstractPlatformAdapter
      selectCatalogIconComposerItemsFromCollection:...
```

- 失敗するのは `CompileAssetCatalogVariant thinned`（Runner ターゲット）
- 同じ引数の `actool` を単体で実行すると成功するため、Xcode ビルド内の
  条件（並列実行 / ibtoold の状態）に依存している疑い
- 入力は `AppIcon-prod.icon` `Runner/Assets.xcassets` `AppIcon-dev.icon`
  の 3 つで、`ASSETCATALOG_COMPILER_INCLUDE_ALL_APPICON_ASSETS = YES`
  のため両方の Icon Composer バンドルがコンパイル対象になっている
- アプリは代替アイコン（`setAlternateIconName`）を使っていないので、
  同設定を `NO` にして片方だけコンパイルさせる案が第一候補

warm な DerivedData では Asset Catalog がスキップされるため成功してしまう。
検証は必ず `rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*` してから
行うこと。
