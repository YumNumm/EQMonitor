# Task 7 Report: Observation point GPU instance batch

## 実装

- `EarthquakeObservationPoint`全点を、28-byte strideの単一instance streamへ
  little-endianでpackするpure builderを追加した。layoutは
  `centerMercator float32x2 @0`、`color float32x4 @8`、
  `radiusLogicalPixels float32 @24`で固定した。
- `ObservationFrame`をstd140 vec4 2本、32 byteとしてpackした。camera normalized
  X/Yと`512 * 2^zoom`をoffset 0/4/8、viewport logical width/heightとstroke logical
  pixelsをoffset 16/20/24へ格納し、DPRは使わない。
- 同一source/snapshot revisionかつ同一station snapshot identityのcamera更新では既存instance
  bytesとgenerationを再利用し、32-byte frame uniformだけを作り直す。同じrevisionでもstation
  snapshotが置換された場合は再packする。0 stationまたは`stationMinZoom`未満ではbatchを作らない。
- raw vertex/fragment shaderとmanifestを追加した。manifest symbolは
  `EarthquakeObservationVertex` / `EarthquakeObservationFragment`。vertex shaderは
  date-line差をnearest worldへwrapしlogical pixelからNDCへ変換する。fragment shaderは
  円外discard、1 logical pixel白stroke、`smoothstep` AA、premultiplied alphaを出力する。
- build hookへ`buildTargetShaderBundleJson`をData Asset必須、GLES 300で追加した。
  DataAssets無効の通常test時はforkの既存hookと同じfeature gateを通し、旧fallbackを
  壊さない。
- `ShaderMaterial` bindingは上記2 symbolを必須解決し、custom vertex/fragment、
  culling none、`isOpaqueOverride: false`で作る。instance ABI、vertex layout、
  `ObservationFrame` 32-byte sizeとmember offset 0/16をScene/GPU mutation前に
  preflightする。
- `FlutterSceneObservationGeometryOwner`をadapterのmaterial/node構築とは別責務で
  実装した。context generation + `ObservationPointInstanceGeneration`ごとに
  `StaticInstanceGeometry`を1個だけ作り、Scene nodeも1個、priority 300にする。
- snapshot置換、context generation変更、background/disposeからのretire-all要求では
  `maxFramesInFlight`経過後に`retire()`する。retire予約済み、別generation、外部から
  retire済みのgeometryは再利用せずfail closedする。
- custom shaderのculling noneをinternal importなしで指定するため、YumNumm forkの
  public `gpu.dart`へ`CullMode`を公開し、barrel export testを追加した。

## 変更ファイル

- `packages/eqmonitor_map/assets/earthquake_observation.vert`
- `packages/eqmonitor_map/assets/earthquake_observation.frag`
- `packages/eqmonitor_map/shaders/earthquake_overlay.shaderbundle.json`
- `packages/eqmonitor_map/hook/build.dart`
- `packages/eqmonitor_map/pubspec.yaml`
- `packages/eqmonitor_map/lib/src/renderer/observation_point_batch.dart`
- `packages/eqmonitor_map/lib/src/renderer/observation_point_batch_builder.dart`
- `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- `packages/eqmonitor_map/test/renderer/observation_point_batch_builder_test.dart`
- `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`
- `docs/knowledge/20260823_flutter_raw_shader_data_assets_hook.md`
- `third_party/flutter_scene` submodule pointer
- submodule: `packages/flutter_scene/lib/gpu.dart`
- submodule: `packages/flutter_scene/test/static_instance_geometry_export_test.dart`

## TDD

### RED 1: observation contract不在

```text
cd packages/eqmonitor_map
mise exec -- flutter test \
  test/renderer/observation_point_batch_builder_test.dart \
  test/flutter_scene/flutter_scene_map_adapter_test.dart
