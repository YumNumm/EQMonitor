# Flutter Analyze Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the CI-equivalent Flutter analysis of `app` finish with zero infos, warnings, or errors.

**Architecture:** Treat the analyzer output as the failing regression gate. Apply the Dart SDK's syntax-preserving fixes for the three supported lint rules, review their diff by application area, and manually remove the single genuinely unused value. Keep commits reviewable by grouping related directories and limiting each commit to roughly 30–100 changed lines.

**Tech Stack:** Flutter 3.44, Dart 3.13, Melos, Dart analyzer, Git worktrees

## Global Constraints

- Run every Flutter and Dart command through `mise exec --`.
- Do not modify generated files or suppress analyzer diagnostics.
- Do not introduce fixed-value or random fallbacks in life-safety data paths.
- Preserve the user's original checkout and work only in `.worktrees/flutter-analyze-cleanup`.
- Verify both the CI-scoped app analysis and the workspace-wide Melos analysis.

---

### Task 1: Record and classify the failing analyzer baseline

**Files:**
- Create: `docs/superpowers/plans/2026-08-16-flutter-analyze-cleanup.md`

**Interfaces:**
- Consumes: `analysis_options.yaml` lint configuration and `app/**/*.dart`.
- Produces: a reproducible diagnostic count and repair classification.

- [ ] **Step 1: Resolve the locked workspace dependencies**

Run: `mise exec -- dart pub get --enforce-lockfile`

Expected: dependency resolution succeeds without changing `pubspec.lock`.

- [ ] **Step 2: Run the failing CI-equivalent analysis**

Run: `mise exec -- flutter analyze --no-pub --fatal-infos app`

Expected: FAIL with 1,727 issues from four diagnostic codes.

- [ ] **Step 3: Confirm supported SDK fixes without changing files**

Run: `mise exec -- dart fix --dry-run app`

Expected: 1,726 proposed fixes covering `unnecessary_type_name_in_constructor`, `unnecessary_const_in_enum_constructor`, and `empty_container_bodies`.

### Task 2: Apply syntax-preserving Dart SDK fixes

**Files:**
- Modify: `app/lib/**/*.dart`
- Modify: `app/test/**/*.dart`

**Interfaces:**
- Consumes: the three analyzer diagnostic codes with official SDK producers.
- Produces: constructor declarations using dot shorthand, enum constructors without redundant `const`, and empty container bodies written with semicolons.

- [ ] **Step 1: Apply only the three proven analyzer fixes**

Run:

```bash
mise exec -- dart fix --apply --code=unnecessary_type_name_in_constructor app
mise exec -- dart fix --apply --code=unnecessary_const_in_enum_constructor app
mise exec -- dart fix --apply --code=empty_container_bodies app
```

Expected: exactly 1,726 diagnostics are fixed; no unrelated fix producer runs.

- [ ] **Step 2: Keep the official fixes narrowly scoped**

Do not run a directory-wide formatter for one-token SDK fixes; it can rewrite
unrelated existing or generated files under the current Dart formatter.

Expected: only lines selected by the three requested fix producers change.

- [ ] **Step 3: Review and commit related path groups**

Run: `git --no-pager diff --check` and `git --no-pager diff --stat`

Expected: syntax-only diffs, split into commits of roughly 30–100 changed lines by `core`, individual feature groups, and tests.

### Task 3: Remove the unused feed summary value

**Files:**
- Modify: `app/lib/feature/feed/ui/component/feed_item_card.dart`

**Interfaces:**
- Consumes: the local `summary` declaration reported by `unused_local_variable`.
- Produces: the same widget behavior without computing a discarded value.

- [ ] **Step 1: Confirm this is the only unsupported diagnostic**

Run: `mise exec -- flutter analyze --no-pub --fatal-infos app`

Expected: FAIL only for `unused_local_variable` in `feed_item_card.dart`.

- [ ] **Step 2: Delete the unused local declaration**

