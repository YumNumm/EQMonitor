# CI の `flutter-test` が 10 分の timeout で打ち切られる

## 現象

`PR Flutter Check` の `flutter-test / Flutter Test` が、テスト失敗 0 件のまま
`##[error]The operation was canceled.` で failure になる。ジョブ実行時間は
`10m17s` で、`wc-check-dart-test.yaml` の `timeout-minutes: 10` に張り付いている。

実測例（2026-08-14 / run 31790096949 job 94734931270）:

- ログ全体に `❌` は 1 件も無く、個別テストの失敗は発生していない
- `09:56` 開始 → `10:06:07` にキャンセル。`eqmonitor` package のテスト実行途中で打ち切り
- monorepo 全体（24 packages）を `melos exec --concurrency=4` で回しており、
  総実行時間が 10 分に収まらなくなっている

## 影響

- テストが健全でも `flutter-test` が blocking failure になり、PR のマージ判定に使えない
- 「テストが落ちた」のか「時間切れ」なのか、チェック名からは区別できない

## 対応方針

`timeout-minutes` を単純に引き上げるだけでは実行時間の増加を追い続けることになるため、
以下を検討する。

1. 遅い package / テストを計測して特定する（`--file-reporter` の JSON から所要時間を集計）。
2. package ごとに job を分割し matrix 並列化する。`melos exec --concurrency=4` の
   単一 job 構成が直列ボトルネックになっている。
3. その上で残る実行時間に見合った `timeout-minutes` を設定する。

「落ちているテストを通す」目的で `timeout-minutes` だけを緩める変更は行わない。

## 追記 (2026-08-15): 所要時間の実測

`timeout-minutes` を一時的に 25 分へ上げて計測した（PR #1648 で計測後 revert 済み。
方針に反する単純な引き上げは行わない）。

同一ブランチの連続 run での job 所要時間（`Flutter Test` job）:

| run | timeout | 所要時間 | 結果 |
| --- | --- | --- | --- |
| 31858584545 | 10 分 | 10m18s | cancelled（テスト実行の途中） |
| 31859725902 | 25 分 | 9m50s | 完走してテスト失敗を報告 |
| 31860359349 | 10 分 | 9m37s | 完走してテスト失敗を報告 |

**所要時間が 10 分ちょうどに張り付いており、runner の速度差で完走するかどうかが
変わる**。テストは hang しておらず、cancel 直前まで結果を出力し続けていた。
つまり `flutter-test` は現状 **間欠的に** timeout し、赤の理由が
「テスト失敗」か「時間切れ」か run ごとに変わる。

上記「対応方針」の 1 → 2 を実施し、その結果として 3 を決めること。

完走させたときの失敗内訳は `eqmonitor` が 1664 passed / 6 failed、
`eqmonitor_api` が 84 passed / 2 failed / 16 skipped。
`eqmonitor_api` の 2 件は
`docs/todo/770_existing_eqmonitor_flutter_test_failures.md` に未記載だった
（timeout で打ち切られる run では結果が出ないため見落とされていた）。
詳細は 770 の追記を参照。

## 関連

- `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`（既存のテスト失敗 18 件）
- `docs/todo/760_existing_eqmonitor_custom_lint_debt.md`（`flutter-analyze` の既存負債）
