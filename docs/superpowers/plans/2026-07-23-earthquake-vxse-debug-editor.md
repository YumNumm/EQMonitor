# Earthquake VXSE Debug Editor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細画面で現在の full Earthquake を基準に VXSE51/52/53/61/62 の型付き patch JSON を編集し、merge または owned-fields clear-and-apply をメモリ上だけで試せるようにする。

**Architecture:** backend の VXSE transformer/writer に対応する field ownership を純粋な reducer と typed draft model に閉じ込める。UI は現在値から draft を作り、型付きフォームと編集可能 JSON を同期し、検証済み結果だけを詳細 provider のローカル override 入口へ渡す。既存のマップレイヤー editor は同じ debug bottom sheet の別タブとして維持する。

**Tech Stack:** Dart 3.11、Freezed/json_serializable、Riverpod 3、flutter_hooks、Material 3、Flutter widget/unit tests、mise。

## Global Constraints

- 対象は VXSE51、VXSE52、VXSE53、VXSE61、VXSE62 のみ。Feed の VXSE56/60 は対象外。
- 現在値を優先し、不足必須値は決定的なサンプル値で補完する。ランダム生成は禁止。
- サーバー、WebSocket、SharedPreferences、SecureStorage へ書き込まない。
- JSON の event ID は現在開いている地震と一致しなければ適用しない。
- Widget にロジック関数を置かず、reducer、draft factory、controller/action を個別ファイルにする。
- Flutter/Dart コマンドは常に `mise exec --` 経由で実行する。

---

## File map

- Create `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart`: VXSE union と JSON schema。
- Create `.../earthquake_vxse_apply_mode.dart`: merge/clearAndApply enum。
- Create `.../earthquake_vxse_field_ownership.dart`: type ごとの owned fields。
- Create `.../earthquake_vxse_debug_draft_factory.dart`: current Earthquake → deterministic draft。
- Create `.../earthquake_vxse_debug_reducer.dart`: pure apply logic。
- Create `.../earthquake_debug_override_notifier.dart`: screen-local override/reset state。
- Create `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_debug_sheet.dart`: tab shell。
- Create `.../earthquake_vxse_debug_editor.dart`: typed form + JSON editor。
- Reuse existing `earthquake_history_debug_modal.dart` content as map-layer tab body。
- Modify details page/map view to pass current Earthquake/event ID and show the sheet。

---

### Task 1: Define VXSE drafts, ownership, and deterministic defaults

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart`
- Create: `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_field_ownership.dart`
- Create: `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart`
- Test: `app/test/feature/earthquake_history/data/debug/earthquake_vxse_debug_draft_factory_test.dart`

**Interfaces:**
- Produces: `EarthquakeVxseDebugDraft` union with `toJson/fromJson`。
- Produces: `EarthquakeVxseDebugDraftFactory.create({required Earthquake current, required EarthquakeTelegramType type})`。
- Produces: `EarthquakeVxseFieldOwnership.forType(type)`。

- [ ] **Step 1: Write failing factory tests**

Cover VXSE51 current max intensity, VXSE52 current hypocenter, VXSE53 combined fields, VXSE61 hypocenter update, and VXSE62 LPGM fields. For a minimal Earthquake, call factory twice and assert equal JSON to prove determinism.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/data/debug/earthquake_vxse_debug_draft_factory_test.dart`

Expected: FAIL because factory/types do not exist.

- [ ] **Step 3: Implement typed union and ownership**

Use Freezed variants named `vxse51`, `vxse52`, `vxse53`, `vxse61`, `vxse62`. Every variant contains `eventId`, `reportedAt`, and only the fields its backend telegram can own. Nested intensity arrays use existing app intensity tree models rather than `Map<String, dynamic>`.

Encode the backend writer ownership exactly:

- VXSE51: max intensity, intensity regions, intensity prefectures, comments.
- VXSE52: hypocenter, magnitude/depth, comments.
- VXSE53: hypocenter, magnitude/depth, max intensity, regions, prefectures, cities, stations, comments.
- VXSE61: hypocenter, magnitude/depth, comments.
- VXSE62: hypocenter, magnitude/depth, max LPGM intensity, LPGM regions, prefectures, stations, comments.

