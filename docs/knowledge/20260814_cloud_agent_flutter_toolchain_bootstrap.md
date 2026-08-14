---
alwaysApply: false
globs: mise.toml,packages/**/pubspec.yaml
---

# Cloud Agent / Linux での Flutter toolchain 起動と既知の落とし穴

素の Linux 環境(Cursor Cloud Agent 等、`mise` 未導入)で `eqmonitor_map` など
Dart/Flutter パッケージの focused test を回すための手順と、ハマった点の記録。

## 1. mise 導入と Flutter/Dart の起動

```bash
curl -fsSL https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
mise trust /workspace/mise.toml
mise install flutter          # pinned SHA (mise-flutter) を取得。Dart 同梱
```

`mise exec -- dart ...` は **swift まで自動 install しようとして失敗** する
（下記 2 参照）。回避のため、Flutter 同梱の bin を直接 PATH に通して使う:

```bash
FLBIN="$HOME/.local/share/mise/installs/flutter/<PINNED_SHA>/bin"
export PATH="$FLBIN:$HOME/.local/bin:$PATH"
dart --version && flutter --version
flutter pub get               # workspace(resolution: workspace)を root で解決
```

## 2. `mise` が swift 6.3.3 を自動 install して落ちる

- `mise exec` / hk pre-commit hook が env activation 時に全 tools を解決し、
  `core:swift@6.3.3` の install で失敗する。
  - `swift ... error while loading shared libraries: libncurses.so.6`
  - 環境に `libncursesw.so.6` はあるが `libncurses.so.6` が無い。
- 対処:
  - コミット時など hook 経由では `MISE_DISABLE_TOOLS=swift` を付ける。
    ```bash
    MISE_DISABLE_TOOLS=swift git commit -m "..."
    export MISE_DISABLE_TOOLS=swift   # session 全体に効かせる
    ```
  - swift 自体は Dart/Flutter 作業に不要。macOS CI では別途入る。
- pre-commit hook（gitleaks 等）は `MISE_DISABLE_TOOLS=swift` を付ければ通常どおり
  走る（gitleaks の secret scan も動く）。`--no-verify` は極力使わない。

## 3. build_runner

```bash
cd packages/eqmonitor_map
dart run build_runner build   # --delete-conflicting-outputs は新版で無視される警告のみ
```

`W SDK language version 3.14.0 is newer than analyzer language version 3.13.0`
の警告が出るが生成自体は成功する。

## 4. package test は **必ず package ディレクトリから** 実行する

repository root から `flutter test packages/<name>` を呼ぶと、asset / fixture の
解決 root がずれて **本来通るテストが落ちる**。CI（`wc-check-dart-test.yaml` /
`melos exec`）は各 package ディレクトリ内で `flutter test` を実行しており、
こちらが正。

```bash
# ❌ 誤り: repository root から呼ぶ（fixture 解決がずれて false failure）
flutter test packages/eqmonitor_map

# ✅ 正しい: package ディレクトリで呼ぶ（CI と同じ）
cd packages/eqmonitor_map && flutter test
```

実測（2026-08-14, `feat/eqmonitor-map-tile-pipeline`）:

| 実行方法 | 結果 |
| --- | --- |
| root から `flutter test packages/eqmonitor_map` | 438 passed / **5 failed** |
| `cd packages/eqmonitor_map && flutter test` | **443 passed / 0 failed** |
| CI `flutter-test` job | `[eqmonitor_map]: 🎉 443 tests passed.` |

root 実行時だけ落ちていたのは次の5件で、いずれも **baseline 失敗ではなく
実行方法による false failure** だった。baseline 扱いして waive しないこと。

- `foundation/frame/map_frame_revision_model_test.dart`
- `foundation/revision/map_revision_metadata_test.dart`
- `foundation/revision/map_revision_result_model_test.dart`
- `tile/mvt/mvt_decoder_test.dart` real PMTiles fixtures 2 件

同種の注意は `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`
（`app/` を working directory にする理由）にも記録がある。

## 5. 共有 Flutter gate の実際の赤（develop 由来）

`flutter-analyze` / `flutter-test` / `eqmonitor-map-scene-spike (Android)` /
`Flutter Status Check` は develop baseline で赤。merged PR #1628 / #1617 でも
まったく同じ4つが赤（iOS build のみ green）なので、地図・震源 PR の回帰ではない。

- `flutter-analyze`: `app/test/feature/tsunami/**` などの custom lint 警告 1439 件
  （error は 0）。`docs/todo/760_existing_eqmonitor_custom_lint_debt.md`
- `flutter-test`: `app` の `theme_editor_page_test.dart` ほか。
  `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`
- `eqmonitor-map-scene-spike (Android)`: `packages/eqmonitor_map/example/android/app/
  build.gradle.kts` が AGP 9.0 の `android.newDsl` 既定化に追随できておらず
  Gradle script compilation error 3件（`android {}` deprecated、`profile {}` /
  `signingConfig` unresolved）。Dart 変更とは無関係。
