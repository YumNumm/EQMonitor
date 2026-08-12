# CD が落ちたときの切り分け手順と GitHub App トークンの 401

## CD の稼働確認コマンド

```bash
# Deploy App（develop への push で走る CD）の直近の結果
gh run list --workflow=deploy-app.yaml --limit 10

# 失敗した run の全体像（どのジョブ・どのステップで落ちたか）
gh run view <run-id>

# 失敗ステップのログのみ
gh run view <run-id> --log-failed
```

`gh run list --limit 25` は PR チェックまで混ざるため、CD の生死を見るときは
`--workflow=deploy-app.yaml` を付ける。

## `actions/create-github-app-token` のエラーコード対応表

| status | メッセージ | 意味 |
| --- | --- | --- |
| 401 | `A JSON web token could not be decoded` | `private-key` の PEM が壊れている / App の鍵と不一致。secret の貼り直しが必要 |
| 422 | `There is at least one repository that does not exist or is not accessible...` | `repositories` に App 未インストールのリポジトリが混ざっている（`20260610_ci_github_app_token_scope.md`） |
| 404 | `Not Found`（`/installation`） | App がそのリポジトリにインストールされていない |

401 は**ワークフローの書き方では直らない**。App ID / 秘密鍵という認証情報側の問題なので、
コードを触る前に secret の状態を疑う。

## secret に PEM を入れるときの注意

`EQMONITOR_GITHUB_APP_PRIVATE_KEY` には `.pem` の全文を改行込みで貼る。
`-----BEGIN`/`-----END` 行を落としたり、改行を除いて 1 行にすると、
JWT の署名が作れず上記 401 になる。

## トークン発行が落ちると同時に止まるもの

App トークンは以下のワークフローが共有しているため、
鍵が壊れると CD だけでなく PR チェックとリリース自動化も同時に止まる。

```bash
rg -l "EQMONITOR_GITHUB_APP_PRIVATE_KEY" .github/workflows
# deploy-app.yaml / release-please.yaml / upload-asset-pack.yaml
# create-beta-release.yaml / pr-flutter-check.yaml / wc-check-integration.yaml
```

「複数のワークフローが同時刻から一斉に失敗し始めた」場合は、
個別のジョブを追う前にこの共有トークンを最初に確認するのが速い。