- [ ] **Step 4: Implement deterministic factory**

Use current values first. Define named constants for missing safe debug examples, such as a documented test timestamp, JMA code/name, coordinates, depth, magnitude, and intensity. Never call `Random`, `DateTime.now`, or UUID generation.

- [ ] **Step 5: Generate and verify GREEN**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test app/test/feature/earthquake_history/data/debug/earthquake_vxse_debug_draft_factory_test.dart
```

Expected: PASS and identical repeated JSON.

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/earthquake_history/data/model/debug app/test/feature/earthquake_history/data/debug
git commit -m "feat: VXSEデバッグ入力モデルを追加"
```

---

### Task 2: Implement merge and owned-fields clear-and-apply reducer

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart`
- Create: `app/lib/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart`
- Test: `app/test/feature/earthquake_history/data/debug/earthquake_vxse_debug_reducer_test.dart`

**Interfaces:**
- Produces: `Earthquake apply({required Earthquake current, required EarthquakeVxseDebugDraft draft, required EarthquakeVxseApplyMode mode})`。

- [ ] **Step 1: Write the VXSE51 → VXSE52 failing regression test**

```dart
final result = reducer.apply(
  current: vxse51OnlyEarthquake,
  draft: vxse52Draft,
  mode: EarthquakeVxseApplyMode.merge,
);
expect(result.intensity?.maxIntensity, JmaIntensity.four);
expect(result.hypocenter, isNotNull);
expect(result.telegramTypes, containsAll([.vxse51, .vxse52]));
```

Also test every type in both modes and ensure clear-and-apply never clears fields outside ownership.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/data/debug/earthquake_vxse_debug_reducer_test.dart`

Expected: FAIL because reducer is absent.

- [ ] **Step 3: Implement minimal pure reducer**

Use exhaustive switch expressions. Merge telegram types without duplicates and upsert comments by type/reported time. For clear-and-apply, first create a cleared copy for exactly the ownership table, then reuse the merge path.

- [ ] **Step 4: Verify GREEN**

Run the Task 1 factory test and Task 2 reducer test commands. Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/data/model/debug app/test/feature/earthquake_history/data/debug
git commit -m "feat: VXSEデバッグ適用Reducerを追加"
```

---

### Task 3: Add screen-local override and reset

**Files:**
- Create: `app/lib/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- Test: `app/test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart`

**Interfaces:**
- Produces: `applyDraft(...)`, `applyJson(...)`, `reset()` for a family keyed by event ID。
- Consumes: the full Earthquake state produced by the realtime implementation plan。

- [ ] **Step 1: Write failing provider tests**

Load an API Earthquake, apply VXSE draft, assert details state changes without repository calls, then reset and assert the latest non-debug API/WebSocket state returns. Send a WebSocket full Earthquake while override is active and assert reset returns that newest base, not the original page-open value.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_debug_override_notifier_test.dart`

Expected: FAIL because local override state does not exist.

- [ ] **Step 3: Implement base/override state separation**

Store latest server/realtime base separately from optional debug override. `apply` derives override from the currently displayed state; incoming full realtime updates the base. `reset` removes only override.

- [ ] **Step 4: Verify GREEN**

Run the Step 2 command and `mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart`. Expected: PASS and zero extra REST calls.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/data app/test/feature/earthquake_history
git commit -m "feat: 地震詳細のローカルOverrideを追加"
```

---

### Task 4: Build typed form and editable JSON controller

