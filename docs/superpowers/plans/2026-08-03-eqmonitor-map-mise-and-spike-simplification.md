# EQMonitor Map mise・Scene Spike Simplification Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** YumNumm版`mise-flutter`へFlutter SDK導入を一本化し、Scene spikeからevidence/validator/Dart define manifestを削除して、iOS/Android向けの最小manual smoke exampleを残す。

**Architecture:** `FlutterSceneSpikeRemountOwner`が共有する軽量な`SceneSpikeMetrics`へ観測counterだけを保持し、controllerはScene lifecycle・resource rebuild・partial updateに専念する。Flutter Scene adapterからevidence sinkを外し、example UIは描画操作とcounter表示だけにする。固定revisionの正本は`mise.toml`、package pubspec、lockfileとし、runtime defineへ複製しない。

**Tech Stack:** Flutter master pin、Dart、flutter_scene、flutter_hooks、Freezed、GitHub Actions、mise

## Global Constraints

- 対象はEQMonitor専用かつiOS/Androidのみ。bearing/pitchは実装しない。
- checkout clean状態、Flutter/Engine/Dart revision、evidence metadataをDart defineへ渡さない。
- `write_scene_spike_defines.dart`、canonical evidence、validator、operator checklist、4-run gateを完全に削除する。
- procedural mesh、custom material、`TextPainter` overlay、partial update、resource rebuild、dispose/remountは残す。
- counterはframe、partial update、resume、remount、resource rebuild、exceptionの6個だけをremount間で共有する。
- mutableな`SceneSpikeMetrics`はframe hot path用runtime stateであり、Freezed/JSON modelにしない。永続化するdomain/data modelは引き続きFreezed + json_serializableを基本とする。
- widget/golden/性能閾値テストは追加しない。既存の非同期generation、lifecycle、rebuild、remountのunit testは維持する。
- 実機確認はREADMEのmanual checklistへ記載し、このLinux環境で実施済みとは扱わない。
- Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。
- TODOのための固定値・ランダム値・fail-open fallbackを追加しない。

---

## Task 1: Scene runtimeを軽量counterへ置き換える

**Files:**

- Create: `packages/eqmonitor_map/lib/src/flutter_scene/scene_spike_metrics.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_adapter.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_controller.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_remount_owner.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_spike_controller_test.dart`

- [ ] `SceneSpikeMetrics`へ6 counterのgetterとrecord methodだけを実装する。reset、revision、timing percentile、capability map、serializationは実装しない。
- [ ] `FlutterSceneSpikeAdapter`から`SceneSpikeRuntimeObservationSink`のconstructor引数・field・record呼び出しを削除する。dirty rangeとvertex countを守る`SceneSpikeMeshUpdateValidator`は残す。
- [ ] controller factoryを`create({SceneSpikeMetrics? metrics})`へ変更し、runtime identity、build manifest、backend attestation、checklist、canonical JSON、evidence reset/capability APIを削除する。
- [ ] `initializeStaticResources`はstatic resource初期化とcustom material初期化だけを非同期generation管理下で行い、例外を`exceptionCount`へ記録する。
- [ ] partial update成功、foreground、rebuild成功、frame callback、confirmed remountを対応するcounterへ記録する。`startUpdates`はactiveかつupload可能なときだけ開始する。
- [ ] remount ownerが単一`SceneSpikeMetrics`をreplacement controllerへ渡し、remount後もcounterを維持する。
- [ ] controller testからevidence fake/checklist assertionを除去し、stale initialization、dispose/detach cancellation、background/reattach rebuild、partial update exception、start/stop、共有counter/remountを検証する。
- [ ] `mise exec -- flutter test test/flutter_scene/flutter_scene_spike_controller_test.dart`を`packages/eqmonitor_map`で実行する。
- [ ] `mise exec -- dart format lib/src/flutter_scene test/flutter_scene/flutter_scene_spike_controller_test.dart`を実行する。
- [ ] 変更を`Refactor: Scene spike観測を軽量counterへ置換`としてコミットする。

## Task 2: Evidence harnessとDart define manifestを削除する

**Files:**

- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_view.dart`
- Delete: `packages/eqmonitor_map/lib/src/flutter_scene/scene_spike_operator_checklist.dart`
- Delete: `packages/eqmonitor_map/lib/src/flutter_scene/spike_frame_timing_collector.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_evidence_collector.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_gate.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_gate.freezed.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_gate.g.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_observation.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_observation.freezed.dart`
- Delete: `packages/eqmonitor_map/lib/src/observability/scene_spike_observation.g.dart`
- Delete: `packages/eqmonitor_map/tool/write_scene_spike_defines.dart`
- Delete: `packages/eqmonitor_map/tool/validate_scene_spike_evidence.dart`
- Delete: `packages/eqmonitor_map/tool/src/scene_spike_evidence_validator.dart`
- Delete: `packages/eqmonitor_map/test/observability/scene_spike_evidence_collector_test.dart`
- Delete: `packages/eqmonitor_map/test/observability/scene_spike_gate_test.dart`
- Delete: `packages/eqmonitor_map/test/observability/spike_frame_timing_collector_test.dart`
- Delete: `packages/eqmonitor_map/test/tool/write_scene_spike_defines_test.dart`
- Delete: `packages/eqmonitor_map/test/tool/validate_scene_spike_evidence_test.dart`
- Delete: `packages/eqmonitor_map/test/tool/scene_spike_ci_workflow_test.dart`
- Delete: `packages/eqmonitor_map/example/evidence/README.md`
- Modify: `packages/eqmonitor_map/pubspec.yaml`
- Modify: `pubspec.lock`
- Modify: `.github/workflows/wc-check-eqmonitor-map-scene-spike.yaml`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `packages/eqmonitor_map/example/lib/main.dart`

- [ ] viewからdevice/revision/backend/capability/checklist/reset/copy JSON UIと`Clipboard`依存を削除し、3操作buttonと6 counterだけのpanelにする。
- [ ] evidence/validator/writer source、生成コード、tests、example evidence directoryをすべて削除する。
- [ ] Scene build workflowからdefine manifest生成stepと4つの`--dart-define-from-file=.dart_tool/scene_spike_defines.json`を削除し、profile/release buildは維持する。
- [ ] packageから未使用の`device_info_plus`、`json_annotation`、`json_serializable` direct dependencyを`mise exec -- flutter pub remove ...`で除去し、workspace lockfileを更新する。Freezed/build_runnerは残す。
- [ ] package export/example commentをmanual smoke harnessの説明へ更新する。
- [ ] `rg -n "write_scene_spike_defines|canonicalEvidence|SceneSpikeEvidence|SceneSpikeCapability|scene_spike_defines|SceneSpikeRuntimeObservation" packages/eqmonitor_map .github/workflows/wc-check-eqmonitor-map-scene-spike.yaml`がno matchになることを確認する。
- [ ] `mise exec -- actionlint .github/workflows/wc-check-eqmonitor-map-scene-spike.yaml`をproject rootで実行する。
- [ ] `mise exec -- flutter test`を`packages/eqmonitor_map`で実行する。
- [ ] 変更を`Refactor: Scene spike evidence harnessを削除`としてコミットする。

## Task 3: 現行の導入・実機確認手順へ文書を更新する

**Files:**

- Create: `docs/superpowers/plans/2026-08-03-eqmonitor-map-mise-and-spike-simplification.md`
- Modify: `packages/eqmonitor_map/README.md`
- Modify: `packages/eqmonitor_map/example/README.md`
- Modify: `docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md`
- Modify: `docs/knowledge/20260802_flutter_scene_scene_source_pin.md`
- Delete: `docs/knowledge/20260802_eqmonitor_map_flutter_scene_device_gate.md`
- Delete: `docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-physical-verification.md`
- Modify: `docs/superpowers/plans/2026-08-02-eqmonitor-map-scene-spike.md`
- Modify: `docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`
- Modify: `docs/knowledge/20260802_eqmonitor_map_renderer_constraints.md`
- Modify: `docs/todo/800_eqmonitor_map_deferred_verification.md`
- Modify: `docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-01-design.md`
- Modify: `docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md`

- [ ] package READMEへ`mise exec -- flutter run --profile -d <device-id>`とrelease実行手順を記載し、描画、回転、partial update、background復帰、resource rebuild、remount、例外counter/logのmanual checklistを載せる。
- [ ] bootstrap repos、`.flutter-scene-sdk` checkout、writer、validator、canonical evidence、4-run gate、古いScene revision `695c954f237fabef65d49fa7199002851d2dcd88`を現行文書から除去する。
- [ ] renderer foundationを止める旧device gateをmanual smoke確認へ置き換え、evidence専用knowledge/physical verification planは削除する。
- [ ] 履歴として残す旧spike planには冒頭へsuperseded注記と現行planへのリンクを追加する。
- [ ] Scene spike PR draftを実際の最小harness/mise workflow/未実施の実機確認に合わせて全面更新する。
- [ ] `docs/todo/800_eqmonitor_map_deferred_verification.md`はperformance HUD、widget/golden/benchmark、実機profile/release確認だけを未完了事項として残す。
- [ ] `rg -n "mise bootstrap repos|write_scene_spike_defines|validate_scene_spike_evidence|canonical evidence|canonical_evidence|4-run|695c954f237fabef65d49fa7199002851d2dcd88" README.md packages/eqmonitor_map docs/knowledge docs/todo docs/superpowers/pr-drafts`で現行運用文書に旧参照がないことを確認する。superseded planと、廃止対象を正確に記録する承認済みdesign/current plan内の記述は許容する。
- [ ] 変更を`Docs: Scene spikeをmanual smoke手順へ簡素化`としてコミットする。

## Task 4: Package全体を検証しPR下書きを確定する

**Files:**

- Modify if needed: `packages/eqmonitor_map/**`
- Modify if needed: `docs/superpowers/pr-drafts/2026-08-02-eqmonitor-map-02-scene-spike.md`

- [ ] `mise exec -- flutter precache --linux`を実行する。
- [ ] `mise exec -- dart pub get --enforce-lockfile`をproject rootで実行する。
- [ ] `.dart_tool/package_config.json`の`flutter_scene`が`7f71993b7e2a0ab1d2f59726a406098709be7291`へ解決されていることを確認する。
- [ ] `mise exec -- dart format --output=none --set-exit-if-changed packages/eqmonitor_map/lib packages/eqmonitor_map/test packages/eqmonitor_map/example/lib`を実行する。
- [ ] `mise exec -- flutter analyze --no-pub --fatal-infos packages/eqmonitor_map`を実行する。
- [ ] `mise exec -- flutter test`を`packages/eqmonitor_map`で実行する。
- [ ] `mise exec -- actionlint .github/workflows/wc-check-eqmonitor-map-scene-spike.yaml .github/workflows/wc-check-dart-analyze.yaml .github/workflows/wc-check-dart-test.yaml .github/workflows/wc-check-integration.yaml .github/workflows/deploy-app.yaml .github/workflows/wc-changes.yaml`を実行する。
- [ ] `git diff --check`と旧evidence/validator/writer参照の最終`rg`を実行する。
- [ ] iOS/Android profile/release実機確認は未実施としてPR draftへ明記する。Linuxで成功を主張しない。
- [ ] 検証で必要になった修正だけを適切な既存コミットへ追加するか、`Fix: Scene spike簡素化後の検証不備を修正`としてコミットする。
