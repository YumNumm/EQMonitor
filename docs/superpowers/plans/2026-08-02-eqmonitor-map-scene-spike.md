# EQMonitor Flutter Scene Spike Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 固定revisionのFlutter masterとFlutter Sceneで、iOS/Android実機上の正射影mesh、部分更新、TextPainter overlay、lifecycle復帰を観測し、foundationへ進めるかblockedかを判定できる最小の`eqmonitor_map` package/exampleを作る。

**Architecture:** ルートpub workspace全体をリポジトリ内の固定Flutter SDKへ切り替え、Flutter Scene型は`MapSceneRendererAdapter`の実装内に隔離する。GPUに依存しない射影、mesh入力、lifecycle、gate判定を純粋Dartとして先にテストし、実GPUはexample harnessから検証結果をJSONへ書き出す。公開APIで証明できないGPU完了、context loss、resource retirementは成功扱いにせず、foundationを止めるfail-closed gateとして記録する。

**Tech Stack:** Flutter master `de01d5daa62dcb2fd0378d55206c91e4cf008923`、Flutter Scene git `695c954f237fabef65d49fa7199002851d2dcd88`、Flutter GPU/Impeller、Dart、Freezed、json_serializable、flutter_hooks、TextPainter、mise、Melos。

## Global Constraints

- Stack parentは`codex/eqmonitor-map-01-design`、実装branchは`codex/eqmonitor-map-02-scene-spike`とする。PRは作らず、本文だけを`docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md`へ保存する。
- 対象platformはiOS/Androidのみ。bearingとpitchは実装せず、north-upの正射影だけを扱う。
- Flutter frameworkは`de01d5daa62dcb2fd0378d55206c91e4cf008923`、Flutter Sceneは`695c954f237fabef65d49fa7199002851d2dcd88`へ完全固定し、branch名やfloating masterを依存記述に使わない。
- `packages/*`が単一pub workspaceであるためFlutter Sceneだけをstable workspaceから分離せず、ユーザーが許可したFlutter masterへroot workspace全体を移行する。既存appのunit/analyzeに加えてAndroid/iOS compile gateを必須化する。
- `mise exec -- flutter`と`mise exec -- dart`は固定SDKだけを実行し、SDK未取得・revision不一致・別SDKへのfallbackを明示的なエラーにする。
- Flutter/Dart commandは必ず`mise exec --`経由、依存追加は`mise exec -- flutter pub add`、生成は`mise exec -- dart run build_runner build --delete-conflicting-outputs`で行う。
- Flutter Scene型をdomain、evidence model、公開adapter interfaceへ漏らさない。
- 保存・交換するmodelはFreezedとjson_serializableを使う。`Float32List`を持つframe-local mesh入力はhot-path例外とし、JSONへ通さない。
- Widget、golden、性能benchmark testは`docs/todo/800_eqmonitor_map_deferred_verification.md`の後続範囲とする。純粋ロジックのunit testと物理端末gateはこのstackで実施する。
- `SceneSpike*` observation/evidenceと単一label painterはこのgate専用のinternal APIであり、public barrelへexportしない。`03-foundation`の`MapPerformance*`や`07-labels`の配置/collision APIを先取りしない。
- PMTiles、MVT、GeoJSON、label collision、MapNode/Element reconciler、MapLibre置換、3D/地下震源/断層はこのspikeへ入れない。
- iOS/Androidのprofileとreleaseでgate evidenceが揃うまで`03-foundation`を開始しない。未実施、観測不能、例外、resource recovery未証明はpassに変換しない。
- Flutter Scene公開API監査で既に判明したcontext loss/disposal/GPU completionの欠落を短絡的に隠さない。stack 02の完成状態は「gate pass」または「再現可能なblocked decision」のどちらかであり、後者でもharnessと残りcapabilityの証拠を保存するが`03-foundation`へ進まない。
- `print()`、`dynamic`（`Map<String, dynamic>`以外）、`Object`、null assertionを新規Dart codeで使わない。

---

### Task 1: 固定Flutter master toolchain

**Files:**
- Modify: `.gitignore`
- Modify: `mise.toml`
- Modify: `mise.lock`
- Modify: `.github/workflows/wc-check-dart-analyze.yaml`
- Modify: `.github/workflows/wc-check-dart-test.yaml`
- Modify: `.github/workflows/wc-check-integration.yaml`
- Modify: `.github/workflows/deploy-app.yaml`
- Modify: `.github/workflows/wc-changes.yaml`
- Modify: `.github/workflows/pr-flutter-check.yaml`
- Create: `.github/workflows/wc-check-eqmonitor-map-scene-spike.yaml`
- Create: `tool/eqmonitor_map/bin/flutter`
- Create: `tool/eqmonitor_map/bin/dart`
- Create: `tool/eqmonitor_map/run_pinned_flutter_tool`
- Create: `tool/eqmonitor_map/flutter_sdk_guard.sh`
- Create: `tool/eqmonitor_map/test/run_pinned_flutter_tool_test.sh`
- Create: `docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md`

**Interfaces:**
- Consumes: mise `bootstrap.repos`とroot configuration。
- Produces: `mise exec -- flutter ...`と`mise exec -- dart ...`が固定checkoutだけを起動するfail-closed command surface。

- [ ] **Step 1: SDK未取得時の失敗testを書く**

`run_pinned_flutter_tool_test.sh`は一時git repositoryを作り、guardのmissing checkout、non-git、wrong revision、dirty tracked file、valid clean revisionと、runnerの自己更新command拒否を検証する。runnerのSDK directoryが無い場合は終了codeが非0で、stderrが固定revisionと`mise bootstrap repos apply --yes`を含むことも検証する。

```bash
output="$($runner flutter --version 2>&1)" && exit 1
case "$output" in
  *de01d5daa62dcb2fd0378d55206c91e4cf008923*"mise bootstrap repos apply --yes"*) ;;
  *) exit 1 ;;
esac
```

- [ ] **Step 2: testがproduction runner不在で失敗することを確認する**

Run: `bash tool/eqmonitor_map/test/run_pinned_flutter_tool_test.sh`

Expected: FAIL because runner and guard do not exist.

- [ ] **Step 3: mise bootstrapとfail-closed shimを実装する**

`.flutter-scene-sdk/`をignoreし、`mise.toml`からstable Flutter tool entryを外す。固定repoを宣言し、shim directoryをPATHの先頭へ置く。

```toml
min_version = "2026.08.0"

[env.'_']
path = { path = ["tool/eqmonitor_map/bin"], tools = true }

[bootstrap.repos]
".flutter-scene-sdk" = { url = "https://github.com/flutter/flutter.git", ref = "de01d5daa62dcb2fd0378d55206c91e4cf008923" }
```

