# Estimated Intensity Flutter GPU Map Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> superpowers:subagent-driven-development (recommended) or
> superpowers:executing-plans to implement this plan task-by-task. Steps use
> checkbox (`- [ ]`) syntax for tracking.

**Goal:** event `20260823020050` を最初のproduction data検証対象として、
API が返す
immutable descriptor から検証済み PMTiles を取得し、Flutter Scene / Flutter GPU の
デバッグ地図へ推計震度 Fill / Line と同一 event の震源を原子的に表示する。

**Architecture:** backend は URL・exact size・SHA-256 を一体化した immutable descriptor
を公開する。app は URL と response を fail closed で検証し、archive 全体の size / hash /
PMTiles header を確認した local lease だけを package へ渡す。package は base map と独立した
exact-cover pipeline で strict MVT decode を行い、visible cover が完全な場合だけ Fill / Line
pair を Scene frame へ publish する。observed と estimated は full display candidate 単位で排他し、
estimated candidate は同一 event の震源 sprite を含む。

**Tech Stack:** TypeScript backend/OpenAPI（P0、current source audit 後）、Dart/Flutter、
Riverpod、Freezed、`eqmonitor_api` generator、PMTiles v3、MVT、Flutter Scene、Flutter GPU、
`package:test` / `flutter_test`。

**Design reference:**
`docs/superpowers/specs/2026-08-25-estimated-intensity-flutter-gpu-map-design.md`

## Execution Rules

- Flutter / Dart command は必ず `mise exec --` 経由で実行する。
- production code に event `20260823020050` の URL、size、SHA-256 を埋め込まない。event ID は
  fixture、debug input、runtime verification input に限る。
- legacy `estimated_intensity_tile` から descriptor を合成せず、新 field 欠落時は fail closed にする。
- Task 7 / 8 の既存 worktree を再利用・変更しない。各 PR は直前 branch から新しい worktree を作る。
- 1 commit はおおむね30〜100行に保つ。生成物や機械的 fixture 更新は、対応する contract commit
  へまとめてもよい。
- commit message は英語1単語 prefix + 簡潔な日本語説明にする。
- PR / Issue は YumNumm org にだけ作成する。`gh pr create` / `gh issue create` では必ず
  `--repo YumNumm/EQMonitor` または `--repo YumNumm/eqmonitor-backend` を明示する。
- EQMonitor のstack rootだけを`develop`に置く。この推計震度stackは既存GPU map stack上へ続けるため、
  P1以降のPR baseは必ず直前branchにする。
- 各 PR は RED の失敗理由、GREEN の成功出力、focused analyze、diff review を PR 本文へ記録する。
- MapLibre layer はこの stack で削除しない。

## Stack and Dependency Order

P0 は別 repository の backend prerequisite で、EQMonitor の gh-stack には含めない。backend の
default branch、ownership、test script は source audit 前に決め打ちしない。P0 が merge され、
EQMonitor の `backend` submodule がその contract commit を参照できる状態になり、既存GPU map stackの
`codex/gpu-map-13-estimated-intensity-spec`がreadyになってから P1 を開始する。

| PR | Repository / branch | Base | Public outcome |
| --- | --- | --- | --- |
| S0 | `YumNumm/EQMonitor` / `codex/gpu-map-13-estimated-intensity-spec` | `codex/gpu-map-12-debug-ui` | approved design and implementation plan |
| P0 | `YumNumm/eqmonitor-backend` / audit 後に命名 | backend の live default branch | immutable descriptor と event fixture |
| P1 | `YumNumm/EQMonitor` / `codex/gpu-map-14-estimated-api-client` | `codex/gpu-map-13-estimated-intensity-spec` | generated Dart contract |
| P2 | `codex/gpu-map-15-estimated-source-contract` | P1 branch | app validator と純粋 model |
| P3 | `codex/gpu-map-16-estimated-download` | P2 branch | verified download / lease repository |
| P4 | `codex/gpu-map-17-estimated-pmtiles` | P3 branch | independent exact PMTiles source |
| P5 | `codex/gpu-map-18-estimated-mvt` | P4 branch | strict estimated MVT decoder |
| P6 | `codex/gpu-map-19-estimated-renderer` | P5 branch | typed Fill / Line renderer |
| P7 | `codex/gpu-map-20-estimated-pipeline` | P6 branch | coverage / generation / publication barrier |
| P8 | `codex/gpu-map-21-estimated-app` | P7 branch | atomic app/debug-map integration |
| P9 | `codex/gpu-map-22-estimated-runtime` | P8 branch | event fixture、lifecycle、iOS / Android実機検証 |

S0はdocsだけを持ち、branch 12へのrebaseとreview完了後に既存Stack #1756へlinkする。P1〜P9は
その上へ順にreview / mergeする。上位branchのsyncは直前baseのmerge後に行い、
unrelated `develop` の取り込みと feature commit を同じ commit に混ぜない。

## P0: Publish the Backend Immutable Archive Descriptor

P0 は backend repository の現在 source を未監査である。この task の最初の成果物は file ownership と
実行コマンドの確認であり、次の Files 欄にない backend 実装 path や job 名を推測して変更しない。

**Files:**

