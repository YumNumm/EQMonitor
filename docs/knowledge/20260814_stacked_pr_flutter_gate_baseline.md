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

**必ず package ディレクトリから実行する。** repository root から
`flutter test packages/<name>` を呼ぶと fixture 解決 root がずれ、本来通る test が
落ちて baseline を誤認する（実測: root 実行 438 passed / 5 failed、package 実行
443 passed / 0 failed、CI も 443 passed）。

```bash
# map tip
mise exec -- dart analyze --fatal-infos packages/eqmonitor_map
(cd packages/eqmonitor_map && mise exec -- flutter test)

# seismicity tip
mise exec -- dart analyze --fatal-infos packages/seismicity_pmtiles packages/pmtiles_v3
(cd packages/seismicity_pmtiles && mise exec -- flutter test)
(cd packages/pmtiles_v3 && mise exec -- flutter test)
```

## 運用

- **waiver は「赤なら baseline」ではなく、既知の失敗集合に一致した場合だけ**適用する。
  primary constructor 由来の失敗は `f0b3bd37`（#1628）で解消済みで、その理由での
  waiver はもう使えない。
- 2026-08-14 時点で共有 Flutter gate が赤い**実際の**内訳は次の3つ。merged PR
  #1628 / #1617 でも同じ4 check（+ 集約の Flutter Status Check）が赤く、iOS build
  のみ green である。これ以外が赤くなったら **回帰として扱う**。
  - `flutter-analyze`: `app/test/feature/tsunami/**` ほかの custom lint 警告 1439 件
    （analyzer error は 0）。`docs/todo/760_existing_eqmonitor_custom_lint_debt.md`
  - `flutter-test`: `app` の `theme_editor_page_test.dart` ほか。
    `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`
  - `eqmonitor-map-scene-spike (Android)`: `packages/eqmonitor_map/example/android/
    app/build.gradle.kts` が AGP 9.0 の `android.newDsl` 既定化に未追随で Gradle
    script compilation error 3件。Dart 変更とは無関係。
- **package 単位の結果を必ず確認する。** CI ログの `[<package>]: 🎉 N tests passed.`
  行を見れば、自分の package が緑かどうかを app の既存赤と切り分けられる。
- baseline 修正は上記3つそれぞれの todo で扱い、地図・震源 PR に混ぜない。
  環境構築と実行方法の詳細は
  `docs/knowledge/20260814_cloud_agent_flutter_toolchain_bootstrap.md`。
- #1602（flutter_scene fork）権限待ちのまま。勝手に merge しない。
