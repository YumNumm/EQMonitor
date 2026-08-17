---
alwaysApply: true
---

# `dart format` のバージョン差異による意図しない差分に注意

## 事象

このクラウドエージェント環境の Dart SDK（3.14.0）に同梱される `dart format` を
既存ファイルにかけると、コミット履歴上の既存フォーマットと異なる出力になる箇所がある。

例:

```bash
cd app && mise exec -- dart format --output=none --set-exit-if-changed \
  lib/feature/tsunami/data/model/value/revise.dart
# → 何も編集していないファイルなのに Changed と判定される
```

差分の傾向:

- `Theme.of(context).textTheme.bodySmall?.copyWith(...)` のようなメソッドチェーンの
  折り返し位置が変わる（`?.copyWith` が改行前に来る/来ない）
- 日本語（全角文字）を含む文字列リテラルの折り返し判定が変わり、
  80 桁を超えていても 1 行にまとめられるケースがある
- 末尾カンマ付きの短い `expect(...)` などが 1 行に畳まれる

## 対処方針

- 既存ファイルに小さな変更（import 追加など）を加える場合、
  ファイル全体に `dart format` をかけると無関係な広範囲の差分が発生する。
  その場合は **変更した行だけを手動で整形し、ファイル全体の再フォーマットは避ける**。
- 新規作成したファイルは `dart format <新規ファイルパス>` を個別に指定してかけて問題ない
  （比較対象の既存フォーマットがないため無関係な差分は発生しない）。
- ディレクトリ全体に対して `dart format <dir>` を実行すると、意図しないファイルまで
  変更されるため、コミット前に必ず `git diff --stat` で差分範囲を確認すること。
- 恒久対応（CI の `dart format` バージョンと合わせる、リポジトリ全体を再フォーマットする等）は
  別タスクとして検討する。`docs/todo/` に起票済み。
