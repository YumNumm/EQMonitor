# Claude Code 向けガイド

EQMonitor は、地震情報・緊急地震速報・強震モニタを扱う Flutter アプリです。

## 最初に読むもの

- [共通エージェントガイド](.agents/index.md): セットアップ、検証、設計ルール、GitHub 操作の正本。
- [知見ガイド](docs/knowledge/README.md): 作業に関係する分野だけ参照する。知見・TODO を全件読み込む必要はありません。

コマンドやバージョン表はここへ複製せず、共通ガイドと `mise.toml`・lockfile を確認してください。
アプリは `app/`、共有パッケージは `packages/`、独立した private submodule のバックエンドは `backend/` にあります。
バックエンドを変更する場合は、そのリポジトリの指示を先に読んでください。
