# GitHub Actions の Dart analyzer 注釈

## 方針

Flutter SDK を mise で固定している workflow では、analyzer 用 Action に解析を委譲しない。
固定 SDK の `dart analyze` を直接実行し、GitHub problem matcher で注釈へ変換する。

```yaml
- name: Register Dart analyzer problem matcher
  run: echo "::add-matcher::.github/problem-matchers/dart-analyzer.json"

- name: Analyze app
  run: mise exec -- dart analyze app --fatal-infos --format machine
```

matcher は `.github/problem-matchers/dart-analyzer.json` で管理する。
追加の Dart SDK を導入すると Flutter 同梱 SDK と PATH が競合するため、
matcher 登録だけを目的に `dart-lang/setup-dart` を追加しない。

## machine 形式が必要な理由

`dart analyze app` の通常出力は、実行位置にかかわらず解析対象からの相対パス
（`lib/...`）を出力する。GitHub problem matcher は実在しないファイルや
リポジトリ外のファイルを注釈対象から落とすため、root の `lib/...` と誤認される。

`--format machine` はファイルを絶対パスで出力する。matcher は次の順序を扱う。

```text
SEVERITY|TYPE|CODE|FILE|LINE|COLUMN|LENGTH|MESSAGE
```

Dart 3.11 では `dart analyze --help` に表示されないが、machine 形式は利用できる。
SDK 更新時は、実データのフィールド順と絶対パス出力を必ず再確認する。

## 終了条件と権限

`--fatal-infos` を維持し、info を含む diagnostics で job を失敗させる。
problem matcher は runner の workflow command を使うため、`checks: write` は不要で、
workflow の権限は `contents: read` のみにする。
解析失敗を成功扱いにするフォールバックや Node 20 許可設定は追加しない。

## ローカル検証

```shell
mise exec -- dart pub get --enforce-lockfile
jq empty .github/problem-matchers/dart-analyzer.json
mise exec -- actionlint .github/workflows/wc-check-dart-analyze.yaml
mise exec -- dart analyze app --fatal-infos --format machine
```

既存 diagnostics で最後のコマンドが非ゼロ終了する場合は、matcher や workflow の
構文不良と分けて扱う。先頭の machine 行で絶対パスとフィールド順を確認する。
