# Codex worktree の flutter_scene 初期化

Codex の新規 worktree では Git submodule の作業ツリーは自動展開されない。
`flutter pub get` より先に、path 依存で必要な public submodule だけを初期化する。

```bash
git submodule update --init --depth 1 third_party/flutter_scene
mise exec flutter -- flutter pub get
```

`git submodule update --init --recursive` は使用しない。Dart workspace に不要な
private `backend` まで取得し、GitHub 認証がないローカル環境ではセットアップ全体が
失敗するためである。
