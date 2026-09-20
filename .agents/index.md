# EQMonitor agent guide

`AGENTS.md` is a symlink to `.agents/index.md`; edit this target and preserve the link.

## Repository boundaries

- Root `pubspec.yaml` defines the Dart workspace and Melos tasks: `app`, `packages/*`, `packages/eqmonitor_map/example`, and `tools/*`. Root `package.json` is Markdown tooling, not the backend workspace.
- Startup is `app/lib/main.dart` → `AppBootstrap.run()` → `app/lib/app.dart`. Features live in `app/lib/feature/` (singular); shared startup, realtime wiring, and preferences live in `app/lib/core/`.
- `backend/` is a separate private Git submodule. Read its instructions before backend work; ordinary app unit tests do not require it.
- `packages/eqmonitor_map` uses `third_party/flutter_scene` through path dependencies. The submodule commit is the version pin; initialize it before resolving pub dependencies.

## Setup and commands

- Use `mise exec --` for every Flutter/Dart command. `mise.toml` pins a Flutter commit with a prerelease Dart SDK; trust config/lockfiles over the version table in `CLAUDE.md`.
- Bootstrap from the repository root in order:
  ```sh
  mise install
  git submodule update --init third_party/flutter_scene
  mise exec -- dart pub get --enforce-lockfile
  mise exec -- dart run melos bootstrap
  ```
- For iOS, enable SPM: `mise exec -- flutter config --enable-swift-package-manager`.
- Run Flutter from `app/`. With the separately supplied root `environment/.env.dev` available: `mise exec -- flutter run --dart-define-from-file=../environment/.env.dev`. Paths are relative to the working directory; `.vscode/launch.json` currently omits the `../`.
- Android/macOS asset packs are not committed. Stage with `GH_TOKEN` and `tool/asset_pack/stage_from_release.sh --target android` (or `macos` / `both`); see `docs/knowledge/20260728_asset_pack_release_staging.md`. The slim iOS JMA parameter file is committed.
- Use workspace-pinned Melos via `mise exec -- dart run melos ...`; do not globally activate Melos. Add dependencies from the owning package with `mise exec -- flutter pub add <package>`.
- Codegen in the affected package: `mise exec -- dart run build_runner build --delete-conflicting-outputs`. Workspace codegen: `mise exec -- dart run melos run rebuild`. The current `generate` task references undefined `generate:dart` / `generate:flutter` tasks.
- Generated Dart files are committed. Do not hand-edit `*.g.dart`, `*.freezed.dart`, or special `.*.dart` files. Do not revert unrelated generator output without user confirmation; see `.cursor/rules/generated-file-editing-rules.mdc`.

## Focused verification

- CI app analysis, from root: `mise exec -- dart analyze app --fatal-infos --format machine`. Workspace analysis: `mise exec -- dart run melos run analyze`.
- From `app/` or a Flutter package: `mise exec -- flutter test test/path_test.dart --dart-define=CI=true`. From a pure Dart package: `mise exec -- dart test test/path_test.dart`.
- Workspace tests: `mise exec -- dart run melos run test`. CI uses:
  ```sh
  mise exec -- dart run melos exec --dir-exists=test --concurrency=4 -- 'mise exec -- flutter test --dart-define=CI=true --file-reporter="json:test_report.log"'
  ```
  Keep the command after Melos `--` as one quoted string; otherwise nested `mise exec` can misparse Flutter flags.
- API integration tests are skipped by default. With the private backend's `api/api-stub` built and running on port 8790, run from `packages/eqmonitor_api`: `STUB_BASE_URL=http://localhost:8790 mise exec -- dart test --run-skipped --tags integration`. Setup is in `.github/workflows/wc-check-integration.yaml`.
- Custom analyzer rules live in `tools/eqmonitor_lints_plugin`; test changes there with `mise exec -- dart test` from that directory. Root `analysis_options.yaml` enables this plugin and Flutter Hooks linting.
- Format touched Dart files with `mise exec -- dart format <paths>`. Markdown: `mise exec -- pnpm exec textlint <paths>` (internal docs have exclusions in `.textlintignore`).
- Emergency-information decisions, conversions, state transitions, notifications, persistence, and bug fixes need automated regression tests. Display-only changes need not add widget tests; run relevant existing tests/analysis and explain why no tests were added.

## Rules to read before changing code

- Dart: `.cursor/rules/flutter-rules.mdc` and `.cursor/rules/data-layer-architecture-rules.mdc`. Key departures from defaults: generated Riverpod providers, Hooks instead of StatefulWidget, Riverpod 3 Mutation for notifier side effects, provider-only files, and external access through Repository/DataSource. Pass `ref`/`context` only at the designated Action/flow boundaries, never into Action constructors.
- No null assertions, `print()`, or broad `dynamic`/`Object` types except the documented `Map<String, dynamic>` allowance. Extract logic into injectable classes rather than private methods or Widget helper methods/getters; follow the detailed Flutter rule.
- Preferences: `.cursor/rules/preferences-key-management.mdc`. Keys belong in `SharedPreferencesKey` / `SecureStorageKey` under `app/lib/core/data/preferences/{shared,secure}/`; secure access goes through `SecurePreferencesDataSource`.
- Never substitute invented fixed or random values for missing earthquake data. EEW display changes must follow `.cursor/rules/eew-depth-forecast-intensity.mdc`: depth and published intensity are independent; unavailable intensity retains a `-` badge.
- Estimated-intensity changes: `.cursor/rules/estimated-intensity-isolate.mdc` (reuse the persistent worker rather than per-frame `Isolate.run()`). Map renderer changes: `.cursor/rules/map-renderer-references.mdc` (required pinned reference implementations).
- Record unfinished work in `docs/todo/{3-digit-priority}_{title}.md` (higher number = higher priority). New operational/platform lessons go in `docs/knowledge/{YYYYMMDD}_<topic>.md`; consult existing knowledge before duplicating it.

## Git and GitHub

- Main branch and EQMonitor PR base are `develop`. Create PRs/issues only in YumNumm repositories, always explicitly passing `--repo YumNumm/<repo>`. In the Flutter Scene fork, `gh` can otherwise target upstream `bdero/flutter_scene`; OpenCode has no Claude hook enforcing this.
- Use `git --no-pager diff` to review changes. Commit in roughly 30–100-line logical units, with an English one-word prefix and concise Japanese description; push after committing.
- `mise install` installs hk hooks via `postinstall`. `hk.pkl` checks staged secrets, private keys, symlinks, conflict markers, workflow security/action pins, and shell scripts. Use `mise exec -- hk check` for configured checks.