`tools = true`でglobal mise toolより後にproject shimを前置する。共通runnerはtool名をallow-listし、`flutter upgrade`、`flutter downgrade`、`flutter channel`を拒否してからguardを呼ぶ。guardは引数で受けたSDK pathとexpected revisionについて、40桁lowercase hex、git checkout、HEAD完全一致、tracked fileがclean、実行fileの存在を検証する。固定revision引数を渡せるのはrepository内runnerだけであり、caller環境変数では上書きできない。

```bash
expected_revision=de01d5daa62dcb2fd0378d55206c91e4cf008923
case "$1" in
  flutter|dart) sdk_tool="$1" ;;
  *) echo "unsupported pinned Flutter tool: $1" >&2; exit 64 ;;
esac
actual_revision="$(git -C "$sdk_dir" rev-parse HEAD 2>/dev/null || true)"
if [[ "$actual_revision" != "$expected_revision" ]]; then
  echo "Flutter SDK must be $expected_revision; run mise bootstrap repos apply --yes" >&2
  exit 78
fi
exec "$sdk_dir/bin/$sdk_tool" "${@:2}"
```

`bin/flutter`と`bin/dart`はそれぞれ共通runnerへtool名を渡すだけにする。runnerは自身の位置からrepo rootを解決し、caller supplied pathやsystem PATHのFlutterを採用しない。

- [ ] **Step 4: shell testとbootstrap dry-runを通す**

Run: `bash tool/eqmonitor_map/test/run_pinned_flutter_tool_test.sh`

Expected: PASS.

Run: `mise exec -- shellcheck tool/eqmonitor_map/bin/flutter tool/eqmonitor_map/bin/dart tool/eqmonitor_map/run_pinned_flutter_tool tool/eqmonitor_map/flutter_sdk_guard.sh tool/eqmonitor_map/test/run_pinned_flutter_tool_test.sh`

Expected: no findings.

Run: `mise bootstrap repos apply --dry-run`

Expected: `.flutter-scene-sdk`を指定URL・指定SHAへcloneする計画だけを表示する。

- [ ] **Step 5: 固定SDKを取得してrevisionを検証する**

Run: `mise bootstrap repos apply --yes`

Run: `mise exec -- flutter --version --machine`

Run: `mise exec -- dart --version`

Expected: framework revisionが`de01d5daa62dcb2fd0378d55206c91e4cf008923`で、両commandの実体が`.flutter-scene-sdk/bin`にある。実測したFlutter、Engine、Dart revisionをknowledge documentへ記録する。

固定Flutter Scene sourceも`rg`で監査し、public completion fence、GPU context-loss callback/generation、resource dispose/reset APIがexportされていないことをknowledge documentへfile/symbol付きで記録する。この時点で3 capabilityは`unavailablePublicApi`と確定する。以降のharnessは他capabilityとblocked decisionを再現可能にするために続行し、この監査結果をmanual actionで上書きしない。

- [ ] **Step 6: CIも固定SDK checkoutを使うよう更新する**

Flutterを使うanalyze、test、integration、iOS deploy、Android deploy jobではrepository checkout直後に次を追加する。

```yaml
- name: Checkout pinned Flutter SDK
  uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
  with:
    repository: flutter/flutter
    ref: de01d5daa62dcb2fd0378d55206c91e4cf008923
    path: .flutter-scene-sdk
    fetch-depth: 1
    persist-credentials: false
```

mise-actionの`install_args`から`flutter`だけを除き、jobが必要とする他toolは保持する。`wc-check-dart-analyze`と`wc-check-dart-test`は空の`install_args`にせず`install: false`を指定し、全tool installを防ぐ。integration、iOS、Android jobはFlutter以外に実際に使うtoolだけを`install_args`へ残す。SDK checkout後に`mise bootstrap repos status --missing`と`mise exec -- flutter --version --machine`を実行し、shimとrevisionを検証する。`mise lock`で`mise.lock`のFlutter tool entryを除去する。

Run: `mise exec -- actionlint .github/workflows/wc-check-dart-analyze.yaml .github/workflows/wc-check-dart-test.yaml .github/workflows/wc-check-integration.yaml .github/workflows/deploy-app.yaml`

Expected: no findings.

Run: `mise exec -- dart run melos run analyze`

Expected: root workspace全体が固定masterでanalyzeを完了する。master非互換が見つかった場合はpackageだけを例外化せず、同じstackで修正するかstackをblockedにする。

Run:

```bash
mise exec -- dart run melos run test:dart
mise exec -- dart run melos run test:flutter
```

Expected: existing Dart/Flutter unit suites pass on the pinned master SDK.

`wc-check-dart-analyze.yaml`にはapp reporterとは別に`mise exec -- dart run melos run analyze`を追加し、`eqmonitor_map`を含むworkspace全体を必須化する。さらに`wc-changes.yaml`へ`eqmonitor_map_scene_spike` filterを追加し、package、root SDK pin、lockfile、専用workflow変更時だけ`pr-flutter-check.yaml`から新しいreusable workflowを呼ぶ。

`wc-check-eqmonitor-map-scene-spike.yaml`はUbuntuでexampleのAndroid profile/release build、macOSでiOS profile/release `--no-codesign` buildを固定SDK・生成済みdart-define manifest付きで実行する。両jobをPR status checkの`needs`へ追加する。これは署名・配布を行わないapp-equivalent compile gateで、deploy workflowの署名処理やsecretへ触れない。

- [ ] **Step 7: commitする**

```bash
git add .gitignore mise.toml mise.lock .github/workflows tool/eqmonitor_map docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md
git commit -m "Toolchain: Flutter masterを固定"
```

---

### Task 2: packageとiOS/Android example scaffold

**Files:**
- Modify: `pubspec.yaml`
- Modify: `pubspec.lock`
- Create: `packages/eqmonitor_lints/analysis_options.yaml`
- Create: `packages/eqmonitor_lints/recommended.yaml`
- Create: `packages/eqmonitor_map/pubspec.yaml`
- Create: `packages/eqmonitor_map/analysis_options.yaml`
- Create: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `packages/eqmonitor_map/lib/src/eqmonitor_map_library.dart`
- Create: `packages/eqmonitor_map/test/eqmonitor_map_library_test.dart`
- Create: `packages/eqmonitor_map/example/pubspec.yaml`
- Create: `packages/eqmonitor_map/example/analysis_options.yaml`
- Create: `packages/eqmonitor_map/example/lib/main.dart`
- Create: `packages/eqmonitor_map/example/android/**`
- Create: `packages/eqmonitor_map/example/ios/**`