- Inspect: backend repository の `AGENTS.md`、package manager manifest、default branch
- Inspect: `estimated_intensity_tile` / `estimated_intensity_key` / `ixac41` / `pmtiles` の owner
- Modify: audit で特定した OpenAPI schema source、REST serializer、realtime serializer、archive publisher
- Modify: audit で特定した contract fixture generator と tests
- Generated consumer outputs: `api/api/openapi.json`
- Generated consumer outputs: `api/api-stub/generated/contract-fixtures/**`

### P0.1 Audit before edit

- [ ] backend repository の clean worktree を作り、default branch と project instructions を確認する。

```bash
git remote -v
git status --short
gh repo view YumNumm/eqmonitor-backend --json defaultBranchRef
rg -n "estimated_intensity_tile|estimated_intensity_key|ixac41|pmtiles" api service packages
rg -n "openapi|contract-fixture|realtime" api service packages
rg -n '"scripts"|packageManager|pnpm|bun|npm' package.json pnpm-workspace.yaml bun.lock package-lock.json
```

- [ ] schema owner、archive writer、object-key builder、response handler、realtime producer、fixture generator、
  test runner を監査メモへ列挙する。
- [ ] package script に存在しない command を実行計画へ追加しない。

**Verification:** immutable object key が現在どう作られ、REST と realtime がどの record を読むかを
同じ event まで追跡できること。追跡できない場合は P0 を止め、backend-local design review を行う。

### P0.2 RED: lock the public contract

- [ ] audit で特定した schema/serializer test に、descriptor がない現実装では失敗する assertion を追加する。
- [ ] event `20260823020050` の fixture に、legacy URL と並べて次の shape を要求する。

```json
{
  "estimated_intensity_tile_archive": {
    "url": "https://<allowed-host>/ixac41/20260823020050/<sha256>.pmtiles",
    "size_bytes": "<exact-positive-byte-count>",
    "sha256": "<sha256>"
  }
}
```

上は field 関係を示す schema notation で、copyable fixture JSON ではない。実 fixture では publisher が
出した数値型の exact size と、archive bytes から得た有効な64文字 lowercase hex SHA-256を使う。URL末尾の
digestと`sha256` fieldを完全一致させる。

- [ ] P0.1 で確認した最小 test script を実行する。

```bash
# P0.1 で確認した package manager の test scriptを、引数を変えずに実行する。
# 期待結果: descriptor field または fixture assertion が未実装のため FAIL。
```

**RED verification:** failure が新しい descriptor assertion に限定され、既存 unrelated test failure では
ないこと。

### P0.3 GREEN: publish one immutable identity

- [ ] reusable descriptor schema を追加し、`Earthquake` と `EarthquakePartial` が同じ型を参照する。
- [ ] publisher が archive bytes の exact size と lowercase SHA-256 を確定してから immutable object key
  `/ixac41/{eventId}/{sha256}.pmtiles` を publish する。
- [ ] URL は redirect endpoint ではなく bytes を直接返し、content change 時は URL も変える。
- [ ] REST detail/list が URL、size、SHA-256 を同一 database/storage record から組み立てる。
- [ ] legacy `estimated_intensity_tile` は MapLibre migration のため残す。
- [ ] realtime key は immutable path identity を含め、client が REST descriptor と照合できるようにする。
- [ ] size が0、digest不正、object未確定、または descriptor record と object metadata が不一致なら
  descriptor を出さない。非content-addressedなlegacy URLとの差はdescriptor trust判定に使わない。
- [ ] event fixture と OpenAPI artifact を regeneration する。
- [ ] P0.1 で確認した focused test、typecheck、OpenAPI drift check を実行する。

**GREEN verification:** event fixture の URL path digest、`sha256`、実 archive digest が一致し、実 byte size が
`size_bytes` と一致すること。descriptor URL に対する HEAD/GET semantics と redirect 無しを integration test
で確認する。

**Commit sequence:**

1. `test: 推計震度archive descriptor契約を固定`
2. `feat: 推計震度archive descriptorを公開`
3. `test: 推計震度event fixtureを追加`

**PR verification:** GitHub 操作前に backend の live default branch を再確認し、PR は
`gh pr create --repo YumNumm/eqmonitor-backend` を明示する。P0 が merge されるまで P1 の generated
artifact を手編集しない。

## P1: Synchronize the Generated API Client

**Files:**

- Modify: `backend` gitlink
- Regenerate ignored transient input: `packages/eqmonitor_api/openapi/openapi.json`
- Modify: generator が列挙した `packages/eqmonitor_api/lib/src/models/**`
- Modify: generator が同期する `packages/eqmonitor_api/test/fixtures/contract/**`
- Verify: `packages/eqmonitor_api/test/contract_drift_test.dart`
- Create: `packages/eqmonitor_api/test/generated_contract_fixture_test.dart`

### P1.1 RED

- [ ] P0 merge commit を `backend` submodule へ checkoutする。既存`contract_drift_test.dart`はbackend sourceを
  直接比較しないため、このgitlink更新だけでREDになるとはみなさない。
- [ ] `generated_contract_fixture_test.dart`へdescriptor JSONのdecodeと生成modelの
  `estimatedIntensityTileArchive` property accessを追加し、generator実行前のmodelでcompile failureになることを
  確認する。descriptor値はtest内の有効なschema fixtureで、production treeへ置かない。

