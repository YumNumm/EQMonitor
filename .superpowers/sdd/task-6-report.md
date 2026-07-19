# Task 6 Report: Canonical shake visibility and legacy removal

## Result

- `shakeDetectionVisibleProvider` now consumes the canonical snapshot directly.
- Visibility is authorized only when the server has no `correlatedEew` and the
  canonical `expiresAt` is strictly after the current UTC time.
- Client travel-time/hypocenter correlation, the local three-minute TTL, the
  merge provider, and their tests were removed.
- Canonical event metadata is required and the transitional legacy fields,
  converter, and core `shakeDetected` realtime variant were removed atomically.
- Existing revision synchronization from Task 5 is unchanged.
- Implementation commit: `f5a4e56f2`
- Push: not performed because this is a detached managed worktree.

## RED

- Command:
  `mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_visible_test.dart`
- Exit code: 1, with all three canonical visibility tests failing for the
  intended reasons:
  - an event with server `correlatedEewEventId` remained visible;
  - an event with `expiresAt == now` remained visible;
  - an event created four minutes earlier was hidden even though its server
    `expiresAt` was still in the future.
- The old provider also initialized EEW and WebSocket dependencies during this
  test, directly demonstrating that client-side correlation was still active.

## GREEN

- The same focused visibility command passed all 3 tests after the provider
  replacement.
- The provider compares in UTC and uses `event.expiresAt.isAfter(now)`, so the
  expiration boundary is strict and does not retain an event at equality.
- The returned list is non-growable and preserves canonical snapshot order.
- `correlatedEewEventId` is the only nullable correlation field; there is no
  client-generated correlation metadata.

## Removed client correlation evidence

- Removed the `travelTimeDepthMapProvider`, `eewAliveTelegramProvider`,
  `latlong2`, hypocenter/travel-time calculation, `_findMergedEew`, and
  `shakeDetectionMergedProvider` dependencies from the shake feature.
- Removed `shake_detection_merge_test.dart`; correlation ownership is now on
  the server contract.
- Repository-wide app/test scans found no references to the merge provider,
  `mergedEewEventId`, `_findMergedEew`, or `_shakeDisplayTtl`.

## `expiresAt` boundary evidence

- A fixed clock at `2026-07-19T12:00:00Z` drives all visibility cases.
- `expiresAt == now` is excluded.
- `expiresAt == now + 1ms` is included.
- An event whose `createdAt` is four minutes old remains included while its
  canonical `expiresAt` is one second in the future, proving the local
  three-minute TTL no longer participates.

## Atomic migration and todo gates

- `serialNo`, `updatedAt`, `expiresAt`, and `changeReasons` are required in
  `ShakeDetectionEvent`.
- Removed `isReplay`, `mergedEewEventId`, `RealtimeShakeData`,
  `RealtimeShakeDataConverter`, and `RealtimeEvent.shakeDetected` plus generated
  code and obsolete tests.
- REST and WebSocket producers continue to pass all canonical metadata from the
  source contract; no missing metadata is invented.
- UI/history/debug fixtures now construct complete canonical events. Replay-only
  tags were removed, and correlation labels use the server event ID without a
  null assertion.
- Unknown canonical levels still fail through the strict parser/repository path;
  the scan for `orElse: ... ShakeDetectionLevel.weaker` is empty.
- The completed `docs/todo/850_remove_shake_detection_legacy_fields.md` was
  deleted.

## Verification

- `mise exec -- flutter test app/test/feature/shake_detection`: 33 passed.
- `mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart app/test/feature/playback_mode/data/auto_return_policy_test.dart`:
  7 passed.
- `mise exec -- flutter test app/test/feature/playback_mode`: 5 passed.
- `mise exec -- dart analyze app/lib`: no issues found.
- `git diff --check`: passed.
- Required-field, deleted-todo, forbidden fallback, and obsolete-reference gates:
  passed.
- Commit hooks: merge-conflict, symlink, private-key, and gitleaks checks passed.
- Independent read-only review: no Critical, Important, or Minor findings;
  verdict `Ready to proceed`.

## Self-review

- Visibility consumes only the Task 5 synchronized canonical event list and
  does not alter revision selection, REST races, reconnect generation guards,
  or failure handling.
- Both REST and WebSocket mappings carry the server correlation ID and canonical
  timestamps into the required domain fields.
- No fixed fallback state, random value, null assertion, forbidden broad type,
  or new private helper was introduced.
- Generated diffs are limited to the changed Freezed/JSON/Riverpod surfaces;
  unrelated generator churn was removed before commit.
- The pre-existing unstaged `.superpowers/sdd/task-5-report.md` change was
  preserved and excluded from the Task 6 commit.

## Risks and deviations

- Removing the legacy per-event `shakeDetected` variant also removes its replay
  auto-return trigger. Canonical shake updates are full snapshots, so treating
  every snapshot as a new alert would incorrectly return on initial sync and
  ordinary revisions; auto-return therefore remains EEW-only.
- The first final Flutter verification attempt could not update the SDK engine
  stamp in the filesystem sandbox. The identical commands were rerun with the
  required filesystem approval and passed.
- `build_runner` reported that `--delete-conflicting-outputs` is now ignored by
  the installed version, but generation completed successfully and obsolete
  generated files were deleted.