**Interfaces:**
- Consumes: Task 1の固定`flutter`/`dart` command。
- Produces: workspace member `eqmonitor_map`、public barrel、物理iOS/Androidで起動できるexample host、既存`eqmonitor_lints`の解決可能なinclude surface。

- [ ] **Step 1: public library markerのfailing testを書く**

```dart
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exports the EQMonitor-only library identity', () {
    expect(eqmonitorMapLibrary.packageName, 'eqmonitor_map');
    expect(eqmonitorMapLibrary.supportedPlatforms, const ['ios', 'android']);
  });
}
```

- [ ] **Step 2: packageだけをworkspaceへ登録し、testの失敗を確認する**

package本体は既存`packages/*` globでworkspace memberになる。まだ存在しない`packages/eqmonitor_map/example`はこの時点でroot `workspace:`へ追加しない。

Run: `mise exec -- flutter test packages/eqmonitor_map/test/eqmonitor_map_library_test.dart`

Expected: FAIL because `eqmonitorMapLibrary` is undefined.

- [ ] **Step 3: 欠落しているlint includeを修復する**

既存consumerが参照している2ファイルを次の内容で作る。

`packages/eqmonitor_lints/analysis_options.yaml`:

```yaml
include: recommended.yaml
```

`packages/eqmonitor_lints/recommended.yaml`:

```yaml
include: package:yumemi_lints/flutter/3.41/recommended.yaml
```

`packages/eqmonitor_map/analysis_options.yaml`とexampleは`include: package:eqmonitor_lints/recommended.yaml`を使う。別lint設定で検査を回避しない。

- [ ] **Step 4: package markerを最小実装する**

```dart
const eqmonitorMapLibrary = EqmonitorMapLibrary(
  packageName: 'eqmonitor_map',
  supportedPlatforms: ['ios', 'android'],
);

class EqmonitorMapLibrary {
  const EqmonitorMapLibrary({
    required this.packageName,
    required this.supportedPlatforms,
  });

  final String packageName;
  final List<String> supportedPlatforms;
}
```

- [ ] **Step 5: Flutter Sceneとmodel生成依存を固定追加する**

Run from `packages/eqmonitor_map`:

```bash
mise exec -- flutter pub add vector_math flutter_hooks freezed_annotation json_annotation device_info_plus
mise exec -- flutter pub add dev:build_runner dev:freezed dev:json_serializable
mise exec -- flutter pub add "dev:flutter_test@{sdk: flutter}"
mise exec -- flutter pub add "dev:eqmonitor_lints@{path: ../eqmonitor_lints}"
```

Flutter Sceneは正確に次のdescriptorで追加する。

```bash
mise exec -- flutter pub add "flutter_scene@{git:{url: https://github.com/bdero/flutter_scene.git, ref: 695c954f237fabef65d49fa7199002851d2dcd88, path: packages/flutter_scene}}"
```

Flutter Sceneのgit descriptorはlockfile内でも`resolved-ref`が`695c954f237fabef65d49fa7199002851d2dcd88`であることを確認する。

- [ ] **Step 6: iOS/Android hostを生成してからworkspaceへ登録する**

Run:

```bash
mise exec -- flutter create --no-pub --platforms=android,ios --project-name eqmonitor_map_example packages/eqmonitor_map/example
```

生成後にexample pubspecへ`resolution: workspace`を設定し、root `workspace:`へ`packages/eqmonitor_map/example`を追加してから依存を追加する。

```bash
mise exec -- flutter pub add -C packages/eqmonitor_map/example "eqmonitor_map@{path: ../}"
mise exec -- flutter pub add -C packages/eqmonitor_map/example "dev:eqmonitor_lints@{path: ../../eqmonitor_lints}"
mise exec -- flutter pub add -C packages/eqmonitor_map/example hooks
mise exec -- flutter pub add -C packages/eqmonitor_map/example "flutter_scene@{git:{url: https://github.com/bdero/flutter_scene.git, ref: 695c954f237fabef65d49fa7199002851d2dcd88, path: packages/flutter_scene}}"
mise exec -- flutter pub get
```

exampleの依存は`eqmonitor_map: {path: ../}`、platformはAndroid/iOSだけとする。default counter logicとdefault widget testは削除し、`main.dart`はpackage名と固定revision gateを示す静的homeを表示する。

- [ ] **Step 7: test、analyze、revision pinを確認する**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/eqmonitor_map_library_test.dart`

Expected: PASS.

Run: `mise exec -- dart analyze packages/eqmonitor_map`

Expected: no issues.

Run: `rg -n "695c954f237fabef65d49fa7199002851d2dcd88" packages/eqmonitor_map/pubspec.yaml pubspec.lock`

Expected: pubspecとlockfileの双方で固定revisionが確認できる。

- [ ] **Step 8: commitする**

```bash
git add pubspec.yaml pubspec.lock packages/eqmonitor_lints/analysis_options.yaml packages/eqmonitor_lints/recommended.yaml packages/eqmonitor_map
git commit -m "Package: Flutter Sceneスパイクを追加"
```

---

### Task 3: north-up正射影と部分更新用mesh input

**Files:**
- Create: `packages/eqmonitor_map/lib/src/renderer/map_scene_renderer_adapter.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/eqmonitor_orthographic_projection.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/spike_screen_projector.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/spike_mesh_frame.dart`
- Create: `packages/eqmonitor_map/test/renderer/eqmonitor_orthographic_projection_test.dart`
- Create: `packages/eqmonitor_map/test/renderer/spike_screen_projector_test.dart`
- Create: `packages/eqmonitor_map/test/renderer/spike_mesh_frame_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**
- Consumes: logical viewport sizeとimmutable mesh update request。
- Produces: Flutter Scene非依存の`MapSceneRendererAdapter`、公開されないFlutter Scene projection bridge、`SpikeMeshFrame`。

- [ ] **Step 1: projectionとmesh deltaのfailing testを書く**

