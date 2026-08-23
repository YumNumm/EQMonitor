# melos テストを非対話で実行する

`mise exec -- dart run melos run test` は、`test` スクリプト内からグローバルの
`melos` を呼ぶため、グローバルインストールがない環境では開始前に失敗する。
また、`test:dart` のフィルターは Flutter 依存パッケージも含めるため、単純に
`dart test` を適用すると `dart:ui` が見つからず失敗する。

CI や非対話環境では、melos の実体コマンドを直接実行する。

```bash
# Flutter パッケージ
mise exec -- dart run melos exec -c 1 \
  --depends-on flutter_test --dir-exists test -- flutter test

# 純 Dart パッケージ
mise exec -- dart run melos exec -c 1 --no-flutter \
  --depends-on test --dir-exists test -- dart test
```

共有 `/tmp` のクォータ制限がある環境では、上記コマンドにもリポジトリ内の
`TMPDIR` を指定する。詳細は `20260822_flutter_test_tmpdir.md` を参照する。
