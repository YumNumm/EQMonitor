# Melos の Dart-only test 選別を修復する

## 背景

root の `test:dart` script は内部で bare `melos exec` を呼ぶため、global melosが
PATHにない環境では、outer commandを`dart run melos`で起動しても
`melos: not found`になる。

さらに現在の`--depends-on=test`条件だけではFlutter SDKに依存する`cache` packageも
選ばれる。これを`dart test`で実行すると`dart:ui`が利用できずcompile failureになる。

## 実施内容

- nested Melos起動をglobal PATHへ依存させない
- Dart-only suiteで`--no-flutter`相当のpackage filterを適用する
- CIとlocalで同じpackage集合が選択される回帰テストを追加する
- Flutter suiteは各package directoryをcwdにしてasset rootを維持する

## 暫定検証コマンド

```bash
mise exec -- dart run melos exec \
  --no-flutter \
  --depends-on=test \
  --dir-exists=test \
  --concurrency=1 \
  -- "dart test"
```

Task 1ではtoolchain migrationのscopeを超えるためscript自体は変更しない。
