# Dart client ↔ api-stub 結合テストの削除

- `packages/eqmonitor_api/test/integration/` と専用の integration タグ設定を削除した。
- PR CI の専用結合テストジョブと、ステータスチェックからの依存も削除した。
- API パッケージの既存テストは、stub の起動やタグ除外なしで実行する。

```bash
cd packages/eqmonitor_api
mise exec -- dart test
mise exec -- dart analyze
```

- 契約 drift テストはコミット済み fixture を使うため、引き続き通常のテストで実行される。
