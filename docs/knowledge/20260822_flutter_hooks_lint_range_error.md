# flutter_hooks_lint_plugin が RangeError で解析サーバを落とす

`app` 配下の一部 Widget を `dart analyze` すると、`flutter_hooks_lint_plugin` の
`ExhaustiveKeysRule` が `RangeError (length): Invalid value: Only valid value is 0: 1`
で落ちることがある。

発生例（2026-08-22）:

```bash
cd app
mise exec -- dart analyze lib/feature/home/ui/page/home_map_layer_page.dart
```

強震モニタ data 層だけなら通る。

```bash
cd app
mise exec -- dart analyze lib/feature/kyoshin_monitor/data
```

Widget を含む解析がこのエラーで止まったら、対象を data / テストに絞るか、
パッケージルート解析の結果を grep する。plugin クラッシュ自体はアプリの型エラーではない。

関連: `docs/knowledge/20260814_analyzer-plugin-scope-and-exemptions.md`
（ファイル指定だと自作 plugin が動かない件とは別問題）。
