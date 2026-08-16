---
description: PR / Issue の作成先を YumNumm org に限定する
alwaysApply: true
---

# GitHub / Pull Request・Issue（厳守）

- **PR と Issue を作成してよいのは YumNumm org のリポジトリのみ。upstream へは絶対に作成しない。**
- `gh pr create` / `gh issue create` では `--repo YumNumm/<repo>` を**必ず明示する**。省略禁止。
- 特に `third_party/flutter_scene` は `bdero/flutter_scene` の fork の submodule であり、この配下では `gh` が既定の送信先を **upstream** にする。`--repo` を省略すると upstream へ PR が飛ぶ。
- EQMonitor 本体のメインブランチは `develop`。PR のベースブランチは `develop` を指定する。
- Claude Code では `.claude/settings.json` の PreToolUse フックが `--repo YumNumm/` を含まない `gh pr create` / `gh issue create` を deny する。**このフックは Claude Code でしか動かない**ため、他のエージェント（Codex 等）では本ルールを自分で守ること。
