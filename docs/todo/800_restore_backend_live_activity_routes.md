# backend Live Activity ルート欠落の復元

## 概要

backend submodule（`3de810ef` / origin/main）から以下が欠落している。

- `POST /v2/device/me/live-activity/test`
- `POST /v2/device/me/live-activity/test/{id}/update`
- `POST /v2/device/me/live-activity/test/{id}/end`
- Live Activity updateToken の get/put/delete
- 実装ファイル `api/api/src/features/device/routes/live-activity-test.ts`

揺れ検知 snapshot 系のマージ過程で OpenAPI・実装が落ちた可能性が高い。アプリ側はコンパイル復旧済みだが、デバッグ Live Activity と本番 updateToken 同期は backend 復元が必要。

## やること

1. `83448697`（Live Activity テスト + レート制限）周辺からルート実装・モデル・OpenAPI を復元
2. `/v2/shake-detection/active` と共存することを確認
3. OpenAPI 再生成 → `eqmonitor_api` / Swift EQMonitorAPI を再生成
4. 回帰テスト（start/update/end、updateToken）

## 参照

- `docs/knowledge/20260721_eqmonitor_api_regen_must_preserve_live_activity.md`
- backend commit: `6757aee5` / `83448697`
