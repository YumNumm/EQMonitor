# EQMonitor agent guide

`AGENTS.md` is a symlink to `.agents/index.md`; edit this target and preserve the link.

## Repository boundaries

- Root `pubspec.yaml` defines the Dart workspace and Melos tasks: `app`, `packages/*`, `packages/eqmonitor_map/example`, and `tools/*`. Root `package.json` is Markdown tooling, not the backend workspace.
- Startup is `app/lib/main.dart` → `AppBootstrap.run()` → `app/lib/app.dart`. Features live in `app/lib/feature/` (singular); shared startup, realtime wiring, and preferences live in `app/lib/core/`.
- `backend/` is a private Git submodule; read its instructions before backend work. App/API unit tests do not require it; avoid blanket recursive submodule initialization for app work.
- `packages/eqmonitor_map` uses `third_party/flutter_scene` through path dependencies. Its submodule commit is the version pin; initialize it in each new worktree before resolving pub dependencies.

## Setup and commands

- Use `mise exec --` for every Flutter/Dart command. `mise.toml` pins a Flutter commit with a prerelease Dart SDK; trust manifests, lockfiles, and CI over outdated README/CLAUDE setup instructions.
- Bootstrap from the repository root in order:
  ```sh
  mise install
  git submodule update --init third_party/flutter_scene
  mise exec -- dart pub get --enforce-lockfile
  mise exec -- dart run melos bootstrap
  ```
- `app/pubspec.yaml` enables SPM, native assets (SQLite), and Dart data assets (map shaders) at project level; global `flutter config` settings alone do not configure CI.
- If Apple plugin sync fails with `rsync ... SourcePackages ... No such file or directory`, run `mkdir -p app/build/ios/SourcePackages app/build/macos/SourcePackages` from root and retry. See `docs/knowledge/20260822_flutter-test-sourcepackages-directory.md`.
- Copy `environment/.env.example` to the ignored `environment/.env.dev` and fill in environment-specific values. Run from `app/`: `mise exec -- flutter run --dart-define-from-file=../environment/.env.dev`. `.vscode/launch.json` currently omits the required `../`.
- Before running the app, stage the bundled Asset Pack from root: `mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled` (`--target all` also refreshes the slim iOS extension table). This uses public signed downloads, without `GH_TOKEN`. Do not commit `.gitkeep` deletions caused by staging; see `docs/knowledge/20260819_bundled_asset_pack_flutter_assets.md`.
- Use workspace-pinned Melos via `mise exec -- dart run melos ...`; do not globally activate Melos. Add dependencies from the owning package with `mise exec -- flutter pub add <package>`.
- Codegen in the affected package: `mise exec -- dart run build_runner build --delete-conflicting-outputs`. Workspace codegen: `mise exec -- dart run melos run rebuild`. The current `generate` task references undefined `generate:dart` / `generate:flutter` tasks.
- API contract regeneration is separate: from `packages/eqmonitor_api`, run `mise exec -- dart run bin/generate.dart`. It requires `backend/api/api/openapi.json`, replaces `lib/src`, and applies compatibility patches before build_runner; direct `swagger_parser` skips these patches.
- Generated Dart files are committed. Do not hand-edit `*.g.dart`, `*.freezed.dart`, or special `.*.dart` files. Do not revert unrelated generator output without user confirmation; see `.cursor/rules/generated-file-editing-rules.mdc`.

## Focused verification

- CI app analysis, from root: `mise exec -- dart analyze app --fatal-infos --format machine`. Workspace analysis: `mise exec -- dart run melos run analyze`.
- From `app/` or a Flutter package: `mise exec -- flutter test test/path_test.dart --dart-define=CI=true`. From a pure Dart package: `mise exec -- dart test test/path_test.dart`.
- Workspace tests: `mise exec -- dart run melos run test`. CI uses:
  ```sh
  mise exec -- dart run melos exec --dir-exists=test --concurrency=4 -- 'mise exec -- flutter test --dart-define=CI=true --file-reporter="json:test_report.log"'
  ```
  Keep the command after Melos `--` as one quoted string; otherwise nested `mise exec` can misparse Flutter flags.
- Pure Dart suites: run `mise exec -- dart test` in `packages/eqmonitor_api` or `tools/eqmonitor_lints_plugin`. The latter is in the workspace despite a stale CI comment; root `analysis_options.yaml` enables it alongside Flutter Hooks linting.
- Native shared logic: from root, `xcodebuild -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO test`. Fresh worktrees need generated Flutter/Xcode configuration; see `docs/knowledge/20260910_app_intents_snapshot_contract.md`. Flutter CI does not run this suite.
- Format touched Dart files with `mise exec -- dart format <paths>`. Markdown: `mise exec -- pnpm exec textlint <paths>`; `.agents/**` is ignored, so lint this guide through `AGENTS.md`.
- Emergency-information decisions, conversions, state transitions, notifications, persistence, and bug fixes need automated regression tests. Display-only changes need not add widget tests; run relevant existing tests/analysis and explain why no tests were added.

## Rules to read before changing code

- Dart: `.cursor/rules/flutter-rules.mdc` and `.cursor/rules/data-layer-architecture-rules.mdc`. Key departures from defaults: generated Riverpod providers, Hooks instead of StatefulWidget, Riverpod 3 Mutation for notifier side effects, provider-only files, and external access through Repository/DataSource. Pass `ref`/`context` only at the designated Action/flow boundaries, never into Action constructors.
- No null assertions, `print()`, or broad `dynamic`/`Object` types except the documented `Map<String, dynamic>` allowance. Extract logic into injectable classes rather than private methods or Widget helper methods/getters; follow the detailed Flutter rule.
- Preferences: `.cursor/rules/preferences-key-management.mdc`. Keys belong in `SharedPreferencesKey` / `SecureStorageKey` under `app/lib/core/data/preferences/{shared,secure}/`; access goes through `SharedPreferencesDataSource` / `SecurePreferencesDataSource`.
- Never substitute invented fixed or random values for missing earthquake data. EEW display changes must follow `.cursor/rules/eew-depth-forecast-intensity.mdc`: depth and published intensity are independent; unavailable intensity retains a `-` badge.
- Estimated-intensity changes: `.cursor/rules/estimated-intensity-isolate.mdc` (reuse the persistent worker rather than per-frame `Isolate.run()`). Map renderer changes: `.cursor/rules/map-renderer-references.mdc` (required pinned reference implementations).
- Record unfinished work in `docs/todo/{3-digit-priority}_{title}.md` (higher number = higher priority). New operational/platform lessons go in `docs/knowledge/{YYYYMMDD}_<topic>.md`; consult existing knowledge before duplicating it.

## Git and GitHub

- Use a separate Git worktree and topic branch from `origin/develop`; publish changes as a PR to `develop`.
- Create PRs/issues only in YumNumm repositories, always explicitly passing `--repo YumNumm/<repo>`. In the Flutter Scene fork, `gh` can otherwise target upstream `bdero/flutter_scene`; OpenCode has no Claude hook enforcing this.
- Use `git --no-pager diff` to review changes. Commit in roughly 30–100-line logical units, with an English one-word prefix and concise Japanese description; push after committing.
- `mise install` installs hk hooks via `postinstall`. Stage intended changes before `mise exec -- hk check`: its secret scan uses `gitleaks git --staged`; other checks cover keys, symlinks, conflict markers, workflows, and shell scripts.
