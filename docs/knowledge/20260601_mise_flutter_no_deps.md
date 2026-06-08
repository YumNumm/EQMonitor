# Cloud Agent で Flutter だけを検証する場合の mise 実行

Cloud Agent 環境で `mise exec -- flutter ...` を実行すると、`mise.toml` 内の全ツール解決が走り、Swift/gcloud など Flutter 検証に不要なツールのインストール失敗で止まることがある。

Flutter/Dart の対象テストや解析だけを実行する場合は、Flutter ツールを明示し `--no-deps` を付ける。

```bash
/home/ubuntu/.local/bin/mise exec --no-deps flutter@3.44.0-stable -- flutter test <path>
/home/ubuntu/.local/bin/mise exec --no-deps flutter@3.44.0-stable -- flutter analyze
/home/ubuntu/.local/bin/mise exec --no-deps flutter@3.44.0-stable -- dart run build_runner build
```

`mise` が PATH にない場合は `/home/ubuntu/.local/bin/mise` を直接呼び出す。

pre-commit hook などで `mise.toml` 全体の解決が必要な場合、Swift 実行時に `libncurses.so.6` が無いと失敗することがある。その場合は OS パッケージを追加してから再実行する。

```bash
sudo apt-get update
sudo apt-get install -y libncurses6
```