```dart
test('maps north-up world bounds to clip space without bearing or pitch', () {
  const projection = EqmonitorOrthographicProjection(worldHalfHeight: 1);
  final matrix = projection.matrixFor(aspectRatio: 2);
  expect(matrix.transform3(Vector3(-2, -1, 0)), Vector3(-1, -1, 0));
  expect(matrix.transform3(Vector3(2, 1, 0)), Vector3(1, 1, 0));
});

test('changes one vertex and exposes the exact dirty range', () {
  final next = SpikeMeshFrame.initial().moveVertex(
    vertexIndex: 2,
    position: Vector3(0.75, 0.5, 0),
  );
  expect(next.positionDirtyRange, const SpikeDirtyRange(start: 2, count: 1));
  expect(next.colorDirtyRange, isNull);
  expect(next.positions.sublist(6, 9), [0.75, 0.5, 0]);
});

test('recolors one vertex without uploading positions', () {
  final next = SpikeMeshFrame.initial().recolorVertex(
    vertexIndex: 4,
    color: Vector4(1, 0, 0, 1),
  );
  expect(next.positionDirtyRange, isNull);
  expect(next.colorDirtyRange, const SpikeDirtyRange(start: 4, count: 1));
});

test('projects north to the top in logical pixels at every DPR', () {
  const projector = SpikeScreenProjector();
  expect(
    projector.fromClip(
      clip: Vector3(0, 1, 0),
      logicalSize: const Size(200, 100),
      devicePixelRatio: 3,
    ),
    const Offset(100, 0),
  );
  expect(
    projector.fromClip(
      clip: Vector3(1, -1, 0),
      logicalSize: const Size(100, 200),
      devicePixelRatio: 1,
    ),
    const Offset(100, 200),
  );
});
```

- [ ] **Step 2: targeted testsが型不在で失敗することを確認する**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/renderer`

Expected: FAIL because projection and mesh types are undefined.

- [ ] **Step 3: Flutter Scene非依存のadapter contractを定義する**

```dart
abstract interface class MapSceneRendererAdapter {
  void attach({required Size logicalSize, required double devicePixelRatio});
  void updateMesh({required SpikeMeshFrame frame});
  void setForeground({required bool isForeground});
  void requestAppResourceRebuild({required int appResourceGeneration});
  void completeAppResourceRebuild({required int appResourceGeneration});
  void detach();
  void dispose();
}
```

InterfaceではFlutter Sceneの`Scene`、`Node`、`MeshGeometry`、`Material`を一切返さない。

- [ ] **Step 4: pure projectionとtyped-array mesh frameを実装する**

`EqmonitorOrthographicProjection.matrixFor`はvector_mathの公開関数`makeOrthographicMatrix(-aspectRatio * worldHalfHeight, aspectRatio * worldHalfHeight, -worldHalfHeight, worldHalfHeight, -1, 1)`を返す。`SpikeScreenProjector.fromClip`は`x = (clip.x + 1) / 2 * width`、`y = (1 - clip.y) / 2 * height`でlogical pixelへ変換する。DPRは入力validationとframe snapshot identityに含めるがlogical座標へ乗算せず、resize時は新しいlogical sizeで再計算する。

`SpikeMeshFrame`は6頂点のquad positions/colorsを`Float32List`で保持する。`moveVertex`はnullable `positionDirtyRange`だけ、`recolorVertex`はnullable `colorDirtyRange`だけを設定し、`updateVertex`は両方を設定する。`SpikeDirtyRange`は非負startと正countを検証するimmutable valueとする。これらはframe-local hot pathなのでFreezed/JSON対象外であることをdoc commentに記す。

Flutter Scene projection bridgeはこのTaskへ置かず、Task 6の`lib/src/flutter_scene/`内だけに作る。

- [ ] **Step 5: targeted testsとanalyzeを通す**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/renderer`

Expected: PASS.

Run: `mise exec -- dart analyze packages/eqmonitor_map`

Expected: no issues.

- [ ] **Step 6: commitする**

```bash
git add packages/eqmonitor_map/lib packages/eqmonitor_map/test/renderer
git commit -m "Renderer: 正射影とmesh更新契約を追加"
```

---

### Task 4: lifecycleとapp resource generationのfail-closed state machine

**Files:**
- Create: `packages/eqmonitor_map/lib/src/renderer/scene_spike_lifecycle.dart`
- Create: `packages/eqmonitor_map/test/renderer/scene_spike_lifecycle_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**
- Consumes: attach、foreground/background、surface recreation、dispose event。
- Produces: `SceneSpikeLifecycleState`、monotonic `appResourceGeneration`、upload/tick/rebuild permission。GPU context generationの観測値は生成しない。

- [ ] **Step 1: transition tableのfailing testを書く**

```dart
test('background stops ticking and uploads until foreground rebuild', () {
  final attached = reducer.reduce(
    SceneSpikeLifecycleState.initial(),
    const SceneSpikeLifecycleEvent.attached(),
  );
  final background = reducer.reduce(
    attached,
    const SceneSpikeLifecycleEvent.backgrounded(),
  );
  expect(background.mayTick, isFalse);
  expect(background.mayUpload, isFalse);

  final resumed = reducer.reduce(
    background,
    const SceneSpikeLifecycleEvent.foregrounded(),
  );
  expect(resumed.requiresResourceRebuild, isTrue);
  expect(
    resumed.appResourceGeneration,
    attached.appResourceGeneration + 1,
  );
});

test('disposed is terminal', () {
  final disposed = reducer.reduce(
    SceneSpikeLifecycleState.initial(),
    const SceneSpikeLifecycleEvent.disposed(),
  );
  expect(
    () => reducer.reduce(disposed, const SceneSpikeLifecycleEvent.attached()),
    throwsStateError,
  );
});

test('deduplicates real mobile background lifecycle sequences', () {
  var state = reducer.reduce(
    SceneSpikeLifecycleState.initial(),
    const SceneSpikeLifecycleEvent.attached(),
  );
  for (var index = 0; index < 3; index++) {
    state = reducer.reduce(
      state,
      const SceneSpikeLifecycleEvent.backgrounded(),
    );
  }
  expect(state.phase, SceneSpikeLifecyclePhase.background);
  expect(state.appResourceGeneration, 0);
});
```

- [ ] **Step 2: testが型不在で失敗することを確認する**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/renderer/scene_spike_lifecycle_test.dart`

Expected: FAIL because lifecycle types are undefined.

- [ ] **Step 3: Freezed state/eventとpure reducerを実装する**

Stateは`SceneSpikeLifecyclePhase` enumの`detached`、`active`、`background`、`rebuilding`、`disposed`と、`appResourceGeneration`、`mayTick`、`mayUpload`、`requiresResourceRebuild`を持つ単一のFreezed modelにする。`SceneSpikeLifecycleState.initial()`はdetached、generation 0、全permission falseを返す。background/foregroundとsurface recreationはapp所有resourceのgenerationを進め、resource rebuild acknowledgementまでuploadを許可しない。この値をFlutter GPU context generationとして記録してはならない。Flutter `AppLifecycleState`への変換はWidget側だけで行う。

```dart
@freezed
sealed class SceneSpikeLifecycleEvent with _$SceneSpikeLifecycleEvent {
  const factory SceneSpikeLifecycleEvent.attached() = _Attached;
  const factory SceneSpikeLifecycleEvent.backgrounded() = _Backgrounded;
  const factory SceneSpikeLifecycleEvent.foregrounded() = _Foregrounded;
  const factory SceneSpikeLifecycleEvent.surfaceRecreated() = _SurfaceRecreated;
  const factory SceneSpikeLifecycleEvent.rebuildCompleted() = _RebuildCompleted;
  const factory SceneSpikeLifecycleEvent.detached() = _Detached;
  const factory SceneSpikeLifecycleEvent.disposed() = _Disposed;
}
```

