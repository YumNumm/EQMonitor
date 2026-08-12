# CD が GitHub App トークン発行の 401 で全面停止している

## 優先度が高い理由

`develop` への push で走る `Deploy App`（iOS / Android のビルドと配信）と
`Release Please` が、いずれもジョブ冒頭のトークン発行で失敗している。
つまり **2026-08-12 11:06 UTC 以降、develop の変更が一切ストアや
Firebase App Distribution に届いていない**。EEW の不具合修正を出せない状態。

## 症状

`actions/create-github-app-token` が HTTP 401 を返す。

```
Inputs 'owner' and 'repositories' are set. Creating token for the following repositories:
- ***/eqmonitor-backend
Failed to create token for "***/eqmonitor-backend" (attempt 1):
A JSON web token could not be decoded - https://docs.github.com/rest
##[error]A JSON web token could not be decoded
```

`app-id` はログ上 `2980291` と展開されており、
リクエスト先は `GET https://api.github.com/repos/***/eqmonitor-backend/installation`。

### 影響を受けた run

| 日時 (UTC) | ワークフロー | run |
| --- | --- | --- |
| 2026-08-12 11:06 | Deploy App / Release Please | 31590405741 / 31590405744 |
| 2026-08-12 16:52 | Deploy App / Release Please | 31619752023 / 31619751967 |
| 2026-08-12 17:05 | Deploy App / Release Please | 31620848130 / 31620848192 |

最後に成功した Deploy App は 2026-08-08 15:50 UTC の `workflow_dispatch`
（run 31265451764）。`upload-asset-pack` も 2026-08-08 16:08 までは成功しており、
それ以降 App トークンを使う run がすべて失敗し始めている。

PR 側の `wc-check-integration`（`integration-test`）も同じ 401 で落ちるため、
PR の必須チェックも通らない。

## 原因の切り分け

401 かつ `A JSON web token could not be decoded` は、
**App が署名した JWT を GitHub が検証できていない**＝
`private-key` として渡している PEM が壊れている / App の秘密鍵と対応していない、
という意味。インストール対象外リポジトリを指定した場合は `422` になる
（`docs/knowledge/20260610_ci_github_app_token_scope.md` 参照）ので、別事象。

ワークフロー側の差分は原因ではない。同時期にマージされた dependabot の
`3808239f5` は `jdx/mise-action` などの SHA 更新のみで、
`create-github-app-token` のバージョンや入力は変更していない。

## 対応（リポジトリ管理者の作業が必要）

1. GitHub App（App ID `2980291`）の設定画面で秘密鍵を新規生成する
2. ダウンロードした `.pem` の **全文（`-----BEGIN ...` / `-----END ...` 行と改行を含む）**
   を Actions secret `EQMONITOR_GITHUB_APP_PRIVATE_KEY` に貼り直す
   - 改行が失われた 1 行の文字列になっていると、この 401 が再発する
3. Variables の `EQMONITOR_GITHUB_APP_ID` が `2980291` のままか、
   App が `YumNumm/EQMonitor` と `YumNumm/eqmonitor-backend` の両方に
   インストールされたままかも併せて確認する
4. `Deploy App` を `workflow_dispatch` で手動実行し、
   `Generate GitHub App token` と `Stage ... from backend Release` が通ることを確認する

## 併せて検討すること

- `app-id` 入力は deprecated（`Input 'app-id' has been deprecated with message: Use 'client-id' instead.`）。
  秘密鍵を差し替えるタイミングで、App の Client ID を variable に追加して
  `client-id` へ移行するのが望ましい。
- 2026-08-12 16:52 の run では Android 側が別要因（
  `https://github.com/jdx/mise/releases/.../mise-v2026.8.5-linux-x64.tar.zst` が 503、
  `curl: (22)`）で落ちている。単発の一時障害だが、
  頻発するようなら mise のダウンロードにリトライを入れることを検討する。
