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

## 4. `eqmonitor_map` の既存 baseline test 失敗（develop 由来・回帰ではない）

`flutter test packages/eqmonitor_map` は develop 時点で以下が **既に失敗** する
（`origin/develop` と該当ファイルの diff は無し＝こちらの変更が原因ではない）。
新規変更の回帰と混同しないこと。

- `foundation/frame/map_frame_revision_model_test.dart`
  「does not generate an unchecked copyWith API」
- `foundation/revision/map_revision_metadata_test.dart` 同上
- `foundation/revision/map_revision_result_model_test.dart` 同上
- `tile/mvt/mvt_decoder_test.dart` real PMTiles fixtures 2 件

前者3件は freezed 4.0.0-dev.3 / analyzer 13 skew（`20260813_freezed4_build_runner.md`）
に由来する copyWith 生成差、後者は fixture 解決。focused な tile/foundation/remote/
scheduler test はすべて green。develop baseline が赤なので、製品 PR で無理に緑化せず
baseline 修正は別 PR に分離する方針（`20260814_stacked_pr_flutter_gate_baseline.md`）。
