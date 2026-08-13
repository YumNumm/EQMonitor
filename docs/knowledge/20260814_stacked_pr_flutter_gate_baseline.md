# Stacked PR Flutter gate: 製品失敗と develop baseline の切り分け (2026-08-14)

## 対象 PR

- Map: #1616 → develop, #1617 → #1616
- Seismicity: #1619 → develop, #1620 → #1619

いずれも tip は `origin/develop` に対して **behind 0**（develop merge 不要）。

## 共有 Flutter Status Check が赤になる主因（baseline）

`PR Flutter Check` の `flutter-analyze` / `integration-test` は、**本スタック固有ではなく develop 上のコードでも再現**する。

### 1. Primary constructor が analyzer にフィールドとして見えない

再現（seismicity tip / develop 同等）:

```bash
mise exec -- dart analyze --fatal-infos \
  app/lib/feature/devices/data/retry/retry_controller.dart \
  app/lib/feature/devices/ui/component/device_provisioning_banner.dart
```

`RetryRunning({required int attempt})` 形式の primary constructor に対し、`RetryRunning(:final attempt)` が `undefined_getter` になる。Dart 3.14.0-29.0.dev（Flutter `4dacd3fc91`）の analyzer 側不整合。地図・震源差分ではない。

### 2. Freezed 生成物の `final` modifier エラー

`integration-test` は `*.freezed.dart` で `Can't have modifier 'final' here` が多発。toolchain / Freezed 4 dev と SDK の組み合わせ問題。地図・震源差分ではない。

### 判定

| Check | 製品（stack）失敗? | 備考 |
|---|---|---|
| flutter-analyze（devices/knet 等） | No（baseline） | develop でも同系統 |
| integration-test（freezed final） | No（baseline） | develop でも同系統 |
| flutter-test | 多くは cascade / baseline | analyze 失敗後 cancel もあり |
| eqmonitor-map-scene-spike / iOS | Yes 寄与なし（pass） | |
| eqmonitor-map-scene-spike / Android | **develop baseline** の `prefer_initializing_formals` | map tip（#1617）では修正済。seismicity tip は develop の spike をそのまま持つため赤。#1616/#1617 merge 後に消える見込み |
| actionlint / gitleaks / zizmor / pinact | pass | |

## 製品側の focused gate（これで stack を判定する）

```bash
# map tip
mise exec -- dart analyze --fatal-infos packages/eqmonitor_map
mise exec -- dart test packages/eqmonitor_map

# seismicity tip
mise exec -- dart analyze --fatal-infos packages/seismicity_pmtiles packages/pmtiles_v3
mise exec -- dart test packages/seismicity_pmtiles packages/pmtiles_v3
```

## 運用

- 共有 Flutter Status Check が赤でも、上記 focused gate が緑なら **stack 製品としては merge 判断材料にする**（branch protection が status check 必須なら、baseline 修正 PR が別途必要）。
- baseline 修正は primary constructor の通常コンストラクタ化、または SDK/Freezed 整合。地図・震源 PR に混ぜない。
- #1602（flutter_scene fork）権限待ちのまま。勝手に merge しない。