```bash
cd packages/eqmonitor_api
mise exec -- dart test test/generated_contract_fixture_test.dart
```

**Expected:** generated Dart modelに新field/typeがなく、新property accessでcompile failure。

### P1.2 GREEN

- [ ] repository の generator だけを使い、OpenAPI、Dart model、Freezed/JSON、contract fixture を同期する。

```bash
cd packages/eqmonitor_api
mise exec -- dart run bin/generate.dart
mise exec -- dart format lib test
mise exec -- dart test test/contract_drift_test.dart
mise exec -- dart test test/generated_contract_fixture_test.dart
mise exec -- dart analyze
```

- [ ] `Earthquake` と `EarthquakePartial` が同じ generated descriptor model を nullable field として持つことを
  diff で確認する。
- [ ] generatorが同期したevent `20260823020050` fixtureを同testでdecodeし、URL path digest、positive size、
  lowercase SHA-256の関係を確認する。
- [ ] legacy field が消えていないことを fixture decode test で固定する。

**Commit sequence:**

1. `test: 推計震度descriptor contract fixtureを固定`
2. `gen: 推計震度descriptor API clientを同期`

**Verification:**

```bash
git --no-pager diff --check
git status --short
```

P1 の PR は
`gh pr create --repo YumNumm/EQMonitor --base codex/gpu-map-13-estimated-intensity-spec`
を使う。

## P2: Validate the Descriptor at the App Boundary

**Files:**

- Create: `app/lib/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart`
- Create: `app/lib/feature/earthquake_history/data/logic/estimated_intensity_archive_descriptor_validator.dart`
- Create: `app/lib/feature/earthquake_history/data/model/estimated_intensity_archive_failure.dart`
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake.dart`
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_partial.dart`
- Modify: auditで特定した realtime earthquake mapper / notifier / detail refetch owner
- Create: `app/test/feature/earthquake_history/data/estimated_intensity_archive_descriptor_validator_test.dart`
- Modify: `app/test/feature/earthquake_history/earthquake_model_test.dart`
- Modify: `app/test/feature/earthquake_history/data/earthquake_partial_converter_test.dart`
- Create: auditで特定した realtime key / detail refetch generation test

### P2.1 RED

- [ ] table-driven validator test を追加し、valid descriptor と全拒否条件を固定する。

Cases: non-HTTPS、userinfo、query、fragment、non-default port、allowlist外host、suffix spoof、二重slash、
trailing slash、dot segment、encoded slash、wrong event、invalid event ID、uppercase/short hash、URL/field
hash mismatch、size 0、negative、caller cap超過。

```bash
cd app
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_descriptor_validator_test.dart
```

**Expected:** validator/model 未実装で compile FAIL。

- [ ] converter test で new descriptor の正常変換、null、legacy-onlyを固定する。legacy URLが異なる
  pathでもdescriptor自身がvalidなら結果が変わらないことを固定する。
- [ ] realtime key受信後、detail refetchが同じevent/generation/immutable pathを返すまでsource candidateを
  作らず、stale responseとkey mismatchを拒否するtestを追加する。

### P2.2 GREEN

- [ ] `EstimatedIntensityArchiveDescriptor` は `eventId`、canonical `Uri`、`sizeBytes`、`sha256` を持つ
  package-neutral immutable value にする。
- [ ] `EstimatedIntensityArchiveUrlPolicy` は exact `allowedHosts` と `maxArchiveBytes` を caller 必須にする。
- [ ] validator は raw URL semantics を canonicalization 前後で照合し、decoded path 3 segments と event/hash
  equality を検証する。
- [ ] converter は generated API descriptor を pure validator input へ写し、failure を typed value で返す。
- [ ] legacy-only では descriptor を作らず、legacy URL から size/hash を推測しない。
- [ ] realtime mapper/notifierはkeyをtrust inputへ直接変換せず、request generation付きdetail refetchを行う。
  同じevent/generation/pathを確認したREST descriptorだけをdownload requestへ進める。
- [ ] app model の full URL/hash を `toString` や user-facing error に含めない。

```bash
cd app
mise exec -- dart format lib/feature/earthquake_history test/feature/earthquake_history
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_descriptor_validator_test.dart
mise exec -- flutter test test/feature/earthquake_history/earthquake_model_test.dart
mise exec -- flutter test test/feature/earthquake_history/data/earthquake_partial_converter_test.dart
mise exec -- flutter analyze lib/feature/earthquake_history test/feature/earthquake_history
```

**Commit sequence:**

1. `test: 推計震度descriptor検証境界を固定`
2. `feat: 推計震度descriptor validatorを追加`
3. `feat: 地震modelへ検証済みdescriptorを接続`

**Verification:** malformed descriptor はすべて fail closed、valid descriptor だけが download request へ進める。

## P3: Download, Verify, and Lease the Archive

**Files:**

- Create: `app/lib/feature/earthquake_history/data/repository/estimated_intensity_archive_repository.dart`
- Create: `app/lib/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart`
- Create: `app/lib/feature/earthquake_history/data/model/estimated_intensity_archive_lease.dart`
- Create: `app/lib/feature/earthquake_history/data/model/estimated_intensity_archive_limits.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/estimated_intensity_archive_repository_provider.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/estimated_intensity_archive_repository_provider.g.dart`
- Create: `app/test/feature/earthquake_history/data/estimated_intensity_archive_repository_test.dart`
- Create: `app/test/feature/earthquake_history/data/estimated_intensity_archive_http_data_source_test.dart`

