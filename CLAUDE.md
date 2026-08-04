# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

EQMonitor is a Flutter-based earthquake monitoring and early warning app for Japan (iOS/Android). It displays real-time JMA earthquake alerts, EEW (Emergency Earthquake Warnings), Kyoshin Monitor data, and earthquake history. The repository is a Dart/Flutter monorepo with a private backend submodule.

## GitHub / Pull Requests（厳守）

- PR は **常に YumNumm（このリポジトリの `origin`）** のみ。`gh pr create` では `--repo YumNumm/EQMonitor` を明示する。
- メインブランチは `develop`。PR のベースブランチは `develop` を指定する。

## Setup

```bash
mise install                                      # Install Flutter, Java, Node, etc.
flutter config --enable-swift-package-manager     # Enable SPM for iOS
dart pub global activate melos                    # Install Melos
melos bootstrap                                   # Resolve workspace dependencies
mv environment/.env.example environment/.env.dev  # Configure environment
```

## Build Commands (Flutter / Dart)

```bash
# Run app
flutter run

# Analysis
melos run analyze          # dart analyze across all packages

# Testing
melos run test             # All tests (Flutter + Dart)
melos run test:flutter     # Flutter tests only
melos run test:dart        # Dart tests only
melos run report:test      # Generate test reports

# Code generation (Riverpod, Freezed, OpenAPI)
melos run generate         # Run build_runner in all packages
melos run rebuild          # Force rebuild

# Maintenance
melos run upgrade          # Upgrade Dart pub versions
melos clean                # Clean all packages
```

## Build Commands (Backend — `backend/` submodule)

See [backend/CLAUDE.md](backend/CLAUDE.md) for full backend guidance.

```bash
pnpm install               # Install dependencies
pnpm build                 # Build all (Turbo)
pnpm check-types           # TypeScript type check
pnpm lint                  # oxlint + oxfmt
pnpm dev                   # Development mode
```

## Architecture

### Monorepo Structure

```
app/                   # Flutter app (iOS/Android/macOS/Web)
backend/               # Backend services (git submodule — private)
packages/              # 27 shared Dart packages
  core/                # Core utilities
  eqmonitor_api/       # Main API client
  jma_code_table_types/
  kyoshin_monitor_api/
  nied_api_client/
  extensions/
  [and more...]
supabase/              # Supabase edge functions & DB schemas
terraform/             # GCP infrastructure (Terraform)
environment/           # App environment config (.env.dev etc.)
scripts/               # Utility scripts
```

### Flutter App Stack

- State management: Riverpod + Flutter Hooks
- HTTP: Dio + Retrofit (code-generated)
- Serialization: Freezed + json_serializable
- Maps: MapLibre (flutter-maplibre)
- Push notifications: Firebase Cloud Messaging + Local Notifications
- Auth: Google Sign-In + Firebase
- Monitoring: Firebase Analytics + Crashlytics
- Updates: Shorebird (OTA), Upgrader

### Code Generation

Generated files (`*.g.dart`, `*.freezed.dart`) are committed. Run `melos run generate` after modifying annotated classes.

## Code Style

- Dart: `dart analyze` must pass (no warnings). Follow existing Riverpod patterns.
- Formatting: `dart format` (enforced by CI).
- Imports: Use package imports (not relative) for cross-package dependencies.

## CI/CD

- `flutter.yaml` — `dart analyze` + unit tests on PR and merge_group
- `deploy-app.yaml` — iOS/Android builds on push to `develop` (macos-26, Xcode 26.6)
- `flutter-auto-fix.yaml` — Auto-format on PR
- `actionlint.yaml` — GitHub Actions syntax validation

## Pre-commit Hooks (hk)

Configured in `hk.pkl` via mise:

```bash
# Checks run automatically on commit:
# - gitleaks (secret detection)
# - zizmor (GitHub Actions security)
# - pinact (pin Actions to SHA digests)
# - shellcheck (bash linting)
```

## Tool Versions

Managed by `mise.toml`:

| Tool    | Version     |
|---------|-------------|
| Flutter | 3.44.0      |
| Dart    | ^3.11.0     |
| Java    | 17          |
| Node    | LTS         |
| pnpm    | 10.25.0     |

## Environment

App flavor and API configuration via `environment/.env.dev`. See `environment/.env.example` for available variables.
