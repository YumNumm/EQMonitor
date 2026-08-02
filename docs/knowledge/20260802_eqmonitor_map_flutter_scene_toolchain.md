# EQMonitor Map Flutter Scene toolchain

## 固定 revision

2026-08-02 時点で、root workspace の Flutter/Dart command は repository 内の
`.flutter-scene-sdk` checkout だけを使う。

- Flutter source: `https://github.com/flutter/flutter.git`
- Framework revision: `de01d5daa62dcb2fd0378d55206c91e4cf008923`
- Flutter version: `3.47.0-1.0.pre-328`
- Engine source revision: `de01d5daa62dcb2fd0378d55206c91e4cf008923`
- Engine content hash: `4a2652131daa3558c477de29f83596de6c6f9663`
- Dart SDK: `3.14.0-82.0.dev`
- Flutter root: `<repository>/.flutter-scene-sdk`

取得と検証は次で行う。

```bash
mise bootstrap repos apply --yes
mise bootstrap repos status --missing
mise exec -- flutter --version --machine
mise exec -- flutter precache --android
mise exec -- dart --version
```

`tool/eqmonitor_map/bin` の shim は SDK checkout の欠落、git でない directory、
revision 不一致、tracked file の変更、実行 file の欠落を fail closed にする。
`flutter upgrade`、`flutter downgrade`、`flutter channel` は拒否される。caller の
環境変数や system `PATH` で SDK path／revision を上書きしない。

mise 2026.7.7 は project config の relative `[bootstrap.repos]` target を
`path must be absolute or start with ~/` として無視した。relative target を
worktree ごとに安全に解決できた最低実測版は 2026.8.0 なので、root
`min_version` も 2026.8.0 とする。

git checkout には `bin/cache` の engine artifacts が含まれない。`dart pub get` を
直接実行すると `sky_engine from sdk doesn't exist` で失敗するため、fresh checkout
では先に対象 platform の `flutter precache` を実行する。Linux analyze/test は
`--linux`、Android build は `--android`、iOS build は `--ios` を使う。

## CI

Flutter を使う analyze、test、integration、iOS build、Android build job は
repository checkout の直後に上記 revision を `.flutter-scene-sdk` へ checkout
する。mise tool の Flutter は導入せず、各 job で次を gate にする。

```bash
mise bootstrap repos status --missing
mise exec -- flutter --version --machine
```

`eqmonitor_map` example の PR compile gate は Android/iOS の profile と release
を build するだけで、署名、配布、deploy secret は扱わない。

## Flutter Scene public API 監査

監査対象は Flutter Scene
[`695c954f237fabef65d49fa7199002851d2dcd88`](https://github.com/bdero/flutter_scene/commit/695c954f237fabef65d49fa7199002851d2dcd88)
である。`packages/flutter_scene/lib` を `rg` で監査した結果、次の3 capability
はすべて `unavailablePublicApi` と確定した。この結果を manual action や
時間ベースの仮定で pass に変換してはならない。

### GPU completion fence: `unavailablePublicApi`

- `lib/src/scene.dart` の public `Scene.render` と `Scene.renderViews` は `void` を
  返し、submission id、completion callback、fence を返さない。
- `lib/src/render/frame_transients.dart` の internal `GpuSubmissionTracker` は
  `latestSubmission` と `completedThrough` を持ち、`CommandBuffer.submit` の
  callback を受けるが、`scene.dart` の public barrel は `TransientWriter` だけを
  export し、tracker／submission state を export しない。
- `gpu.dart` の curated public surface は `Shader`、`ShaderLibrary`、`Texture` と
  sampler／vertex value types のみで、`CommandBuffer`、`CompletionCallback`、
  `GpuContext` を export しない。

### GPU context loss callback/generation: `unavailablePublicApi`

- `lib/src/gpu/web/surface.dart` には web-only の `isLost`、`onContextLost`、
  `onContextRestored` がある。
- `lib/src/gpu/impeller/surface.dart` の native `Surface` は同じ member を
  placeholder として持つだけで、constructor と操作は
  `UnimplementedError` になる。
- この GPU `Surface` は internal shim の型であり、curated `gpu.dart` から export
  されない。iOS/Android で監視できる public callback や context generation は
  ない。

### GPU resource dispose/reset: `unavailablePublicApi`

- public barrel が export する `Scene`、`Surface`、`MeshGeometry`、`Texture2D`、
  `RenderTexture`、`Material` に GPU resource retirement の `dispose`／`reset` API
  はない。
- public `ResourceGroup.dispose` は loading progress の `ValueNotifier` を解放する
  だけで、GPU resource を retire しない。
- web internal GPU `Surface.dispose` は空実装で、native internal GPU `Surface` も
  空実装である。いずれも iOS/Android resource retirement の証拠にならない。

したがって後続 harness は残り capability と blocked decision を再現可能にする
ために継続するが、この3項目が必要な foundation gate は pass にしない。
