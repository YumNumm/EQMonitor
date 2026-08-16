# Flutter Scene fork: StaticInstanceGeometry Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task.

**Goal:** Issue #1602 — Flutter Scene fork へ、静的 instance データを永続 GPU バッファへ一度だけ upload する汎用 Geometry と、その retirement API を追加する。

**Architecture:** `StaticInstanceGeometry` は `BillboardGeometry` と同じ構造（`Geometry` を直接継承し、instance-rate な slot 1 を自前で宣言し、`bindsModelTransformInstance => false`）を取るが、`bind` のたびに `instanceTransients.emplace` で転送する代わりに、**初回 `bind` で 1 度だけ** `gpu.DeviceBuffer` を確保して retained な `gpu.BufferView` を保持し、以後はそれを bind する。`retire()` はその参照を落とし、以後の `bind` を typed exception で fail closed にする。

**実装対象リポジトリ:** `YumNumm/flutter_scene`（fork）。作業ツリーは EQMonitor の submodule チェックアウト `third_party/flutter_scene`、ブランチは `feat/static-instance-geometry`（base は pin `7f71993b7e2a0ab1d2f59726a406098709be7291`）。**EQMonitor 本体のコードは本計画では変更しない**（#1602 の完了条件「EQMonitor は固定 commit 参照のみ」）。

## Global Constraints

- **PR / Issue は YumNumm org のみ。`gh pr create` では `--repo YumNumm/flutter_scene` を必ず明示する。** fork 配下では `gh` の既定送信先が upstream `bdero/flutter_scene` になるため、省略すると upstream へ飛ぶ。
- upstream (`bdero/flutter_scene`) との差分を最小に保つ。既存ファイルの変更は `lib/scene.dart` の export 追加のみとし、それ以外は新規ファイルで完結させる。`Geometry` 基底クラスには手を入れない。
- `gpu.BufferView` / `gpu.DeviceBuffer` / `gpu.gpuContext` は非公開型。公開シグネチャへ露出させない。呼び出し側が渡すのは `Float32List` / `Uint16List` / `VertexLayoutDescriptor`（いずれも公開）だけ。
- **GPU アクセスはコンストラクタで行わない。** fork のテストは GPU コンテキストなしで走る（`test/geometry_test.dart` の `_StubGeometry` 方式）。GPU を要する経路だけ `skip: 'Requires a GPU device.'` を付ける。upload を初回 `bind` へ遅延させることで、構築・検証・retire の全状態遷移を headless にテストできる状態を保つ。
- upload 完了後は CPU 側の `Float32List` 参照を落とす。200万 instance では CPU/GPU の二重保持が実メモリを圧迫するため。
- retirement は「参照を落として GC 対象にする」＋「以後 fail closed」まで。`gpu.DeviceBuffer` は `NativeFieldWrapperClass1` を継承するだけで `dispose()`/`destroy()` を持たないため、**決定的な GPU メモリ解放は約束できない**。doc に誇張して書かない。
- 上限や既定値を暗黙に埋めない。不正な引数は `ArgumentError`（assert ではなく release でも送出）。
- Dart / Flutter は `mise exec --` 経由。fork のフォーマットと lint は upstream の設定に従う（EQMonitor の `eqmonitor_lints` は適用しない）。
- 各タスクの本番+テストは 30–100 行目安。コミット prefix は英語1語+日本語1行。

## Baseline（fork に既にあるもの）

| 既存 | 役割 | 本 Issue での扱い |
|---|---|---|
| `Geometry`（`lib/src/geometry/geometry.dart:108`） | 基底。`bind` 抽象、`draw` 既定、layout フック | **変更しない**。継承のみ |
| `BillboardGeometry`（`lib/src/geometry/billboard_geometry.dart`） | slot 1 を instance-rate で自前宣言する既存例 | 構造の手本。`_kBillboardLayout`(L282)、`bindsModelTransformInstance => false`(L177)、`bind` の slot 1 バインド(L199) |
| `Geometry._uploadStreams`（`geometry.dart:364`） | `createDeviceBuffer` → `overwrite` → `flush` の一度きり upload | 同じ手順を instance バッファへ適用 |
| `instance_batching.dart:18` | batching は `instancedVertexLayout != null` を要求 | 満たす |
| `test/geometry_test.dart` の `_StubGeometry` | GPU なしで基底状態を検証する規約 | 踏襲 |

## Out of scope

- `InstancedMesh` / `BillboardGeometry` / `scene_encoder.dart` の既存経路の変更
- `GpuSubmissionTracker` の公開（GPU 完了待ちを含む retirement は採用しない）
- 球インポスターの Shader / 点・球 LOD（#1604 の範囲）
- EQMonitor 側の利用配線（#1603 以降）
- upstream への PR

---

### Task 1: `StaticInstanceGeometry` 本体とテスト

**Files:**
- Create: `lib/src/geometry/static_instance_geometry.dart`
- Create: `test/static_instance_geometry_test.dart`

**Interfaces:**

```dart
final class StaticInstanceGeometry extends Geometry {
  StaticInstanceGeometry({
    required Float32List vertices,
    required Float32List instanceData,
    required int instanceCount,
    required VertexLayoutDescriptor layout,
    Uint16List? indices,
  });

  int get instanceCount;
  bool get isRetired;
  void retire();
}
```