Remove only the `summary` declaration and its now-unused expression; do not change rendered feed content.

- [ ] **Step 3: Run the focused analyzer gate**

Run: `mise exec -- dart analyze app/lib/feature/feed/ui/component/feed_item_card.dart --fatal-infos`

Expected: PASS with no issues.

### Task 4: Move Asset Pack helpers into responsibility classes

**Files:**
- Modify: `app/lib/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_archive_extractor.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_content_validator.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_repository.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_storage_repository.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/asset_pack_update_installer.dart`
- Modify: `app/lib/feature/asset_pack/data/repository/r2_asset_pack_archive_downloader.dart`
- Test: `app/test/feature/asset_pack/*.dart`

**Interfaces:**
- Consumes: the existing helper signatures, exception types, providers, and constructor-injected adapters.
- Produces: the same behavior through public instance/static methods with no non-exempt top-level functions.

- [ ] **Step 1: Run the existing Asset Pack tests before refactoring**

Run from `app/`: `mise exec -- flutter test test/feature/asset_pack`

Expected: all existing behavior tests pass while Melos analyze remains RED with 33 `avoid_top_level_functions` warnings.

- [ ] **Step 2: Move manifest JSON field validation**

Add `AssetPackDistributionManifestJsonValidator` with static `requireSemVer`, `requireString`, and `requireInt` methods. Update the manifest factories to call the class and remove the three top-level functions.

- [ ] **Step 3: Move archive and content validation helpers**

Move `validateArchiveEntry` and `extractArchiveEntry` onto `AssetPackArchiveExtractor`. Move manifest reading, entry parsing, safe-path validation, hash/size verification, and undeclared-file verification onto `AssetPackContentValidator`; update `AssetPackStorageRepository` to use its injected validator.

- [ ] **Step 4: Move distribution and active-pack helpers**

Move HTTP fetch, signed payload assembly, verified cache access, JSON decoding, and rollback persistence onto `AssetPackDistributionRepository`. Move manifest reading, downloaded fallback, root resolution, and SHA-256 verification onto `AssetPackRepository`.

- [ ] **Step 5: Move storage, install, and download helpers**

Move version validation, bundled source resolution, staging install, inactive cleanup, and corrupt-pack deactivation onto `AssetPackStorageRepository`. Move archive verification and temporary cleanup onto `AssetPackUpdateInstaller`. Make the two default background download adapters static methods on `R2AssetPackArchiveDownloader`.

- [ ] **Step 6: Run the focused custom-lint gate**

Run: `mise exec -- dart analyze app --fatal-infos`

Expected: PASS with no `avoid_top_level_functions` warnings.

- [ ] **Step 7: Run Asset Pack tests after refactoring**

Run: `mise exec -- flutter test app/test/feature/asset_pack`

Expected: the same tests pass with unchanged exception and fallback behavior.

### Task 5: Verify, document, and publish

**Files:**
- Create: `docs/knowledge/20260816_dart_3_13_analyzer_migration.md`

**Interfaces:**
- Consumes: the completed app changes.
- Produces: clean app/workspace analyzer gates and a reusable migration note.

- [ ] **Step 1: Run the complete CI-equivalent gate**

Run: `mise exec -- flutter analyze --no-pub --fatal-infos app`

Expected: PASS with `No issues found!`.

- [ ] **Step 2: Run the workspace analyzer gate**

Run: `DASH__SUPPRESS_ANALYTICS=true mise exec -- dart run melos run analyze`

Expected: PASS for every workspace package with fatal infos enabled and no analyzer telemetry network crash.

- [ ] **Step 3: Run the app test suite**

Run from `app/`: `mise exec -- flutter test`

Expected: all app tests pass.

- [ ] **Step 4: Push the branch and open one reviewable PR**

Push `fix/flutter-analyze-cleanup` and target `develop`; use stacked PRs only if GitHub review size makes a single PR impractical.
