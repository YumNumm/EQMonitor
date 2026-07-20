# Flutter Native Assets の Linux コンパイラ要件

Linux で `libserialport_plus` など Native Assets を含む依存関係を利用する場合、
Flutter のテストや解析でもホスト上の C コンパイラが必要になる。

## 症状

`flutter test` などが次のエラーで失敗する。

```text
No compiler configured on host 'linux_x64'
```

## 対応

Ubuntu / Debian 環境では Clang をインストールし、Flutter / Dart コマンドは
プロジェクト規約どおり `mise exec --` 経由で実行する。

```shell
sudo apt-get update
sudo apt-get install -y clang
command -v clang
mise exec -- flutter test
```

依存関係更新後にこのエラーが発生した場合は、コードの回帰と判断する前に
コンパイラの有無を確認し、同じコミットで対象テストを再実行する。