```

exit 1。`observation_point_batch.dart` / builderと、adapterのmaterial/resource owner APIが
未定義のcompile failureを確認した。instance offsets、Tokyo Mercator、uniform offsets、
date-line、logical pixel、0 station、1 geometry/1 node、retire lifecycleの期待を先に置いた。

### RED 2: context generation再出現時の旧geometry reuse

```text
mise exec -- flutter test --no-pub \
  test/flutter_scene/flutter_scene_map_adapter_test.dart \
  --plain-name 'context generation change forbids reuse if an old id reappears'
```

exit 1。`Expected: not same instance`に対して旧contextのgeometryが再利用された。世代変更時に
旧世代entryをretire予約し、同じgeneration番号が再出現しても新geometryを作るようにした。

### RED 3: public CullMode contract不在

```text
cd third_party/flutter_scene/packages/flutter_scene
mise exec -- flutter test test/static_instance_geometry_export_test.dart
```

exit 1。`Undefined name 'CullMode'`。`gpu.dart`のpublic exportへ追加後、同testが2件GREEN。

### 実装中のbuild hook診断

初回GREEN実行ではDataAssets無効環境でもrequired assetを要求してhookが失敗した。
fork自身のhookと同じ`config.config.buildDataAssets` gateへ揃えた。手計算fixtureのTokyo Yは
独立計算で再確認し、実装値へ寄せず正しいMercator期待値へ修正した。

### 最終GREEN / 回帰

```text
cd packages/eqmonitor_map
mise exec -- flutter test --no-pub \
  test/renderer/observation_point_batch_builder_test.dart \
  test/flutter_scene/flutter_scene_map_adapter_test.dart
```

結果: `All tests passed!`（25 tests）。

```text
mise exec -- flutter test --no-pub
```

結果: `All tests passed!`（626 tests）。

```text
mise exec -- dart analyze . --fatal-infos
```

結果: `No issues found!`。

```text
FLUTTER_DART_DATA_ASSETS=true mise exec -- flutter test --no-pub \
  test/renderer/observation_point_batch_builder_test.dart \
  test/flutter_scene/flutter_scene_map_adapter_test.dart
```

結果: `All tests passed!`（25 tests）。DataAssets required pathでmanifest、両shader、
GLES 300 compileを通した。

```text
cd third_party/flutter_scene/packages/flutter_scene
mise exec -- flutter test --no-pub \
  test/static_instance_geometry_export_test.dart
