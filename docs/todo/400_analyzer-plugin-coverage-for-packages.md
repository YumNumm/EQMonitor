# 自作 analyzer plugin が packages/* に適用されていない

## 事象

`dart analyze` を全パッケージで実行したところ、自作 analyzer plugin
（`eqmonitor_lints_plugin` / `eqmonitor_custom_lints`）の診断が
`app` にしか出ていない。

| パッケージ | plugin 由来の診断 |
| --- | ---: |
| `app` | 1,438 件 |
| `packages/seismicity_pmtiles` | 0 件 |
| その他 26 パッケージ | 0 件 |

`packages/*` の Dart コードにトップレベル関数や `!` が 1 つも無いとは考えにくく、
plugin が適用されていないと判断できる。

## 原因

`plugins:` 宣言は `analysis_options.yaml` の解決経路にある必要がある。

- `app/analysis_options.yaml` は `include: ../analysis_options.yaml` で
  ルートの宣言を引き継いでいる（2026-08-14 に修正）
- `packages/seismicity_pmtiles/analysis_options.yaml` は
  `include: package:eqmonitor_lints/recommended.yaml` のみで、
  ルートの `analysis_options.yaml` を参照していない
- 独自の `analysis_options.yaml` を持たないパッケージについては未調査

なお `app/analysis_options.yaml` に直接 `plugins:` を書くと
`plugins_in_inner_options` 警告が出るが、**plugin 自体は動作していた**。
警告が出るからといって無効化されているわけではない点に注意。

## 検討事項

- `packages/*` にも plugin を適用するべきか（ルール自体は Flutter アプリ向けの
  想定が強く、純粋な Dart パッケージに機械的に適用すると大量の違反が出る可能性がある）
- 適用する場合、各パッケージの `analysis_options.yaml` に
  `include: ../../analysis_options.yaml` を足すのか、
  `packages/eqmonitor_lints` 側の共有設定に `plugins:` を持たせるのか
- ルールごとに適用範囲を変えるべきか（例: `avoid_stateful_widget` は
  Flutter パッケージにのみ意味がある）

## 関連

- `docs/superpowers/specs/2026-08-14-analyzer-diagnostics-cleanup-design.md`
- `docs/superpowers/plans/2026-08-14-analyzer-diagnostics-cleanup.md`