Reducerのtransitionは次へ固定する。

| Current | Event | Next |
| --- | --- | --- |
| detached | attached | active、同じapp resource generation、tick/upload可 |
| active | backgrounded | background、同じapp resource generation、tick/upload不可 |
| background | foregrounded | rebuilding、app resource generation + 1、rebuild required |
| active | surfaceRecreated | rebuilding、app resource generation + 1、rebuild required |
| rebuilding | rebuildCompleted | active、同じapp resource generation、tick/upload可 |
| active/background/rebuilding | detached | detached、同じapp resource generation、tick/upload不可 |
| disposed以外 | disposed | disposed、同じapp resource generation、全permission不可 |
| background | backgrounded | 同じstate（inactive/hidden/pausedのedge de-duplication） |
| active/rebuilding | foregrounded | 同じstate（重複resumedのedge de-duplication） |
| disposed | disposed | 同じstate（cleanupのidempotence） |
| disposed | disposed以外 | `StateError` |

表にないtransitionは`StateError`とし、列挙したOS lifecycleの重複以外は都合のよい暗黙復帰を行わない。

- [ ] **Step 4: code generation、test、analyzeを通す**

Run from `packages/eqmonitor_map`: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- flutter test packages/eqmonitor_map/test/renderer/scene_spike_lifecycle_test.dart`

Expected: PASS.

Run: `mise exec -- dart analyze packages/eqmonitor_map`

Expected: no issues.

- [ ] **Step 5: commitする**

```bash
git add packages/eqmonitor_map/lib packages/eqmonitor_map/test/renderer
git commit -m "Lifecycle: GPU再構築状態を型付け"
```

---

### Task 5: 性能観測とdevice gate evidence

**Files:**
- Create: `packages/eqmonitor_map/lib/src/observability/scene_spike_observation.dart`
- Create: `packages/eqmonitor_map/lib/src/observability/scene_spike_gate.dart`
- Create: `packages/eqmonitor_map/test/observability/scene_spike_gate_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**
- Consumes: platform/build mode/revision、frame timings、lifecycle event、capability observation。
- Produces: JSON対応`SceneSpikeEvidence`、`SceneSpikeCapabilityResult`、`SceneSpikeGateDecision`、軽量event/snapshot sink。

- [ ] **Step 1: fail-closed gateのfailing testを書く**

```dart
test('does not pass when a required capability is unobserved', () {
  final evidence = validAndroidProfileEvidence().copyWith(
    capabilities: [
      SceneSpikeCapabilityResult(
        capability: SceneSpikeCapability.gpuCompletionOrSafeRetirement,
        status: SceneSpikeCapabilityStatus.unobserved,
        provenance: SceneSpikeObservationProvenance.unavailablePublicApi,
        detail: 'Flutter Scene has no public completion fence.',
        observedAtUtc: DateTime.utc(2026, 8, 2),
      ),
    ],
  );
  expect(SceneSpikeGate.evaluate([evidence]).isPass, isFalse);
});

test('requires profile and release evidence for both mobile platforms', () {
  final evidence = [
    validIosProfileEvidence(),
    validIosReleaseEvidence(),
    validAndroidProfileEvidence(),
  ];
  expect(SceneSpikeGate.evaluate(evidence).missingRuns, [
    const SceneSpikeRunKey(platform: SceneSpikePlatform.android, buildMode: SceneSpikeBuildMode.release),
  ]);
});

test('rejects duplicate run keys and duplicate capabilities', () {
  final run = validAndroidProfileEvidence();
  expect(SceneSpikeGate.evaluate([run, run]).isPass, isFalse);
  final duplicateCapability = run.copyWith(
    capabilities: [...run.capabilities, run.capabilities.first],
  );
  expect(SceneSpikeGate.evaluate([duplicateCapability]).isPass, isFalse);
});

test('rejects unknown schema, wrong revisions, invalid UTC and counters', () {
  final invalid = validAndroidProfileEvidence().copyWith(
    schemaVersion: 2,
    flutterFrameworkRevision: 'wrong',
    startedAtUtc: DateTime(2026, 8, 2),
    frameCount: -1,
  );
  expect(SceneSpikeGate.evaluate([invalid]).isPass, isFalse);
});
```

- [ ] **Step 2: testがmodel不在で失敗することを確認する**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/observability/scene_spike_gate_test.dart`

Expected: FAIL because evidence and gate types are undefined.

- [ ] **Step 3: Freezed/json evidence modelを実装する**

`SceneSpikeEvidence`には少なくとも次を必須化する。

```dart
@freezed
sealed class SceneSpikeEvidence with _$SceneSpikeEvidence {
  const factory SceneSpikeEvidence({
    required int schemaVersion,
    required SceneSpikeRunKey run,
    required String deviceModel,
    required String operatingSystemVersion,
    required String flutterFrameworkRevision,
    required String flutterEngineRevision,
    required String dartVersion,
    required String flutterSceneRevision,
    required String eqmonitorMapRendererRevision,
    required bool eqmonitorMapRendererCheckoutDirty,
    required SceneSpikeObservationProvenance revisionProvenance,
    required String renderingBackend,
    required SceneSpikeObservationProvenance renderingBackendProvenance,
    required DateTime startedAtUtc,
    required int elapsedMicroseconds,
    required int frameCount,
    required int partialUpdateCount,
    required int lifecycleResumeCount,
    required int appResourceGeneration,
    required List<SceneSpikeCapabilityResult> capabilities,
    required SceneSpikePerformanceSnapshot performance,
  }) = _SceneSpikeEvidence;

  factory SceneSpikeEvidence.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeEvidenceFromJson(json);
}
```

関連typeを次へ固定する。

```dart
enum SceneSpikePlatform { ios, android }
enum SceneSpikeBuildMode { profile, release }
enum SceneSpikeCapabilityStatus { passed, failed, unobserved }
enum SceneSpikeObservationProvenance {
  runtimeSignal,
  compileTimeManifest,
  operatorAttestation,
  unavailablePublicApi,
}
enum SceneSpikeCapability {
  proceduralOrthographicMesh,
  unlitMaterial,
  customMaterial,
  partialPositionAndColorUpdate,
  textPainterOverlay,
  dprAndResize,
  backgroundAndForeground,
  disposeAndRemount,
  explicitResourceDisposal,
  contextResourceRebuild,
  gpuCompletionOrSafeRetirement,
}

