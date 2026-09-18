# クリーンなworktreeでFlutter Testを実行する際のSourcePackages作成

## 症状

クリーンなworktreeで初めて `flutter test` を実行すると、
Apple向けプラグインの同期処理が次のエラーで停止する場合がある。

```text
rsync: [Receiver] mkdir "app/build/ios/SourcePackages/<plugin>" failed:
No such file or directory
```

macOS向けの同期では `app/build/macos/SourcePackages` でも同様に停止する。
テストコードや製品コードのコンパイルより前に発生するため、
テスト失敗とは分けて判断する。

## 回避手順

`app` ディレクトリで、同期先の親ディレクトリを作成してから再実行する。

```shell
mkdir -p build/ios/SourcePackages build/macos/SourcePackages
mise exec -- flutter test <test-path>
```

`build/` は生成物でありGit管理対象ではない。
依存関係は先にリポジトリルートでロックファイルどおり解決する。

```shell
mise exec -- dart pub get --enforce-lockfile
```

再実行時は、`All tests passed!` と終了コード0の両方を確認する。