### P3.1 RED

- [ ] injected transport と temporary directory を使う test を追加する。
- [ ] 200/identity/exact length/exact SHA の success と、3xx、non-200、content-encoding、declared length mismatch、
  short/long/no-length body、stream cap、SHA mismatch、cancel、timeout、late completion を固定する。
- [ ] real `HttpClient` transport testで`autoUncompress=false`を固定し、gzip等のbodyが自動展開されて
  header/size/hash検査を通過しないことを確認する。
- [ ] coalescing、active lease pin、LRU、count/byte cap、all-leased failure、`.part` cleanup を固定する。

```bash
cd app
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_http_data_source_test.dart
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_repository_test.dart
```

**Expected:** repository/data source 未実装で compile FAIL。

### P3.2 GREEN

- [ ] `HttpClient.autoUncompress=false`、redirects disabled、status 200 only、
  `Accept-Encoding: identity` の transport を実装し、bodyを読む前にstatus/headerを検査する。
- [ ] response body を unique `.part` へ streaming write し、descriptor size と caller cap の小さい方を超えた
  時点で cancel する。
- [ ] EOF 後に exact byte count と SHA-256 を検証し、成功前に verified file を publish しない。
- [ ] destination は `estimated-intensity/{eventId}/{sha256}.pmtiles` とし、同一 filesystem 上で atomic rename する。
- [ ] 同一 content identity の concurrent request を coalesce し、open consumer ごとに lease を返す。
- [ ] source switch/dispose 後に close を await して lease を release し、unleased file だけを LRU eviction する。
- [ ] temp path、URL、hash、response body、raw exception を利用者向け error/logへ出さない。

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/feature/earthquake_history test/feature/earthquake_history
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_http_data_source_test.dart
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_archive_repository_test.dart
mise exec -- flutter analyze lib/feature/earthquake_history test/feature/earthquake_history
```

**Commit sequence:**

1. `test: 推計震度archive transport制約を固定`
2. `feat: 推計震度archiveをstream検証`
3. `test: 推計震度archive lease制約を固定`
4. `feat: 検証済みarchive leaseを管理`

**Verification:** failure/cancel/supersede 後に verified source が発行されず、`.part` と lease count が残らない。

## P4: Build an Independent Exact PMTiles Source

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_pmtiles_source.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_tile_repository.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_exact_tile_cache.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_tile_cover_planner.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `packages/eqmonitor_map/test/support/minimal_pmtiles_archive_builder.dart`
- Create: `packages/eqmonitor_map/test/source/estimated_intensity_pmtiles_source_test.dart`
- Create: `packages/eqmonitor_map/test/tile/estimated_intensity_tile_cover_planner_test.dart`
- Create: `packages/eqmonitor_map/test/tile/estimated_intensity_exact_tile_cache_test.dart`

### P4.1 RED

- [ ] minimal PMTiles fixtures で v3/MVT/gzip/min0/max14 と synthetic min5/max14/bounds を受理し、wrong
  version/type/compression/zoom/bounds を拒否する test を追加する。
- [ ] event-shape min0 fixtureはz0/z14をexact、z15をcanonical z14 + overscaledZ15とする。synthetic
  min5 fixtureはz0でtile request 0 + `belowSourceMinZoom`、z5 exactとし、bounds外/absent entryは
  authoritative emptyへ固定する。
- [ ] visible canonical count cap 超過は partial cover ではなく full failure になることを固定する。

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/source/estimated_intensity_pmtiles_source_test.dart
mise exec -- flutter test test/tile/estimated_intensity_tile_cover_planner_test.dart
mise exec -- flutter test test/tile/estimated_intensity_exact_tile_cache_test.dart
```

**Expected:** source/planner/cache 未実装で compile FAIL。

### P4.2 GREEN

- [ ] app が検証した `VerifiedPmTilesSource` だけを受け取り、file random-access reader と header snapshot を開く。
- [ ] base source と repository/cache/scheduler/coverage/generation を共有しない event source を作る。
- [ ] `camera.floorZoom < minZoom` を cover calculator 呼び出し前に判定し、min zoom tileへ clampしない。
- [ ] max zoom 超過だけ visual transform の overscale を許し、canonical lookup は max zoom に固定する。
- [ ] exact cache は parent/child fallback を持たず、ready/authoritative empty/failure を区別する。
- [ ] boundsとworld wrapを考慮して canonical lookupをdeduplicateし、render transformはunwrapped tileを保持する。

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib test
mise exec -- flutter test test/source/estimated_intensity_pmtiles_source_test.dart
mise exec -- flutter test test/tile/estimated_intensity_tile_cover_planner_test.dart
mise exec -- flutter test test/tile/estimated_intensity_exact_tile_cache_test.dart
mise exec -- flutter analyze
```

**Commit sequence:**

1. `test: 推計震度PMTiles header制約を固定`
2. `feat: 推計震度PMTiles event sourceを追加`
3. `test: 推計震度exact cover制約を固定`
4. `feat: 推計震度exact tile pipelineを追加`

**Verification:** min0 fixtureはz0を読み、synthetic min5 fixtureはz0 request 0、どちらもz14超で異なる
canonical sourceを読まない。

## P5: Decode Only the Estimated-intensity MVT Schema

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_class.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_tile_geometry.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/estimated_intensity_tile_decoder.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/mvt/polygon_boundary_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `packages/eqmonitor_map/test/tile/mvt/support/mvt_fixture_builder.dart`
- Create: `packages/eqmonitor_map/test/tile/estimated_intensity_tile_decoder_test.dart`
- Create: `packages/eqmonitor_map/test/tile/mvt/polygon_boundary_builder_test.dart`

### P5.1 RED

- [ ] `seismic_intensity` Polygon + `name` の6 classを accepted tableで固定する。
- [ ] source layer missing、wrong case、Point/LineString、missing/non-string name、unknown class、duplicate conflicting
  property、invalid ring、MVT limit超過は tile全体 invalid になる test を追加する。
- [ ] required layer present + feature zero は authoritative empty、directory absent は repository authoritative empty と
  別 result になることを固定する。
- [ ] Polygon ringからclosed LineMeshを作る共有 helperの winding/closure testを追加する。

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/tile/estimated_intensity_tile_decoder_test.dart
mise exec -- flutter test test/tile/mvt/polygon_boundary_builder_test.dart
```