@freezed
sealed class SceneSpikeRunKey with _$SceneSpikeRunKey {
  const factory SceneSpikeRunKey({
    required SceneSpikePlatform platform,
    required SceneSpikeBuildMode buildMode,
  }) = _SceneSpikeRunKey;

  factory SceneSpikeRunKey.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeRunKeyFromJson(json);
}

@freezed
sealed class SceneSpikeCapabilityResult with _$SceneSpikeCapabilityResult {
  const factory SceneSpikeCapabilityResult({
    required SceneSpikeCapability capability,
    required SceneSpikeCapabilityStatus status,
    required SceneSpikeObservationProvenance provenance,
    required String detail,
    required DateTime observedAtUtc,
  }) = _SceneSpikeCapabilityResult;

  factory SceneSpikeCapabilityResult.fromJson(Map<String, dynamic> json) =>
      _$SceneSpikeCapabilityResultFromJson(json);
}
```

`SceneSpikePerformanceSnapshot`はbuild/raster durationのcount、max、p50、p95をmicrosecondsの非負`int`、dropped-frame count、partial update、resource rebuild、exception countを非負`int`で持つFreezed/json modelにする。`SceneSpikeGateDecision`は`isPass`、sorted `missingRuns`、sorted failed/unobserved capability results、schema/validation error、revision mismatch一覧を持つFreezed/json modelにする。HUDは作らず、frame callbackの計測結果をbounded accumulatorへ集約する。

platformは`Platform.isIOS/isAndroid`、build modeは`kProfileMode/kReleaseMode`、device modelは`device_info_plus`、OSとDartは`Platform`から自動取得する。Flutter framework/engine、Flutter Scene、EQMonitor renderer revisionとrenderer checkout dirty flagはTask 6のbuild manifestから`String.fromEnvironment`で読み、revision provenanceを`compileTimeManifest`へ固定する。dirty flagがtrueならgateはblockする。backendはverbose device logからoperatorがattestする別fieldとし、provenanceを`operatorAttestation`へ固定して自動値として推測しない。

capabilityごとに許可するprovenanceをgateへ固定する。partial update/lifecycle/frame timingは`runtimeSignal`、visual correctness/backendはchecklist付き`operatorAttestation`を許す。`contextResourceRebuild`、`explicitResourceDisposal`、`gpuCompletionOrSafeRetirement`は現revisionに公開APIが無いため`unavailablePublicApi`しか生成できず、常にgateをblockする。manual app resource rebuildや`appResourceGeneration`からこれらを`passed`へ変換するconstructor/APIは作らない。

- [ ] **Step 4: required capability setとgate判定を実装する**

required capabilityはprocedural orthographic mesh、unlit material、custom material、partial positions/colors update、TextPainter overlay、DPR/resize、background/foreground、dispose/remount、explicit resource disposal、context resource rebuild、GPU completionまたは実機検証済みsafe retirementである。全required capabilityが`passed`かつ4 run keyが揃い、revisionがGlobal Constraintsと一致した場合だけ`isPass`をtrueにする。現Flutter Scene revisionでは後半3 capabilityが公開API不足でblockすることが、このspikeの正しい判定になり得る。

Flutter Sceneに公開completion/context-loss/disposal APIが無い事実は`unobserved`または`failed`として保持し、`passed`へ補完しない。

- [ ] **Step 5: generation、test、JSON round-trip、analyzeを通す**

Run from `packages/eqmonitor_map`: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- flutter test packages/eqmonitor_map/test/observability`

Expected: PASS, including `toJson`/`fromJson` round-trip.

Run: `mise exec -- dart analyze packages/eqmonitor_map`

Expected: no issues.

- [ ] **Step 6: commitする**

```bash
git add packages/eqmonitor_map/lib packages/eqmonitor_map/test/observability
git commit -m "Observe: Scene実機gateをfail-closed化"
```

---

### Task 6: Flutter Scene adapter、TextPainter overlay、実機harness

**Files:**
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_adapter.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_orthographic_projection.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_controller.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_view.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/spike_label_painter.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/spike_frame_timing_collector.dart`
- Create: `packages/eqmonitor_map/example/assets/map_spike.fmat`
- Create: `packages/eqmonitor_map/example/hook/build.dart`
- Create: `packages/eqmonitor_map/tool/write_scene_spike_defines.dart`
- Modify: `packages/eqmonitor_map/example/lib/main.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**
- Consumes: Tasks 3-5のprojection、mesh frame、lifecycle state、observation sink。
- Produces: procedural quadをSceneViewで表示・部分更新し、screen-space labelを重ね、JSON evidenceを画面からcopyできるphysical-device harness。

- [ ] **Step 1: GPU非依存collectorのfailing testをTask 5 test suiteへ追加する**

```dart
test('keeps aggregate timings without retaining every frame', () {
  final collector = SpikeFrameTimingCollector(capacity: 120);
  for (var index = 0; index < 240; index++) {
    collector.add(
      buildDuration: Duration(microseconds: 1000 + index),
      rasterDuration: Duration(microseconds: 2000 + index),
    );
  }
  expect(collector.sampleCount, 240);
  expect(collector.retainedSampleCount, 120);
  expect(collector.snapshot().maxRasterDurationMicroseconds, 2239);
});
```

- [ ] **Step 2: targeted testがcollector不在で失敗することを確認する**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/observability`

Expected: FAIL because `SpikeFrameTimingCollector` is undefined.

- [ ] **Step 3: bounded timing collectorを実装する**

`SchedulerBinding.addTimingsCallback`から受けるframe timingsを固定capacity ringへ集約する。Widgetのbuild内では登録せず、hookのeffectでregister/removeする。

- [ ] **Step 4: Flutter Scene adapterを実装する**

`FlutterSceneOrthographicProjection`はTask 3のpure projectionを`scene.CameraProjection`へ変換するだけとし、このdirectoryの外へexportしない。`FlutterSceneSpikeController`がadapter、lifecycle reducer、Scene、camera、observation sinkの単一ownerになる。Viewはcontrollerのlifecycle stateをlistenし、`SceneView(autoTick: controller.lifecycle.mayTick)`としてbackground時にtickerを止める。controllerはattach、background/foreground、surface resize/recreation、app resource rebuild completion、detach、disposeをadapterとreducerへ同じ順序で伝える。

Adapterだけが次のFlutter Scene objectsを所有する。

```dart
final sceneGraph = scene.Scene();
final geometry = scene.MeshGeometry.fromArrays(
  positions: frame.positions,
  colors: frame.colors,
  storage: scene.GeometryStorage.updatable,
);
final material = scene.UnlitMaterial()
  ..baseColorFactor = Vector4(1, 1, 1, 1)
  ..vertexColorWeight = 1;
