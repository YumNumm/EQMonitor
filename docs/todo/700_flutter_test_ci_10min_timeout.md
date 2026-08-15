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

run 31859725902 / job の実測値:

- job 全体: 約 13 分（setup 約 2 分 + テスト実行 約 11 分）
- 10 分の内訳では setup に約 2 分かかるため、テストの持ち時間は実質 8 分しかない
- テストは hang しておらず、cancel 直前まで結果を出力し続けていた

**10 分では原理的に完走できない**ため、`timeout-minutes` を触らない限り
`flutter-test` は常に cancel され、テスト結果を CI で確認できない。
上記「対応方針」の 1 → 2 を実施し、その結果として 3 を決めること。

また、timeout で打ち切られていた区間に既存の失敗が隠れていた。
`packages/eqmonitor_api/test/feed_nankai_parse_test.dart` の 2 件は
`docs/todo/770_existing_eqmonitor_flutter_test_failures.md` に未記載だったが、
完走させると失敗する（詳細は 770 の追記を参照）。

## 関連

- `docs/todo/770_existing_eqmonitor_flutter_test_failures.md`（既存のテスト失敗 18 件）
- `docs/todo/760_existing_eqmonitor_custom_lint_debt.md`（`flutter-analyze` の既存負債）
