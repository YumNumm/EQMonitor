# Flutter workspace でアプリの Widget テストを実行する場所

## ルール

`app/` 配下の Widget テストは、workspace ルートではなく `app/` を
カレントディレクトリにして実行する。

```bash
cd app
mise exec -- flutter test test/feature/example_test.dart
```

workspace ルートから `app/test/...` を指定すると、ルート側の
`pubspec.yaml` を基準にテストアセットが構築される場合がある。
その場合、`app/assets/...` が見つからず `Unable to load asset` になる。

シェーダー生成が `impellerc failure: Could not write file` で止まり、
`app/build/unit_test_assets` に前回の生成物が残っている場合は、
アプリパッケージで生成物を消してから再実行する。

```bash
cd app
mise exec -- flutter clean
mise exec -- flutter test test/feature/example_test.dart
```