final node = scene.Node(mesh: scene.Mesh(geometry, material));
sceneGraph.add(node);
```

`updateMesh`はvertex count不変を検証する。`positionDirtyRange`がある時だけ`geometry.updatePositions`、`colorDirtyRange`がある時だけ`geometry.updateColors`を各rangeで呼び、両方nullはrejectする。background、detached、rebuildingではupdateを拒否してtyped observation eventを残す。公開dispose/fence APIが無いため、adapterはresource解放、GPU context recovery、completion fenceの成功を報告しない。

- [ ] **Step 5: fixed custom materialをbuild/loadする**

`example/assets/map_spike.fmat`はunlit shading model、opaque blending、`vec4 tint` parameterを宣言し、`Surface`でvertex/base colorへtintを乗算する固定shaderとする。hookは次だけをbuildする。

```text
material {
  name: "EqmonitorMapSpike",
  shading_model: unlit,
  blending: opaque,
  culling: none,
  parameters: [
    { type: vec4, name: tint, hint: source_color, default: [1.0, 1.0, 1.0, 1.0] },
  ],
  varyings: [
    { type: vec4, name: spike_color },
  ],
}

vertex {
  void Vertex(inout VertexInputs vertex) {
    spike_color = vertex.color;
  }
}

fragment {
  void Surface(inout MaterialInputs material) {
    material.base_color = spike_color * material_params.tint;
    PrepareMaterial(material);
  }
}
```

hookは次だけをbuildする。

```dart
import 'package:flutter_scene/build_hooks.dart';
import 'package:hooks/hooks.dart';

void main(List<String> args) {
  build(args, (config, output) async {
    await buildMaterials(
      buildInput: config,
      buildOutput: output,
      materials: ['assets/map_spike.fmat'],
      assetMode: MaterialAssetMode.dataAssetsIfAvailable,
    );
  });
}
```

Controllerは`loadFmatMaterial('assets/map_spike.fmat')`が成功した場合だけcustom material runtime observationを記録し、unlit quadとcustom-material quadを同じ正射影sceneへ並べる。load/build errorをUnlitMaterialへfallbackせず、typed failed capabilityとして画面へ表示する。

- [ ] **Step 6: HookWidgetのharnessとTextPainter overlayを実装する**

Viewは`Stack`の背面へ`scene.SceneView`、前面へ`IgnorePointer(CustomPaint(...))`を置く。cameraはnorth-up固定の`scene.NodeCamera`と`FlutterSceneOrthographicProjection`を使い、bearing/pitch controlを持たせない。

`SpikeLabelPainter`は1つの事前計算済み地理anchorをTask 3のmatrixでlogical pixelへ投影し、`TextPainter(textDirection: TextDirection.ltr)`の実測sizeで中央配置する。これはoverlay合成のproofだけで、collision、leader line、cache、semanticsは`07-labels`で実装する。

Hook effectは`WidgetsBindingObserver` adapter、frame timing callback、partial-update ticker、Scene static resource initializationを登録し、cleanupで必ず解除してcontrollerへdisposeを送る。`inactive/paused/detached/hidden`はbackground event、`resumed`はforeground eventへ変換する。resize/DPR変更はlogical projectionを再計算してapp resource rebuildを要求するが、GPU context recovery capabilityを変更しない。

- [ ] **Step 7: build metadataとexampleの明示的な検証操作を追加する**

`write_scene_spike_defines.dart`は`mise exec -- flutter --version --machine`のJSON、`git rev-parse HEAD`、`git diff --quiet HEAD --`、固定Flutter Scene revisionを読み、exampleの`.dart_tool/scene_spike_defines.json`へframework/engine/Dart/Scene/renderer revisionとrenderer dirty flagを書き出す。harnessは対応する`String.fromEnvironment`を読み、欠落時やdirty時はrunを開始できない。実行commandは次へ固定する。

```bash
mise exec -- dart run packages/eqmonitor_map/tool/write_scene_spike_defines.dart
mise exec -- flutter run --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

画面には次の操作だけを置く。

- Start/stop fixed-rate vertex/color partial updates
- Trigger app-owned resource rebuild
- Reset current run evidence
- Copy canonical JSON evidence

platform/build mode、device/OS、renderer/Flutter/Engine/Dart/Scene revision、attested backend、frame/partial update/resume/app rebuild/exception counter、各capability status/provenanceを常時表示する。capabilityは人手で自由入力させず、runtime eventか固定checklistを完了したoperator attestationからだけ更新する。公開API不足の3 capabilityにはattestation control自体を表示しない。

- [ ] **Step 8: test、format、analyze、mobile buildを通す**

Run: `mise exec -- flutter test packages/eqmonitor_map/test/observability`

Expected: PASS.

Run: `mise exec -- dart format packages/eqmonitor_map`

Run: `mise exec -- dart analyze packages/eqmonitor_map`

Expected: no issues.

Run from `packages/eqmonitor_map/example`:

```bash
mise exec -- dart run ../tool/write_scene_spike_defines.dart
mise exec -- flutter build apk --profile --dart-define-from-file=.dart_tool/scene_spike_defines.json
mise exec -- flutter build apk --release --dart-define-from-file=.dart_tool/scene_spike_defines.json
mise exec -- flutter build ios --profile --no-codesign --dart-define-from-file=.dart_tool/scene_spike_defines.json
mise exec -- flutter build ios --release --no-codesign --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

Expected: Android artifacts compile on the implementation host; iOS commands compile on a macOS host with Xcode. A non-macOS host records iOS build as not run, never pass.

- [ ] **Step 9: commitする**

```bash
git add packages/eqmonitor_map
git commit -m "Spike: Scene描画とラベルoverlayを追加"
```

---

### Task 7: iOS/Android physical gate、文書、PR draft

**Files:**
- Modify: `packages/eqmonitor_map/README.md`
- Create: `packages/eqmonitor_map/example/evidence/README.md`
- Create when captured: `packages/eqmonitor_map/example/evidence/ios-profile.json`
- Create when captured: `packages/eqmonitor_map/example/evidence/ios-release.json`
- Create when captured: `packages/eqmonitor_map/example/evidence/android-profile.json`
- Create when captured: `packages/eqmonitor_map/example/evidence/android-release.json`
- Create: `docs/knowledge/20260802_eqmonitor_map_flutter_scene_device_gate.md`
- Modify: `docs/todo/800_eqmonitor_map_deferred_verification.md`
- Create: `docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md`
- Create: `packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart`
- Create: `packages/eqmonitor_map/test/tool/validate_scene_spike_evidence_test.dart`

**Interfaces:**
- Consumes: Task 6 exampleが出力するcanonical JSONとTask 5 gate evaluator。
- Produces: review可能な4 run evidence、明示的なpass/block decision、stack 02のPR本文下書き。

- [ ] **Step 1: evidence validation commandのfailing testを書く**

```dart
test('reports all required runs when evidence directory is empty', () async {
  final directory = await Directory.systemTemp.createTemp('scene-evidence-');
  addTearDown(() => directory.delete(recursive: true));
  final result = await validateSceneSpikeEvidence(directory: directory);
  expect(result.exitCode, 1);
  expect(result.decision.missingRuns, requiredSceneSpikeRunKeys);
});

