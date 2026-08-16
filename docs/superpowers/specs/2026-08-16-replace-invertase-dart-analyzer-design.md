# Invertase Dart Analyzer Action 置換設計

## 背景

`wc-check-dart-analyze.yaml` は、解析と GitHub 上の注釈に
`invertase/github-action-dart-analyzer` を使用している。
この Action は archive 済みで、実行ランタイムも Node 20 のままである。
一時的に Node 20 を許可する環境変数は使用せず、保守されない Action を除去する。

## 目的

- mise で固定した Flutter 同梱の Dart SDK を使用する。
- `app` の解析と `--fatal-infos` による blocking 動作を維持する。
- analyzer diagnostics を GitHub Actions のファイル注釈として表示する。
- `eqmonitor_lints_plugin` と `eqmonitor_custom_lints` を引き続き実行する。
- analyzer の実行にサードパーティー Action を使用しない。

## 採用する構成

リポジトリ内に Dart analyzer 出力用の GitHub problem matcher を置く。
workflow で matcher を登録した後、次のコマンドをリポジトリルートから実行する。

```shell
mise exec -- dart analyze app --fatal-infos
```

matcher は Dart 公式 `dart-lang/setup-dart` の matcher と同様に、
現在使用されるハイフン区切りと従来の中黒区切りの両形式を扱う。
診断の severity、ファイル、行、列、メッセージ、診断コードを抽出する。

## Workflow の権限

problem matcher の注釈は runner の workflow command で生成する。
Checks API を直接呼ばないため、workflow と job の `checks: write` を削除し、
`contents: read` のみを残す。

## エラー時の動作

matcher の登録は解析より前に行う。解析が error、warning、または info を検出した場合、
`--fatal-infos` によってステップと job を失敗させる。
SDK の導入、依存解決、plugin の起動に失敗した場合も、その終了コードをそのまま伝播する。
固定値や解析成功扱いへのフォールバックは設けない。

## 検証

- problem matcher JSON が有効な JSON であることを確認する。
- analyzer の代表的な両出力形式が matcher の正規表現に一致することを確認する。
- `actionlint` で変更後の workflow を検証する。
- mise 経由で実際の `dart analyze app --fatal-infos` を実行し、解析経路を確認する。
- workflow から Invertase Action と Node 20 一時許可設定が消えていることを検索する。

既存の analyzer debt によって解析が失敗する場合は、置換とは分離して結果を報告する。
この変更では既存 diagnostics の修正や解析対象の拡大は行わない。
