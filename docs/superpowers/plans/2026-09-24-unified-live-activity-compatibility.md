# Unified Live Activity compatibility verification

> Execute inline with `superpowers:executing-plans`; request one independent review before the PR is ready.

**Goal:** Integrate the existing unified Widget into develop with evidence that backend snapshots decode and select the expected display.

**Architecture:** Reuse `feat/unified-live-activity-design`, retain the legacy EEW Widget, and test production Swift sources in a focused iOS simulator target without Flutter. Keep the develop Xcode project format and unrelated settings.

**Tech Stack:** Swift, ActivityKit, Swift Testing, XcodeGen, GitHub Actions.

**Spec:** `docs/unified-live-activity-client-design.md`, backend `unified-live-activity-content-state.ts` (backend commit `3ba540e0`).

## Constraints and review focus

- Preserve the exact `EarthquakeLiveActivityAttributes` name and opaque String ID.
- Decode null blocks/locations and all magnitude variants; do not invent missing observations.
- Follow `primary`, preserve ended shake peaks, and leave final/cancel/end lifecycle to the server.
- No production settings changes or real APNs test sends.
- Simulator tests cannot prove push-to-start delivery or installation of build 1929.

## Tasks

- [x] Integrate the design branch into current develop; remove unrelated Xcode serialization changes.
- [x] Add canonical and anonymized production-shaped snapshot regression tests, block combinations, magnitude and lifecycle assertions.
- [x] Add focused native compile/test CI for the real Swift model and Widget sources, and execute it.
- [x] Review the final diff, document remaining device-only checks, and create a develop PR in YumNumm/EQMonitor.

## Verification evidence

- Independent contract/project-membership review: no confirmed implementation defect remaining.
- iOS simulator: 61 tests in 5 suites passed on source commit `45daa445b`; [CI run](https://github.com/YumNumm/EQMonitor/actions/runs/35894825846).
- Swift syntax, shell syntax, actionlint and diff checks passed.
- [PR #1827](https://github.com/YumNumm/EQMonitor/pull/1827), base `develop`.
- Existing Flutter CI setup failure also occurs in baseline release PR run `35865454313`; full app and real-device APNs validation remain open.