test('returns canonical failure for malformed evidence JSON', () async {
  final directory = await Directory.systemTemp.createTemp('scene-evidence-');
  addTearDown(() => directory.delete(recursive: true));
  await File('${directory.path}/android-profile.json').writeAsString('{');
  final result = await validateSceneSpikeEvidence(directory: directory);
  expect(result.exitCode, 1);
  expect(result.decision.validationErrors, isNotEmpty);
  expect(jsonDecode(result.canonicalJson), isA<Map<String, dynamic>>());
});
```

Run: `mise exec -- flutter test packages/eqmonitor_map/test/tool/validate_scene_spike_evidence_test.dart`

Expected: FAIL because `validateSceneSpikeEvidence` is undefined.

- [ ] **Step 2: evidence validation commandを追加する**

`packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart`を作り、4 JSONを`SceneSpikeEvidence.fromJson`で読み、`SceneSpikeGate.evaluate`のcanonical JSONをstdoutへ出す。exit codeはpassなら0、missing/duplicate run、malformed JSON、unknown schema、invalid field、unobserved/failed capability、revision mismatchなら1にする。stdoutは成功・失敗とも1つのcanonical JSONだけとし、parse errorを例外stackのまま表示しない。

Run before evidence capture:

```bash
mise exec -- dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

Expected: FAIL and list all four missing run keys.

- [ ] **Step 3: physical iOS profile/release runを採取する**

Run on a physical iOS device from the example directory:

最初に`mise exec -- flutter devices`で物理iOS端末のdevice IDを確認して`physical_ios_device_id`へ設定し、空でないことを検証してから実行する。

```bash
test -n "$physical_ios_device_id"
mise exec -- dart run ../tool/write_scene_spike_defines.dart
mise exec -- flutter run --profile -d "$physical_ios_device_id" --dart-define-from-file=.dart_tool/scene_spike_defines.json
mise exec -- flutter run --release -d "$physical_ios_device_id" --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

各runで最低60秒のpartial update、portrait/landscape resize、background/foreground 3回、dispose/remount 3回を実行する。描画、overlay、DPR、例外、generation、memory挙動を確認し、copyしたJSONを対応evidence fileへそのまま保存する。

- [ ] **Step 4: physical Android profile/release runを採取する**

Run on a physical Android device:

最初に`mise exec -- flutter devices`で物理Android端末のdevice IDを確認して`physical_android_device_id`へ設定し、空でないことを検証してから実行する。

```bash
test -n "$physical_android_device_id"
mise exec -- dart run ../tool/write_scene_spike_defines.dart
mise exec -- flutter run --profile -d "$physical_android_device_id" --dart-define-from-file=.dart_tool/scene_spike_defines.json
mise exec -- flutter run --release -d "$physical_android_device_id" --dart-define-from-file=.dart_tool/scene_spike_defines.json
```

iOSと同じ操作に加え、Developer Optionsの`Don't keep activities`を有効にしてActivity recreationを3回行う。Vulkan backendを記録し、対象端末でGLES fallbackもsupport範囲なら別evidenceとして追加する。

- [ ] **Step 5: gate validatorを実行して結果を確定する**

Run:

```bash
mise exec -- dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
```

Expected pass case: exit 0、4 run key、全required capability、固定revisionが一致する。

Expected blocked case: exit 1で、特に公開APIだけでは証明できない`gpuCompletionOrSafeRetirement`、`contextResourceRebuild`、`explicitResourceDisposal`を具体的に列挙する。blocked caseでは空・架空・手編集のpass evidenceをcommitせず、`example/evidence/README.md`へ未実施/失敗と再現手順を記録してfoundationを止める。

- [ ] **Step 6: README、knowledge、deferred verificationを更新する**

READMEへ以下を記録する。

- exact Flutter/Flutter Scene revisions and bootstrap command
- adapter boundary and hot-path model exception
- harness run/capture/validate commands
- gate decision and unsupported public API surface
- `03-foundation`へ進める条件
- package follow-up list: Widget/golden/performance tests、HUD、PMTiles/MVT、declarative MapNode/Element、labels、3D/地下震源/断層

device knowledgeには端末/OS/backend/build mode、lifecycle操作、判明したFlutter Scene制約を再現command付きで残す。後続test項目は既存`docs/todo/800_eqmonitor_map_deferred_verification.md`へ重複なく追記する。

- [ ] **Step 7: stack 02 PR本文の下書きをファイルへ保存する**

PR draftは少なくとも次を含める。

```markdown
## Summary
## Stack
## Fixed revisions
## Device gate result
## Safety and fail-closed behavior
## Validation
## Known Flutter Scene API gaps
## Deferred work
```

Stack sectionはbaseが`codex/eqmonitor-map-01-design`であることを明記する。PR URLや作成済みという表現は書かない。

- [ ] **Step 8: branch全体を検証する**

Run:

```bash
mise exec -- dart format --output=none --set-exit-if-changed packages/eqmonitor_map
mise exec -- dart analyze packages/eqmonitor_map
mise exec -- flutter test packages/eqmonitor_map/test
mise exec -- dart run packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart
git diff --check codex/eqmonitor-map-01-design...HEAD
git --no-pager status --short
```

Expected: format/analyze/unit tests/diff check pass。evidence validatorはphysical gateが満たされた時だけpassする。満たされない場合はその非0をstackのblocking resultとしてREADME、knowledge、PR draftへ一致して記録する。

- [ ] **Step 9: commitしてstack branchをpushする**

```bash
git add packages/eqmonitor_map/README.md packages/eqmonitor_map/example/evidence packages/eqmonitor_map/tool packages/eqmonitor_map/test/tool docs/knowledge/20260802_eqmonitor_map_flutter_scene_device_gate.md docs/todo/800_eqmonitor_map_deferred_verification.md docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md
git commit -m "Docs: Scene実機gate結果を記録"
git push -u origin codex/eqmonitor-map-02-scene-spike
```

PRはこのTaskで作成しない。全stack完成後に、保存済みdraftを使ってまとめて作成する。