- コンストラクタは値を検証して保持するだけ。**GPU へ触らない。**
- 検証（すべて `ArgumentError`）: `instanceCount > 0`、`vertices` 非空、`instanceData.length` が `instanceCount` で割り切れる、`layout` が instance-rate な buffer descriptor を含む。
- 初回 `bind` で `vertices` / `indices` / `instanceData` を永続バッファへ upload し、保持していた `Float32List` / `Uint16List` 参照を落とす。2 回目以降は retained な `gpu.BufferView` を bind するだけで、`instanceTransients` を使わない。
- `draw` は `instanceCount` を既定にする。
- `bindsModelTransformInstance => false`（encoder の model-transform bind が slot を潰さないようにする。`BillboardGeometry:177` と同じ理由）。
- `defaultVertexLayout` は引数の `layout` を返す（batching 参加条件）。
- `retire()`: retained なバッファ参照と CPU 側参照を落とし、`isRetired` を `true` にする。冪等。
- `isRetired` が `true` のときの `bind` は `StateError`。空描画へ丸めない。

**テスト方針:** `test/geometry_test.dart` と同じく GPU なしで走る範囲を検証する。GPU を要するのは upload 経路のみなので、テストは構築・検証・retire の状態遷移に集中する。

- [ ] **Step 1: Write failing tests**（引数検証の各 `ArgumentError`、`instanceCount` の round-trip、`bindsModelTransformInstance == false`、`defaultVertexLayout` が渡した layout であること、`retire()` の冪等性、`isRetired` 後の `bind` が `StateError`、コンストラクタが GPU に触れないこと）
- [ ] **Step 2: Run RED** `(cd third_party/flutter_scene && mise exec -- flutter test test/static_instance_geometry_test.dart)`
- [ ] **Step 3: Implement**
- [ ] **Step 4: Run GREEN**（上記に加え `mise exec -- flutter test test/geometry_test.dart test/instance_batching_test.dart` で既存回帰なし）
- [ ] **Step 5: Commit** `feat: 静的 instance を永続バッファへ載せる Geometry を追加`

---

### Task 2: 公開 export と doc

**Files:**
- Modify: `lib/scene.dart`（`export 'src/geometry/static_instance_geometry.dart' show StaticInstanceGeometry;`）
- Modify: `lib/src/geometry/static_instance_geometry.dart`（class doc の追記）

**Interfaces:**
- Produces: `package:flutter_scene/scene.dart` から `StaticInstanceGeometry` だけが見える状態。`gpu.*` は露出しない。

**doc に必ず書くこと:**
- 何のための型か（大量の静的 instance を毎フレーム再パックせずに描く）
- upload が初回 `bind` で一度だけ起きること、以後 CPU 側コピーを保持しないこと
- `retire()` の意味は参照解放と fail closed であり、**GPU メモリ解放の時期は GC 依存で決定的ではない**こと
- fork のスタイルに合わせて `{@category Geometry}` を付ける

- [ ] **Step 1: Write failing export test**（`package:flutter_scene/scene.dart` だけを import して `StaticInstanceGeometry` を参照できること）
- [ ] **Step 2: Run RED**
- [ ] **Step 3: Implement export + doc**
- [ ] **Step 4: Run GREEN** `(cd third_party/flutter_scene && mise exec -- flutter test)` で fork の全 85 テストが green
- [ ] **Step 5: Commit** `feat: StaticInstanceGeometry を公開 API へ追加`

---

### Task 3: fork PR と EQMonitor 側の pin 更新

**Files:**
- Modify: `third_party/flutter_scene`（submodule commit を新 SHA へ）
- Modify: `docs/knowledge/20260802_flutter_scene_scene_source_pin.md`（pin 更新手順の実績を追記）

- [ ] **Step 1:** fork へ push し、**`gh pr create --repo YumNumm/flutter_scene --base master`** で PR を作る
- [ ] **Step 2:** EQMonitor 側で submodule を新 SHA へ進め、`mise exec -- flutter pub get` で lockfile を更新
- [ ] **Step 3:** `(cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene)` で EQMonitor 側の回帰なしを確認
- [ ] **Step 4:** EQMonitor 側の PR を `--repo YumNumm/EQMonitor --base develop` で作る
- [ ] **Step 5:** Issue #1602 の完了条件（fork 側 test + API review / EQMonitor は固定 commit 参照のみ）を確認

## Completion Checklist

- [ ] 標準 `InstancedMesh` / 毎フレーム転送 `BillboardGeometry` を使わずに静的 instance を描ける型がある
- [ ] instance データの upload が一度だけであることがコードから読み取れる
- [ ] retirement API が公開され、意味づけが誇張なく doc に書かれている
- [ ] EQMonitor は fork の公開 API だけを使い、`src/` を import しない
- [ ] fork の全テストが green
- [ ] EQMonitor は固定 commit を参照するだけ

## References

- Issue: #1602 / parent #1612
- Design: `docs/superpowers/specs/2026-08-02-seismicity-flutter-scene-design.md`（「採用方式 > 描画」節）
- Knowledge: `docs/knowledge/20260802_flutter_scene_large_static_instances.md`
- pin 運用: `docs/knowledge/20260802_flutter_scene_scene_source_pin.md`
