# eqmonitor lintのテストmain警告

## 現象

`app/test` のファイルを対象へ明示して `dart analyze` を実行すると、
Flutterテストに必須のトップレベル `main()` が
`avoid_top_level_functions` として警告される。

```sh
cd app
mise exec -- dart analyze test/feature/example_test.dart
```

`// ignore: avoid_top_level_functions` と
`// ignore_for_file: avoid_top_level_functions` は、現行の
`eqmonitor_lints_plugin` による診断を抑制しない。

## 変更時の検証方法

- productionコードは変更ファイルを指定して `dart analyze` する。
- テストコードは `mise exec -- flutter test <test-path>` でコンパイルと挙動を検証する。
- 効果のないignoreコメントを追加しない。
- app全体のlint debtは `docs/todo/760_existing_eqmonitor_custom_lint_debt.md` で追跡する。

例:

```sh
cd app
mise exec -- dart analyze lib/feature/example/example_page.dart
mise exec -- flutter test test/feature/example/example_page_test.dart
```

lintルール側を修正する場合は、テストファイルの `main()` を除外する契約と、
ignore directiveを尊重する契約をplugin自身のテストで固定する。