**Expected:** decoder/helper 未実装で compile FAIL。

### P5.2 GREEN

- [ ] enum/parser は exact class string だけを受理し、近似、default、tile `fill` property fallback を持たない。
- [ ] layer内に1 featureでもinvalidがあれば既知featureもpublishせずtyped schema failureを返す。
- [ ] Fill geometryとboundary Line geometryをclassごとに返し、theme/colorをdecoderへ渡さない。
- [ ] base decoderのprivate polygon boundary logicをpackage-neutral helperへ移し、両decoderで同じ閉路規則を使う。
- [ ] existing `MvtDecodeLimits` と caller mesh limitsを全pathで適用する。

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib test
mise exec -- flutter test test/tile/estimated_intensity_tile_decoder_test.dart
mise exec -- flutter test test/tile/mvt/polygon_boundary_builder_test.dart
mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart
mise exec -- flutter analyze
```

**Commit sequence:**

1. `test: 推計震度MVT schemaを固定`
2. `refactor: polygon境界mesh生成を共通化`
3. `feat: 推計震度MVT decoderを追加`

**Verification:** unknown classを含むtileでFill/Lineが1件も生成されず、既知6 classはgeometryのみを返す。

## P6: Add Typed Fill and Line Rendering

**Files:**

- Create: `packages/eqmonitor_map/lib/src/renderer/estimated_intensity_render_resources.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/estimated_intensity_render_submission_builder.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/estimated_intensity_packed_mesh_cache.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/map_scene_frame_submission.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/map_scene_render_phase_policy.dart`
- Modify: `packages/eqmonitor_map/lib/src/foundation/map_scene.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/estimated_intensity_material_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_base_map_adapter.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `packages/eqmonitor_map/test/renderer/estimated_intensity_render_submission_builder_test.dart`
- Create: `packages/eqmonitor_map/test/renderer/estimated_intensity_packed_mesh_cache_test.dart`
- Create: `packages/eqmonitor_map/test/renderer/map_scene_frame_submission_test.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_base_map_adapter_test.dart`

### P6.1 RED

- [ ] `estimatedIntensityFill` / `estimatedIntensityLine` kindとcomponent key、hazard underlay phaseを固定する。
- [ ] Fill/Line pair、同一 version stamp、同一 event/source identity、行政境界線より下をvalidator testへ追加する。
- [ ] observed region/city、station、estimated pairの違法共存をScene mutation前に拒否するtestを追加する。
- [ ] class色、opacity 1、Line width 0.5 logical pixel、既存fmat ABIをparameter testで固定する。

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/renderer/estimated_intensity_render_submission_builder_test.dart
mise exec -- flutter test test/flutter_scene/flutter_scene_base_map_adapter_test.dart
```

**Expected:** typed kind/component/material 未実装で compile または validation FAIL。

### P6.2 GREEN

- [ ] Fill / Line packed mesh layoutとfmat ABIは既存実装を再利用し、semantic key/material ownerはestimated専用にする。
- [ ] classごとのimmutable render styleをsubmission builderへ渡し、全class色が揃わない場合はcandidateを拒否する。
- [ ] Fill/Lineは `mapSceneEarthquakeHistorySourceKey` を使い、hypocenterとのversion混在を検知可能にする。
- [ ] preflight後にだけScene node/materialをcommitし、partial pairを一度もvisibleにしない。
- [ ] failure/retirementがbase map、observed overlay、hypocenter atlasのresourceを解放しないようownerを分離する。

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib test
mise exec -- flutter test test/renderer/estimated_intensity_render_submission_builder_test.dart
mise exec -- flutter test test/renderer/estimated_intensity_packed_mesh_cache_test.dart
mise exec -- flutter test test/flutter_scene/flutter_scene_base_map_adapter_test.dart
mise exec -- flutter test test/renderer/map_scene_frame_submission_test.dart
mise exec -- flutter analyze
```

**Commit sequence:**

