# Stacked PRでGitHub Actionsを起動するbranch filter

## 事象

`pull_request.branches`に`"*"`だけを指定すると、base branch名に`/`を含む
Stacked PRでworkflowが起動しない。

EQMonitorでは最下段のbaseは`develop`なのでworkflowが起動する一方、上段のbaseは
`codex/gpu-map-...`となるため、filterなしのworkflowだけが起動していた。

## 原因

`pull_request.branches`はPRのbase branchへ適用される。GitHub Actionsのglobでは
`*`は`/`を跨がず、`**`は`/`を含むbranch名にも一致する。

## 対応

Stacked PRを許可するworkflowでは次のように指定する。

```yaml
on:
  pull_request:
    branches:
      - "**"
```

`push.branches`は別の起動ポリシーなので、Stacked PR対応だけを目的とする変更では
不用意に変更しない。

## 確認

```bash
mise exec -- actionlint -color
gh run list --repo YumNumm/EQMonitor --branch <head-branch>
gh pr checks <number> --repo YumNumm/EQMonitor
```

最下段だけでなく、base branchに`/`を含む上段PRで`PR Flutter Check`、
`Check GitHub Actions`、`ActionLint`が作成されることを確認する。
