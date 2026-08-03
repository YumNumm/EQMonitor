# EQMonitor Map Flutter Scene toolchain

## 固定 revision

2026-08-02 時点で、root workspace の Flutter/Dart command は repository 内の
`.flutter-scene-sdk` checkout だけを使う。

- Flutter source: `https://github.com/flutter/flutter.git`
- Framework revision: `4dacd3fc91d96262a33e5c598e17d816f0b35641`
- Flutter version: `3.47.0-1.0.pre-97`
- Engine source revision: `b1e405a9c311d858bef870c472bb24c015f4bcf9`
- Engine content hash: `73ac711b34da2a090d79ddb423918de40a7ffbf9`
- Dart source revision: `d402ff7c9c8442d64aa8148609480aa0e04a24fd`
- Dart SDK: `3.14.0-29.0.dev`
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

## Shared lint preflight

共有 lint は二層の互換契約を持つ。root/app がincludeする
`package:eqmonitor_lints/analysis_options.yaml` はincludeなし・rulesなしの既存code
向けbaselineを維持する。新規packageが明示採用する
`package:eqmonitor_lints/recommended.yaml`だけがstrict Flutter 3.41設定を使う。
root entry pointをstrict設定へ委譲すると3,081件、Dart 3.11 recommendedでも
1,807件のdiagnosticが既存app・生成物を含むworkspace全体で有効化されたため、
Task 1ではlint全面移行を行わず、この二層を統合しない。

`package:eqmonitor_lints/recommended.yaml` は package root ではなく
`packages/eqmonitor_lints/lib/recommended.yaml` へ解決される。共有 lint のentry
pointは必ず`lib/`配下へ置く。`flutter pub add -C`に渡すpathはcommandを
起動したrepository root基準で解決されるため、exampleへの追加は次を使う。

```bash
mise exec -- flutter pub add -C packages/assets_util/example \
  "dev:eqmonitor_lints@{path: packages/eqmonitor_lints}"
```

この command は既存 `analysis_options.yaml` へ platform directory の exclude を
自動追記する場合がある。依存追加後は差分を確認し、Task scope 外の自動変更を残さない。

## Workspace test preflight

root の `test:dart` script は内部で bare `melos exec` を呼ぶため、local dependency
として `dart run melos` だけが使える環境では `melos: not found` になる。また
`--depends-on=test` だけでは Flutter SDK に依存する `cache` package も選ばれ、
`dart test` が `dart:ui` を読み込めず失敗する。Dart-only suite の診断には明示的に
Flutter packageを除外する。

```bash
mise exec -- dart run melos exec \
  --no-flutter \
  --depends-on=test \
  --dir-exists=test \
  --concurrency=1 \
  -- "dart test"
```

Flutter suite は package ごとの asset root を保つため、repository root から
`flutter test app/test` を直接呼ばない。Melos で各 package directory を cwd にするか、
対象 package を working directory にして実行する。

```bash
mise exec -- dart run melos exec \
  --depends-on=flutter_test \
  --dir-exists=test \
  --concurrency=1 \
  -- "flutter test"

cd app
mise exec -- flutter test --no-pub test
```

repository root起点のapp testでは`assets/tjma2001.csv`の解決条件が変わり、実際の
package/CI実行にはないasset failureを作るため、failure比較に使用しない。

固定masterのroot full scanでは`eqmonitor`だけが既存custom lint 1,381件で失敗し、
Flutter suiteはappの既存18 testsが失敗した。同じsource treeをstable Flutterで
比較しても同じ件数・同じ原因だったため、master migrationの回帰ではない。root full
scanはtoolchain互換性のdiagnostic evidenceとして残し、既存CIの合否契約を変更しない。
詳細と解消作業は次へ分離する。

- `docs/todo/760_existing_eqmonitor_custom_lint_debt.md`
- `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`

## CI

Flutter を使う analyze、test、integration、iOS build、Android build job は
repository checkout の直後に上記 revision を `.flutter-scene-sdk` へ checkout
する。mise tool の Flutter は導入せず、各 job で次を gate にする。

```bash
mise bootstrap repos status --missing
mise exec -- flutter --version --machine
```

`eqmonitor_map` example のPR gateはpackage/exampleが存在するTask 2から有効にし、
package単体の`flutter analyze --fatal-infos`とAndroid/iOSのprofile/release buildを
blockingにする。署名、配布、deploy secretは扱わない。既存root/appのdiagnosticを
この新規package gateへ混ぜない。

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