1. `test: 推計震度Scene taxonomyを固定`
2. `feat: 推計震度Fill Line submissionを追加`
3. `feat: 推計震度material lifecycleを追加`

**Verification:** valid pairのphase順が base polygon → estimated Fill → estimated Line → administrative line、
invalid pairではScene mutation countが0。

## P7: Enforce Coverage and Generation Ownership

**Files:**

- Create: `packages/eqmonitor_map/lib/src/overlay/estimated_intensity_source_snapshot.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/estimated_intensity_coverage.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/estimated_intensity_source_controller.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/estimated_intensity_frame_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `packages/eqmonitor_map/test/overlay/estimated_intensity_source_controller_test.dart`
- Create: `packages/eqmonitor_map/test/overlay/estimated_intensity_coverage_test.dart`
- Create: `packages/eqmonitor_map/test/renderer/estimated_intensity_frame_builder_test.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_view_test.dart`

### P7.1 RED

- [ ] visible canonical tileが全てready/authoritative emptyになるまでpacket 0であることを固定する。
- [ ] pending 1件、schema/decode/source/resource failure 1件、cover cap超過でpartial publishしないことを固定する。
- [ ] event A→B、same event hash change、viewport cover change、dispose、background、context recreation後のlate completionを
  cache put/coverage/Scene commitの各境界で拒否するtestを追加する。
- [ ] same canonical cover内のpan/fractional zoomとtheme-only changeはdecode generation/data identityを変えないことを固定する。

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/overlay/estimated_intensity_source_controller_test.dart
mise exec -- flutter test test/overlay/estimated_intensity_coverage_test.dart
mise exec -- flutter test test/renderer/estimated_intensity_frame_builder_test.dart
```

**Expected:** coverage/controller/frame builder 未実装で compile FAIL。

### P7.2 GREEN

- [ ] coverage stateをhidden/loading/complete/authoritative empty/below min/invalid/source failure/resource limit/
  suspendedへtyped化し、countsをbounded diagnosticとして保持する。
- [ ] source/data/render/context generationを別ownerで管理し、async completionごとにcurrent tokenを検証する。
- [ ] content identity `estimated:{eventId}:{verifiedSha256}` をsource identityとdata digestへ入れる。
- [ ] theme-only changeはrender digestだけを進め、geometryをdecode/repackしない。
- [ ] source switch時はold estimated Fill/Lineを即時clearし、new full cover complete前にold viewportを出さない。
- [ ] backgroundでdownload/decode/upload/frameを止め、foregroundでdescriptor/lease/file/header/coverを再評価する。
- [ ] context recreation後はCPU verified geometryだけを再利用し、old GPU resourcesを再利用しない。

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib test
mise exec -- flutter test test/overlay/estimated_intensity_source_controller_test.dart
mise exec -- flutter test test/overlay/estimated_intensity_coverage_test.dart
mise exec -- flutter test test/renderer/estimated_intensity_frame_builder_test.dart
mise exec -- flutter test test/widget/base_map_view_test.dart
mise exec -- flutter analyze
```

**Commit sequence:**

1. `test: 推計震度coverage barrierを固定`
2. `feat: 推計震度source generationを管理`
3. `feat: 推計震度frame publicationを原子化`

**Verification:** source/mode/lifecycle switchを各100回繰り返し、late commit、negative lease、double retireが0。

## P8: Integrate Atomic Display Mode into the Debug Map

**Files:**

- Create: `app/lib/feature/earthquake_history/data/model/earthquake_map_display_candidate.dart`
- Create: `app/lib/feature/earthquake_history/data/logic/estimated_intensity_map_candidate_builder.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/estimated_intensity_map_candidate_provider.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/estimated_intensity_map_candidate_provider.g.dart`
- Create: `app/lib/feature/earthquake_history/data/logic/estimated_intensity_map_digest_builder.dart`
- Modify: `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Create: `app/test/feature/earthquake_history/data/estimated_intensity_map_candidate_builder_test.dart`
- Create: `app/test/feature/earthquake_history/data/earthquake_map_display_candidate_test.dart`
- Modify: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_configuration_test.dart`

### P8.1 RED

- [ ] observed candidateはregion/city/station、estimated candidateはFill/Line sourceとsame-event hypocenterだけを持つtestを追加する。
- [ ] mode switch中にobservedとestimatedが共存せず、descriptor loading/errorでもobservedへのsilent fallbackがないことを固定する。
- [ ] different-event hypocenter、version mismatch、legacy-only descriptor、invalid descriptorを拒否する。
- [ ] descriptor未検証中はestimated full candidateを作らず、同event震源だけを
  `base+hypocenter:<eventId>:<requestGeneration>` candidateとして表示する。verification成功時にだけ
  `estimated:<eventId>:<verifiedSha>`へFill/Line/hypocenterを原子的に昇格するtestを追加する。
- [ ] realtime key受信後のdetail refetchでgeneration/pathが一致するまでcandidateを作らず、stale応答を
  Scene commitしないことを固定する。
- [ ] debug state文言とdiagnostic redactionをpure model testで固定する。

```bash
cd app
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_map_candidate_builder_test.dart
mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_display_candidate_test.dart
mise exec -- flutter test test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_configuration_test.dart
```

**Expected:** display candidate/provider 未実装で compile FAIL。

### P8.2 GREEN

- [ ] sealed full display candidateを導入し、one-event one-modeをbuilder/provider境界で強制する。
- [ ] estimated candidateへverified source snapshot、class theme、same-event hypocenter sprite、共通version stampを渡す。
- [ ] archive未検証中はbase+hypocenter-only candidateを使い、estimated full candidateのidentity/stampを
  捏造しない。verified archive publication時にだけfull candidateへ切り替える。
- [ ] `EstimatedIntensityColors` の6 classをrender styleへ明示変換し、unknown/default branchを持たない。
- [ ] debug pageはevent ID入力からAPI detailを取得し、URL/hash/sizeをproduction定数へ持たない。
- [ ] UIは準備中/表示中/below min/表示不可の短い文言だけを出し、raw URL/hash/path/exceptionを出さない。
- [ ] diagnostic panelは分類値とcountだけを表示し、full identityをredactする。
- [ ] provider dispose/mode switchをawait可能なclose flowへ接続し、active leaseをreleaseする。

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/feature/earthquake_history lib/feature/settings test/feature/earthquake_history test/feature/settings
mise exec -- flutter test test/feature/earthquake_history/data/estimated_intensity_map_candidate_builder_test.dart
mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_display_candidate_test.dart
mise exec -- flutter test test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_configuration_test.dart
mise exec -- flutter analyze lib/feature/earthquake_history lib/feature/settings
```

