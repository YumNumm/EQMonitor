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

`eqmonitor_map` は Flutter SDK 依存のため `dart test` では `dart:ui` を解決できない
（`docs/todo/700_melos_dart_test_package_filter.md`）。`flutter test` を使う。

```bash
# map tip
mise exec -- dart analyze --fatal-infos packages/eqmonitor_map
mise exec -- flutter test packages/eqmonitor_map

# seismicity tip
mise exec -- dart analyze --fatal-infos packages/seismicity_pmtiles packages/pmtiles_v3
mise exec -- flutter test packages/seismicity_pmtiles packages/pmtiles_v3
```

## 運用

- **waiver は「赤なら baseline」ではなく、既知の失敗集合に一致した場合だけ**適用する。
  primary constructor 由来の失敗は `f0b3bd37`（#1628）で解消済みで、その理由での
  waiver はもう使えない。
- 2026-08-14 時点で `flutter test packages/eqmonitor_map` に残る develop 由来の
  既知失敗は次の5件のみ。これ以外が赤くなったら **回帰として扱う**。
  - `foundation/frame/map_frame_revision_model_test.dart`（unchecked copyWith）
  - `foundation/revision/map_revision_metadata_test.dart`（同上）
  - `foundation/revision/map_revision_result_model_test.dart`（同上）
  - `tile/mvt/mvt_decoder_test.dart` の real PMTiles fixtures 2件
- 判定手順: 失敗 test の対象ファイルが `origin/develop` と diff 無しであることを
  `git diff origin/develop -- <path>` で確認してから baseline 扱いにする。
- baseline 修正は SDK / Freezed / analyzer の整合合わせ。地図・震源 PR に混ぜない。
  詳細は `docs/knowledge/20260814_cloud_agent_flutter_toolchain_bootstrap.md`。
- #1602（flutter_scene fork）権限待ちのまま。勝手に merge しない。
