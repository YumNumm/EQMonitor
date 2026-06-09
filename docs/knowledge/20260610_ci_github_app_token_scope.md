# CI: GitHub App token scope と pinact の注意点

- `actions/create-github-app-token` の `repositories` に、GitHub App インストール対象外のリポジトリを1つでも含めると、トークン発行自体が `422` で失敗する。
- private submodule 用トークンを作るときは、実際にインストール済みのリポジトリだけを `repositories` に列挙する。
- 失敗時ログ例:
  - `There is at least one repository that does not exist or is not accessible to the parent installation.`

## 確認コマンド

```bash
mise exec -- pinact run --check
mise exec -- actionlint .github/workflows/*.yaml
```

## pinact での表記ルール

- `uses:` の pinned SHA コメントは `# vX.Y.Z` のように `#` の後ろに半角スペースを入れる。
  - 例: `uses: owner/action@<sha> # v1.2.3`
