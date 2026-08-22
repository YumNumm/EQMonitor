# Flutter テストの一時領域を worktree 内へ切り替える

## 症状

共有 `/tmp` の使用量やユーザー quota が上限に達すると、Flutter テストの
compiler が次のエラーで終了する。

```text
FileSystemException: writeFrom failed ... Disk quota exceeded
```

## 対応

ソースや他タスクの `/tmp` を削除せず、ignore 済みの `.dart_tool` 配下を
そのコマンドだけの一時領域として使う。

```shell
mkdir -p .dart_tool/codex-temp
TMPDIR="$PWD/.dart_tool/codex-temp" mise exec -- flutter test app/test/...
```

Flutter / Dart コマンドは通常どおり `mise exec --` 経由で実行する。