mise exec -- dart analyze . --fatal-infos
```

結果: 2 tests pass、`No issues found!`。`git diff --check`も成功した。

## 自己レビュー

- quadは4頂点、indexは`[0,1,2,0,2,3]`の6個、instance layoutは専用buffer 1本で、
  後付けcustom attributeは使わない。
- material symbol、batch ABI、GPU vertex layout、uniform reflectionの全preflightを、ledger
  begin、material setter、geometry owner、Scene node変更より前に完了する。
- 0 stationではbatch自体がnullなのでgeometry/nodeとも作られない。
- 同一station snapshot identityのadapter submitではgeometry identityを維持し、uniformだけ
  差し替わるtestが実際の`ShaderMaterial.getUniformBlock`で通る。
- snapshot置換、context変更、retire-all、外部retireを別々にtestし、予約済みgeometryと
  retired geometryを再利用しない。context generation番号が戻る場合もfail closedする。
- culling noneはforkのpublic APIだけを使い、upstreamへ変更・PRは作っていない。
- 未関連の`app/ios/Runner/Frameworks/LiveActivityUtil.xcframework/Info.plist`は
  stage/commitしていない。

## コミット / push

- flutter_scene: `6b782687 feat: custom shader向けCullModeを公開`
- EQMonitor: `a3e772f5a feat: 観測点を単一GPU instance batchで描画`
- EQMonitor: `0a0c3691c docs: raw shaderのDataAssets検証手順を記録`
- 両方ともYumNumm originの既存作業branchへpush済み。

## 懸念 / Task 8へのhandoff

- shader Data Assetのproduction load、`FlutterSceneShaderObservationMaterialBinding`の生成、
  frameごとのprevious batch保持、`BaseMapView`のoverlay submission接続はTask 8の責務。
- `retireAllGpuResources()`は対象nodeをSceneから外してから、その時点までの全renderer GPU
  submissionをfenceする。resource ownerがcompletionまでgeometryを保持するため、永久dispose後に
  以後のframe submitがなくても安全にretireする。Task 8はwidget lifecycleからこのAPIを呼ぶ。

## Review fix round 1

### 実装

- 上記「永久dispose後に明示fenceがない」という懸念を解消した。forkの全renderer passが
  共有する`rendererSubmissions`へ、呼出時点のsubmission IDまでを待つcompletion fenceを
  追加し、`scene.dart`からは`waitForPendingGpuSubmissions()` 1関数だけを公開した。
- adapterは対象nodeをSceneから先にremoveし、その後にfenceをcaptureする。resource ownerが
  scheduled geometryをadapter本体とは独立して保持し、成功・GPU error/context lossのどちらでも
  completion後に一度だけ`retire()`する。後続`submitFrame`は不要で、capture後の新規submissionは
  待たない。
- Flutter GPU engine sourceではqueue/command errorもcompletion callbackを`false`で呼ぶこと、
  native非GLESのencode失敗だけは同期throwし得ることを確認した。後者ではtrackerのpendingを
  解放してrethrowし、phantom submissionでfenceが永久待機しないようにした。
- geometry cache keyをsource/revisionから`ObservationPointInstanceGeneration` identityへ変更した。
  同一snapshot objectのcamera-only更新はinstance holder/geometryを再利用し、同じsource/revisionでも
  station collectionが置換された場合は色・半径・座標を再packして新geometryを作る。
- public `createObservationPointBatch`はcallerの`Float32List`とoffsetを含む`ByteData`をdefensive copyし、
  内部所有bufferのunmodifiable viewだけを公開する。camera-onlyの`withFrame`はinstance holderを
  そのまま共有し、32-byte frame uniformだけをcopyする。

### 変更ファイル

- `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- `packages/eqmonitor_map/lib/src/renderer/observation_point_batch.dart`
- `packages/eqmonitor_map/lib/src/renderer/observation_point_batch_builder.dart`
- `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`
- `packages/eqmonitor_map/test/renderer/observation_point_batch_builder_test.dart`
- `third_party/flutter_scene/packages/flutter_scene/lib/scene.dart`
- `third_party/flutter_scene/packages/flutter_scene/lib/src/render/frame_transients.dart`
- `third_party/flutter_scene/packages/flutter_scene/test/render/frame_transients_test.dart`
- `third_party/flutter_scene/packages/flutter_scene/test/static_instance_geometry_export_test.dart`

### TDD RED / GREEN

```text
cd third_party/flutter_scene/packages/flutter_scene
mise exec -- flutter test --no-pub \
  test/render/frame_transients_test.dart \
  test/static_instance_geometry_export_test.dart
```

RED: `waitForCompletionThrough`と`waitForPendingGpuSubmissions`が未定義でexit 1。
GREEN: capture以前のout-of-order completion、capture後のsubmission除外、重複terminal callback、
同期submit例外、public exportを含む12 pass、GPU device依存1 skip。

```text
cd packages/eqmonitor_map
mise exec -- flutter test --no-pub \
  test/flutter_scene/flutter_scene_map_adapter_test.dart \
  --plain-name 'retire-all waits for captured GPU completion without another submit'
```

RED: `waitForGpuCompletion` named parameter未定義でexit 1。GREEN: 後続frameなし、Scene detach後の
fence capture、completion前は非retire、completion後retireを確認。重複retire要求と
`GPU context lost` error completionも各GREEN。

```text
mise exec -- flutter test --no-pub \
  test/flutter_scene/flutter_scene_map_adapter_test.dart \
  --plain-name 'same source and revision with changed color creates new geometry'
```

RED: `Expected: not same instance`に対して同じgeometryを再利用。GREEN: 色だけのsnapshot置換で
新instance generation/new geometry、同一snapshot camera-onlyでは同一holder/geometryを確認。