**Commit sequence:**

1. `test: 地震map display mode排他を固定`
2. `feat: 推計震度full candidateを追加`
3. `feat: デバッグ地図へ推計震度を接続`

**Verification:** event ID入力だけで descriptor pathが開始され、legacy-only/error/loading時に観測Fill/stationや旧estimated
geometryが表示されない。同一eventの震源はbase+hypocenter-only stampで表示され、archive verification成功時だけ
Fill/Lineと同じestimated full candidate stampへ切り替わる。

## P9: Pin the Event Fixture and Pass Runtime Gates

**Files:**

- Create: `packages/eqmonitor_map/test/fixtures/estimated_intensity/20260823020050_manifest.json`
- Create: `packages/eqmonitor_map/test/integration/estimated_intensity_event_fixture_test.dart`
- Create: `packages/eqmonitor_map/test/integration/estimated_intensity_lifecycle_test.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/estimated_intensity_runtime_configuration_test.dart`
- Modify after runtime discovery: `docs/knowledge/20260825_estimated_intensity_archive_identity.md`

manifest は actual archive bytes を repositoryへ固定埋め込みするものではない。通常CIでは同じschemaと
identity関係を持つrepository内deterministic archive fixtureを使う。API contract fixtureが指すactual bytesとの
照合は、credential付きの明示的opt-in integration laneでP3 trust boundaryを通して実行する。

### P9.1 RED

- [ ] hermetic event manifest testを追加し、deterministic fixtureのevent/URL digest/SHA/sizeとverified source
  identityの一致を要求する。
- [ ] content-addressed event archiveにPMTiles v3/MVT/gzip/min0/max14、representative canonical tiles、
  class 4/5-/5+を要求する。
- [ ] lifecycle harnessでbackground/foreground、context recreation、event/hash/theme/mode switch、resource capsを固定する。
- [ ] event fixtureのz0 exactとz14超overscale、synthetic min5 fixtureのz0 request/packet 0 +
  `belowSourceMinZoom`を固定する。

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/integration/estimated_intensity_event_fixture_test.dart
mise exec -- flutter test test/integration/estimated_intensity_lifecycle_test.dart
```

**Expected:** manifest/runtime harness未実装のためFAIL。通常testはnetwork/credentialを要求しない。actual
descriptor/archiveを検証するopt-in integration lane内ではnetwork unavailableをpass/skipへ変換しない。

### P9.2 GREEN automated gates

- [ ] 通常CI用にdeterministic local archive fixtureを生成し、P3以降の全trust/decoder/lifecycle pathをhermeticに通す。
- [ ] test専用credential/configuration経路の明示的opt-in laneでP0 contract fixtureのactual descriptorを供給し、
  P3 repository経由でfull verificationする。
- [ ] actual archive manifestをopt-in laneで生成してreviewし、event-specific値はtest treeの外へexportしない。
- [ ] lifecycle testでdownload/decode/upload/Scene countersとlease/resource retirementを検証する。
- [ ] runtimeで判明した再現可能なplatform制約と操作commandだけをknowledge documentへ残す。

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib test
mise exec -- flutter test test/integration/estimated_intensity_event_fixture_test.dart
mise exec -- flutter test test/integration/estimated_intensity_lifecycle_test.dart
mise exec -- flutter test
mise exec -- flutter analyze

cd ../../app
mise exec -- flutter test test/feature/settings/children/config/debug/eqmonitor_map/estimated_intensity_runtime_configuration_test.dart
mise exec -- flutter test
mise exec -- flutter analyze
```

actual network verificationは上の無条件suiteへ混ぜず、auditで確認したcredential secretと専用workflow/inputが
そろったopt-in laneだけで実行する。lane名とcommandは実装時にrepository workflowを監査して確定し、推測した
script名をこの計画へ固定しない。

### P9.3 GREEN iOS / Android runtime gates

- [ ] `mise exec -- flutter devices` で実在する iOS Simulator、physical iOS device、Android emulator、
  physical Android deviceのdevice IDとsupport modeを記録する。
