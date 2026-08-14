# Deploy 配布ノートと IS_BETA_TESTING 制御

日付: 2026-08-14

## ルール

- `push` develop の配布ビルドでは `IS_BETA_TESTING` を渡さない
- Release Please PR の `/beta` → `v*-beta.*` タグでは `IS_BETA_TESTING=true`
- `workflow_dispatch` は入力 `is_beta_testing`（既定 false）
- 配布ノートは `generate-release-note-ios` / `generate-release-note-android` が生成する
- 起点は各プラットフォーム前回配信ノートの `rev: <40桁SHA>`
  - iOS: ASC TestFlight test-notes
  - Android: Google Play 対象トラックの release notes
- 内部 TestFlight でも notes を書き、`rev` 連鎖を維持する
- Google Play / Firebase へ渡す前に `truncate_release_note.py` で切り詰め、`rev:` 行は残す

## 確認コマンド

```bash
mise exec -- bash scripts/ci/test_resolve_deploy_app_policy.sh
mise exec -- bash scripts/ci/test_generate_release_note.sh
mise exec -- bash scripts/ci/test_fetch_android_play_base_sha.sh
mise exec -- python3 -m unittest scripts.ci.test_truncate_release_note -v
```
