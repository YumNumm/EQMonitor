# mise worktree trust

## ルール

`git worktree` で作った checkout では、元 checkout と同じ `mise.toml` でも未 trust と判定されることがある。
Flutter / Dart コマンドや commit hook が `mise exec --` を呼ぶ場合、先に worktree 側の `mise.toml` を trust する。

## コマンド例

```bash
mise trust /home/yumnumm/EQMonitor/.worktrees/<worktree-name>/mise.toml
mise exec -- flutter test app/test/core/realtime/eqmonitor_ws_provider_test.dart
```

## 注意

`mise trust` はローカルの信頼設定を永続変更するため、エージェントが実行する場合はユーザーの明示承認後に行う。