- [ ] ユーザーへ操作開始を通知してから、generic platform selectorを使わず、各targetのactual device IDを
  `-d`へ明示してdebug mapを起動する。
- [ ] iOS Simulator debugとAndroid emulator debugでvisual/gesture/mode/lifecycle smokeを実行する。
- [ ] physical iOS device profileでperformance、memory、renderer context、OS lifecycle gateを実行する。
- [ ] Androidはprofileをsupportするactual emulatorまたはphysical deviceでperformance/lifecycle gateを実行する。
- [ ] debug inputへ `20260823020050` を入力し、次を画面・diagnostic counter・log分類で確認する。

Runtime checklist:

- actual descriptor download、exact size、SHA-256、
  PMTiles header確認
- class 4 / 5- / 5+ のtheme色とFill/Line pair
- administrative lineより下の描画順
- observed Fill/station非表示、archive未検証中のbase+hypocenter-only表示、verified後のsame-event
  hypocenter再stamp
- pan/pinch、z0、z14、z14超、bounds edge
- event/hash/theme/mode switch
- background/foreground、renderer context recreation
- cap超過時のpacket 0と利用者向けredacted error
- continuous Scene/GPU error、late commit、double retire、leaked leaseが0

```bash
cd app
mise exec -- flutter devices
```

この出力からactual device IDをrun sheetへ転記し、次の4 commandをそのIDで具体化してから実行する。
run sheetに未解決placeholderが残る間は実行しない。

```text
mise exec -- flutter run --debug -d ACTUAL_IOS_SIMULATOR_DEVICE_ID
mise exec -- flutter run --profile -d ACTUAL_PHYSICAL_IOS_DEVICE_ID
mise exec -- flutter run --debug -d ACTUAL_ANDROID_EMULATOR_DEVICE_ID
mise exec -- flutter run --profile -d ACTUAL_PROFILE_CAPABLE_ANDROID_DEVICE_ID
```

大文字のdevice IDはproduction commandの固定値ではなく、実行前run sheetで `flutter devices` の出力へ
置換する明示placeholderである。iOS Simulatorにはprofile commandを実行しない。physical deviceが利用不能なら
該当profile gateをpass/skip扱いせずblockedとして記録する。runtime evidenceにはdevice名、OS、renderer backend、
commit SHA、実行mode、操作、結果を残す。
終了時はagentが起動したprocessを停止し、Simulator/emulatorの入力をユーザーへ解放する。

**Commit sequence:**

1. `test: 推計震度event fixtureを固定`
2. `test: 推計震度lifecycle gateを追加`
3. `docs: 推計震度runtime検証を記録`

**Verification:** iOS Simulator debug、physical iOS profile、Android emulator debug、profile-capable Android
targetの4 gateがgreenになるまで P9 をmerge-readyとしない。Simulator/emulator testだけで
real-device/OS lifecycle provenとは表現しない。

## Final Stack Verification

- [ ] stack rootから各branchのbase/headを確認し、P1→P9に飛び越しや逆依存がないことを確認する。
- [ ] 各PRで `git --no-pager diff --check`、focused tests、package/app analyzeを再実行する。
- [ ] generated OpenAPI/client/fixtureとbackend submodule commitがP0 contractに一致する。
- [ ] production treeに event URL/hash/sizeの固定値やlegacy fallbackがないことを検索する。

```bash
rg -n "20260823020050|estimated_intensity_tile_archive" app/lib packages/eqmonitor_map/lib
rg -n "estimatedIntensityTileUrl.*fallback|estimated_intensity_tile.*fallback" app/lib packages/eqmonitor_map/lib
git --no-pager diff --check
```

最初の `rg` は production treeでevent IDが0件であることを期待する。descriptor field名はcontract accessとして
存在してよいが、URL/hash/size literalは存在してはならない。

- [ ] `gh pr view --repo YumNumm/EQMonitor` と `gh pr checks --repo YumNumm/EQMonitor` で各PRのbase、head、
  review、required checksをlive確認する。
- [ ] mergeはP1から順番に行い、下位PR merge後は次PRのbase syncとfocused regressionを終えてから次へ進む。
- [ ] debug-map gate完了後もMapLibre removalを別issue/stackとして残す。

## Done Definition

- P0 descriptorがURL/size/SHAを一つのimmutable identityとして公開する。
- P1 generated clientがlegacy fieldとdescriptorを併存してdecodeする。
- malformed/legacy-only/redirect/oversize/hash mismatch/archive mismatchは全てfail closed。
- PMTiles header由来のmin0/max14をevent fixtureで使い、synthetic min5 fixtureでもunderzoom fallbackを行わない。
- strict `seismic_intensity` Polygonと既知6 classだけを受理する。
- visible exact cover complete前はFill/Line packetが0。
- observed/estimatedは原子的に排他で、estimatedはsame-event hypocenterを維持する。
- event/hash/viewport/theme/lifecycle/contextのlate workがSceneへcommitされない。
- event `20260823020050` がtest fixtureとiOS/Android runtime gateを通る。
- production codeに固定URL/hash/size、unknown-class fallback、legacy descriptor合成がない。
- MapLibre layerは残り、削除判断に必要なparity evidenceが保存されている。