```text
mise exec -- flutter test --no-pub \
  test/renderer/observation_point_batch_builder_test.dart \
  --plain-name 'public factory defensively owns instance and uniform buffers'
```

RED: caller側buffer変更後にinstance先頭が`99`へ変化。GREEN: instance/uniformとも元buffer変更の
影響を受けず、公開viewへの書込みも`UnsupportedError`。

### 最終検証

- eqmonitor_map focused: 30 pass。
- eqmonitor_map full: 631 pass。
- flutter_scene focused: 12 pass、GPU依存1 skip。
- flutter_scene full: 1231 pass、GPU依存35 skip。並列実行は一時領域枯渇で一度失敗したため、
  `--concurrency=1`で再実行して完走した。
- eqmonitor_map / flutter_sceneとも`mise exec -- flutter analyze --fatal-infos`は
  `No issues found!`。両repositoryの`git diff --check`も成功。

### 自己レビュー / 懸念

- `rg`でScene renderer内の全command buffer submissionが`rendererSubmissions.submit`経由であることを
  確認した。fence APIのpublic surfaceは1関数だけで、Task 7外へresource APIを広げていない。
- Scene nodeを外す前にfenceをcaptureする順序逆転、completionの二重retire、context-loss error、
  同期submit failureの永久waitを回帰testで固定した。
- CPU-only test環境では実GPU completionを発生できないため、実GPU backend固有のcallback timingは
  Flutter GPU/Impellerのcompletion contractに依存する。GPU unavailableによるskip以外の懸念はない。

### コミット / push

- flutter_scene: `53ce8b23 fix: GPU完了fenceで安全なretireを可能にする`
- flutter_scene: `a603eeb2 fix: 同期submit失敗でもfenceを解放`
- EQMonitor: `99fec3142 fix: 観測点instanceの所有権と世代identityを強化`
- EQMonitor: `d61550bbd fix: snapshot置換時に観測点geometryを更新`
- EQMonitor: `f7751bc94 fix: dispose後もGPU完了を待ってgeometryをretire`
- fork/main branchともYumNumm originへpush済み。

## Review fix round 2

### Finding調査

- base `bf13c6835`を直接確認し、修正前のままbuilder focused 8 testsと
  `mise exec -- flutter analyze --fatal-infos`を新規実行した。どちらも成功し、指摘された
  compile failureは再現しなかった。
- Dart Analyzer 13.3のprivate named parameter仕様では、private initializing formal
  `this._stationSnapshotIdentity`のcall-site名は先頭underscoreを除いた
  `stationSnapshotIdentity`になる。Analyzer自身もunderscore付きcallを
  `useOfPrivateParameterName`として拒否する。このため前回の631 tests/analyze成功とコードは
  整合しており、前回報告は実行結果どおりだった。
- 一方で、この新しい言語仕様を知らない読み手にはconstructor宣言とcall siteが不一致に見える。
  constructorを`required Object stationSnapshotIdentity`という明示named parameterにし、
  initializerで別名private field `_stationSnapshotToken`へ代入する形へ変更した。runtime behaviorと
  public factory APIは変えていない。

### Report修正

- 冒頭のcache説明をsource/revision単独から、source/revision + station snapshot identityへ更新した。
- geometry ownerのcache keyをcontext generation + instance generationとして明記した。
- 旧「永久dispose後のfenceなし」懸念を、round 1で実装済みのScene detach後completion fenceと
  resource owner保持へ更新した。

### 検証

```text
cd packages/eqmonitor_map
mise exec -- flutter test --no-pub \
  test/renderer/observation_point_batch_builder_test.dart \
  test/flutter_scene/flutter_scene_map_adapter_test.dart
```

結果: 30 tests、`All tests passed!`。

```text
mise exec -- flutter test --no-pub
```

結果: 631 tests、`All tests passed!`。

```text
mise exec -- flutter analyze --fatal-infos
```

結果: `No issues found!`。findingが現行コードで再現しなかったため新しいbehavior testは追加せず、
既存のfactory defensive ownershipとcamera-only reuse testでconstructor両call pathを再検証した。
