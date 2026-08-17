# Test Notification Merge Follow-up Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Repair the test-notification code merged by PR #1672 so it compiles and passes the focused tests on the current `develop` branch, while avoiding an unsafe revert of unrelated map work.

**Architecture:** Keep the existing Sheet, Action, and repository boundaries unchanged. Restore compatibility with the split delivery-result model, the repository-standard `material_ui` widget types, and Dart 3.13 constructor declarations. Treat the map changes as a read-only provenance audit because they were already present in PR #1672's first parent.

**Tech Stack:** Flutter, Dart 3.13+, Riverpod, flutter_hooks, material_ui, flutter_test, GitHub Actions

## Global Constraints

- Run every Flutter and Dart command through `mise exec --`.
- Preserve existing user changes in the original worktree.
- Keep notification behavior unchanged: only normal and critical choices, with confirmation before critical delivery.
- Do not revert map files unless PR #1672's merge commit introduced them relative to its first parent.

---

### Task 1: Audit the map changes attributed to PR #1672

**Files:**
- Inspect: `.cursor/rules/map-renderer-references.mdc`
- Inspect: `docs/knowledge/20260807_dashmap_flutter_scene_reference.md`
- Inspect: `docs/todo/700_eqmonitor_map_line_extrude_projection.md`
- Inspect: `packages/eqmonitor_map/**`

**Interfaces:**
- Consumes: PR #1672 merge commit `6df329db5247ac868aff154eeeb5cf1bde2de464`
- Produces: A decision on whether any map revert belongs in the follow-up

- [x] **Step 1: Compare the merge commit with its first parent**

Run:

```bash
git diff --stat 6df329db^1 6df329db -- \
  .cursor/rules/map-renderer-references.mdc \
  docs/knowledge/20260807_dashmap_flutter_scene_reference.md \
  docs/todo/700_eqmonitor_map_line_extrude_projection.md \
  packages/eqmonitor_map
```

Expected: no output, proving the merge commit introduced no map delta.

- [x] **Step 2: Verify both map commits are ancestors of the first parent**

Run:

```bash
git merge-base --is-ancestor 4dfb90ad4 6df329db^1
git merge-base --is-ancestor 92865ae0a 6df329db^1
```

Expected: both commands exit with status 0. Do not revert these commits in this follow-up.

### Task 2: Restore notification compilation on current develop

**Files:**
- Modify: `app/lib/feature/notification/data/action/test_notification_send_action.dart`
- Modify: `app/lib/feature/notification/ui/component/test_notification_kind_buttons.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart`
- Modify: `app/lib/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart`
- Modify: `app/test/feature/notification/data/action/test_notification_send_action_test.dart`
- Modify: `app/test/feature/notification/ui/component/test_notification_kind_buttons_test.dart`
- Modify: `app/test/feature/settings/features/notification_settings/test_notification_tile_test.dart`

**Interfaces:**
- Consumes: `TestNotificationDeliveryResult` and `TestNotificationFrameworkDisplay` from `test_notification_delivery_result.dart`
- Produces: Existing `TestNotificationSendAction.handle` and Sheet/Tile UI using one Material type system

- [x] **Step 1: Run the existing focused tests and verify RED**

Run:

```bash
cd app
mise exec -- flutter test \
  test/feature/notification/ui/component/test_notification_kind_buttons_test.dart \
  test/feature/notification/data/action/test_notification_send_action_test.dart \
  test/feature/settings/features/notification_settings/test_notification_tile_test.dart
```

Expected: the button tests pass, while Action and Tile tests fail to compile because the split result model is not imported and Flutter Material is incompatible with the design-system extension.

- [x] **Step 2: Apply the minimal compatibility fix**

Add this model import where the result type or display extension is referenced:

```dart
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery_result.dart';
```

Replace Flutter Material imports in the four production files and three tests with:

```dart
import 'package:material_ui/material_ui.dart';
```

Replace explicit in-body constructor type names in the modified files with Dart 3.13 declarations, for example:

```dart
const new({required this.onPressed, super.key});
```

- [x] **Step 3: Format and run focused analysis**

Run `mise exec -- dart format` on the seven modified Dart files, then:

```bash
mise exec -- dart analyze \
  lib/feature/notification/data/action/test_notification_send_action.dart \
  lib/feature/notification/ui/component/test_notification_kind_buttons.dart \
  lib/feature/settings/features/notification_settings/ui/component/test_notification_sheet.dart \
  lib/feature/settings/features/notification_settings/ui/component/test_notification_tile.dart \
  test/feature/notification/data/action/test_notification_send_action_test.dart \
  test/feature/notification/ui/component/test_notification_kind_buttons_test.dart \
  test/feature/settings/features/notification_settings/test_notification_tile_test.dart
```

Expected: no issues.

- [x] **Step 4: Run the complete focused notification test set**

Run:

```bash
mise exec -- flutter test \
  test/feature/notification/ui/component/test_notification_kind_buttons_test.dart \
  test/feature/notification/data/action/test_notification_send_action_test.dart \
  test/feature/settings/features/notification_settings/test_notification_tile_test.dart \
  test/feature/notification/data/repository/push_notification_repository_test.dart
```

Expected: all tests pass.

- [x] **Step 5: Commit the notification compatibility fix**

```bash
git add app/lib/feature/notification app/lib/feature/settings/features/notification_settings/ui/component app/test/feature/notification app/test/feature/settings/features/notification_settings docs/superpowers/plans/2026-08-17-test-notification-merge-followup.md
git commit -m "Fix: マージ後のテスト通知を最新developへ追従"
```

### Task 3: Publish and verify the follow-up PR

**Files:**
- Verify: all files changed by Tasks 1-2

**Interfaces:**
- Consumes: a clean verified branch based on current `origin/develop`
- Produces: a focused GitHub pull request with no map changes

- [x] **Step 1: Re-fetch and rebase if develop advanced**

Run `git fetch origin develop`, then rebase only if `origin/develop` is not an ancestor of `HEAD`.

- [x] **Step 2: Verify final scope**

Run:

```bash
git diff --check origin/develop...HEAD
git diff --name-only origin/develop...HEAD
```

Expected: only the plan and seven notification Dart files; no map paths.

- [ ] **Step 3: Push and open a PR**

Push `codex/fix-merged-test-notification` and open a non-draft PR targeting `develop` that links PR #1672 and records the RED/GREEN verification.

- [ ] **Step 4: Read back PR state**

Confirm the PR URL, changed files, head SHA, mergeability, and Actions status from GitHub.
