# 開発コマンド設定の整合

- ルート `pubspec.yaml` の `generate` は未定義の `generate:dart` / `generate:flutter` を参照する。既存の `rebuild` に統合するか、参照先を定義する。
- `.vscode/launch.json` は `cwd: app` に対して `environment/.env.dev` / `.env.prod` を指定する。ルートの環境ファイルを参照する `../environment/` に修正する。
- 当面の実行例は `.agents/index.md` の Setup and commands を参照。
