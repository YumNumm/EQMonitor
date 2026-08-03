# 再帰Private SubmoduleのCIトークン対象

## ルール

`actions/checkout` で `submodules: recursive` を使う場合、GitHub Appトークンは
直下のsubmoduleだけでなく、再帰的に取得されるすべてのprivate repositoryを対象にする。
ジョブがnested submoduleを必要としない場合は `submodules: true` を使い、直下だけを取得する。

EQMonitorのAPI統合テストでは次のrepositoryだけが必要になる。

- `YumNumm/EQMonitor`
- `YumNumm/eqmonitor-backend`

ワークフローの `actions/create-github-app-token` には対象名を明示する。

```yaml
with:
  owner: YumNumm
  repositories: |
    EQMonitor
    eqmonitor-backend
  permission-contents: read
```

Checkoutは `submodules: true` とし、backend配下の `home8s` などを取得しない。
`recursive` が必要なジョブでは、nested private repositoryをGitHub Appのinstall対象と
トークンの `repositories` 一覧へ同時に追加する。Checkoutログの `Repository not found` は
URL誤りだけでなく、トークン対象からrepositoryが漏れている場合にも発生する。