**Files:**
- Create: `app/lib/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart`
- Create: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart`
- Create: `app/lib/feature/earthquake_history/ui/action/earthquake_vxse_debug_action.dart`
- Test: `app/test/feature/earthquake_history/data/earthquake_vxse_debug_editor_controller_test.dart`
- Test: `app/test/feature/earthquake_history/ui/earthquake_vxse_debug_editor_test.dart`

**Interfaces:**
- Controller state contains selected type, apply mode, typed draft, JSON text, validation error, and canApply。
- Form edits call typed controller setters; raw JSON edits call `validateJson` without mutating details state。

- [ ] **Step 1: Write failing controller tests**

Assert initial JSON is populated from current Earthquake, form edits regenerate JSON, valid manual JSON updates draft, malformed JSON disables apply, wrong type/event ID disables apply, and switching type rebuilds from current displayed Earthquake.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_vxse_debug_editor_controller_test.dart`

Expected: FAIL because controller is absent.

- [ ] **Step 3: Implement controller and validation**

Use generated Freezed `fromJson`; catch `FormatException` and `CheckedFromJsonException`; expose a concise Japanese validation message rather than raw exception text. Keep the user's invalid JSON text visible.

- [ ] **Step 4: Implement typed form components**

Create one focused private Widget class for the shared report fields, hypocenter fields, seismic-intensity fields, LPGM fields, comments, and each typed list row; do not use helper methods. Render only the groups owned by the selected VXSE type. Use adaptive text fields/dropdowns for report/origin times, hypocenter name/coordinates, magnitude/depth, max intensity/LPGM, comments, and add/edit/remove controls for every owned region/prefecture/city/station list. Do not assign fixed heights to text-bearing controls.

- [ ] **Step 5: Verify GREEN**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_vxse_debug_editor_controller_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_vxse_debug_editor_test.dart
```

The widget test pumps both text scales. Expected: PASS without overflow exceptions.

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/earthquake_history/ui app/lib/feature/earthquake_history/data app/test/feature/earthquake_history
git commit -m "feat: VXSEデバッグ編集フォームを追加"
```

---

### Task 5: Integrate the tabbed debug sheet and correct VXSE labels

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_debug_sheet.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_telegram_type.dart`
- Test: `app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart`
- Test: `app/test/feature/earthquake_history/data/earthquake_telegram_type_test.dart`

- [ ] **Step 1: Write failing integration widget test**

Enable debug mode, pump details, tap `Icons.bug_report_rounded`, assert tabs `地震情報` and `マップレイヤー`, apply a VXSE52 draft, observe hypocenter UI update, then reset.

- [ ] **Step 2: Add failing label test**

Assert VXSE61 is `顕著な地震の震源要素更新のお知らせ` and VXSE62 is `長周期地震動に関する観測情報`.

- [ ] **Step 3: Verify RED**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_debug_sheet_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/data/earthquake_telegram_type_test.dart
```

Expected: current modal has no tabs and labels are wrong.

- [ ] **Step 4: Implement tab shell and integration**

Pass current Earthquake into the sheet. Preserve the existing map layer controls unchanged in their tab. Wire Apply through an Action class receiving `WidgetRef` and `BuildContext` only at the action boundary.

- [ ] **Step 5: Verify GREEN and feature suite**

Run every test command from Tasks 1-5, then:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart
mise exec -- flutter analyze app/lib/feature/earthquake_history app/test/feature/earthquake_history
```

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/earthquake_history app/test/feature/earthquake_history
git commit -m "feat: 地震詳細にVXSEデバッグEditorを統合"
```

---

### Task 6: Final verification and handoff

- [ ] **Step 1: Run focused tests**

Run every test command from Tasks 1-5, then:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_upsert_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/earthquake_telegram_comment_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart
```

- [ ] **Step 2: Run static checks**

```bash
mise exec -- flutter analyze app/lib/feature/earthquake_history app/test/feature/earthquake_history
git diff --check
```

Expected: PASS with no warnings or whitespace errors.

- [ ] **Step 3: Inspect generated/uncommitted files**

Run `git --no-pager status --short` and confirm only intentional generated files remain; commit them with the owning task rather than a catch-all commit.

- [ ] **Step 4: Verify commit history**

Run `git --no-pager log -8 --oneline` and confirm each commit is independently understandable and backend gitlink points to the full realtime backend commit.
