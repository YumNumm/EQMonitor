# 再帰Private SubmoduleのCIトークン対象

## ルール

`actions/checkout` で `submodules: recursive` を使う場合、GitHub Appトークンは
直下のsubmoduleだけでなく、再帰的に取得されるすべてのprivate repositoryを対象にする。

EQMonitorの統合テストでは次のrepositoryが必要になる。

- `YumNumm/EQMonitor`
- `YumNumm/eqmonitor-backend`
- `YumNumm/home8s`

ワークフローの `actions/create-github-app-token` には対象名を明示する。

```yaml
with:
  owner: YumNumm
  repositories: |
    EQMonitor
    eqmonitor-backend
    home8s
  permission-contents: read
```

新しいprivate submoduleを再帰ツリーへ追加した場合は、GitHub Appのinstall対象と
この一覧を同時に更新する。Checkoutログの `Repository not found` は、URL誤りだけでなく
トークン対象からrepositoryが漏れている場合にも発生する。
