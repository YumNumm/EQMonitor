# ネイティブ hook の Swift は CI の Xcode SDK でコンパイルできる API だけを使う

## 何が起きたか

`packages/assets_util/hook/build.dart` は `flutter assemble`（Xcode の
`Run Script` フェーズ）の中で `swiftc` を呼び、`EQMAssetsUtil.swift` を
コンパイルする。ここで iOS 26.4 SDK でしか宣言されていない
`AssetPackManager.assetPackIsAvailableLocally(withID:)` を参照していたため、
Xcode 26.3（iOS 26.2 SDK）を使う CI で次のように失敗した。

```
[assets_util] error: swiftc (iphoneos) failed:
  EQMAssetsUtil.swift:89:21: error: value of type 'AssetPackManager'
  has no member 'assetPackIsAvailableLocally'
Target dart_build failed: Error: Building native assets failed.
** ARCHIVE FAILED **
  PhaseScriptExecution Run\ Script ... (in target 'Runner')
```

ローカルは Xcode 26.6（iOS 26.4+ SDK）だったため成功し、CI だけが落ちていた。

## ルール

- `#available(iOS X, *)` は **実行時** のガードであり、コンパイル時に
  シンボルが SDK に存在することは保証しない。SDK に無い API を書くと
  ビルドが通らない。
- ネイティブ hook の Swift が参照してよい API は
  `.github/workflows/deploy-app.yaml` の `XCODE_VERSION`（現在 `26.6`）に
  同梱される SDK までとする。
- 新しい API を使いたい場合は、任意の最適化なら **使わない**、必須なら
  `XCODE_VERSION` を上げてローカルと揃える。

## 再発防止のための確認コマンド

CI と同じ SDK で hook の Swift 単体をコンパイルできるか確認する。

```bash
cd packages/assets_util
SDK=$(xcrun --sdk iphoneos --show-sdk-path)
mise exec -- swiftc -sdk "$SDK" -target arm64-apple-ios16.0 \
  -emit-library -o /tmp/AssetsUtilCheck.dylib -module-name assets_util \
  ios/assets_util/Sources/assets_util/EQMAssetsUtil.swift
```

## CI ログの読み方

`xcbeautify` は `Run Script` フェーズの stdout/stderr を落とすため、
`xcodebuild` の生ログを `tee` して artifact に上げる必要がある。
`deploy-app.yaml` の `Create XCArchive` は失敗時に
`xcodebuild-archive-log` artifact をアップロードするので、そこから
`PhaseScriptExecution Run\ Script` 以降を読む。

```bash
gh run download <run-id> -n xcodebuild-archive-log -D /tmp/ci_art
awk '/^PhaseScriptExecution Run\\ Script/{s=NR} {l[NR]=$0}
     END{for (i = s; i <= NR; i++) print l[i]}' \
  /tmp/ci_art/xcodebuild-archive.log | grep -v '^    export '
```
