# api-stub 結合テスト・契約 drift テストの削除

- `packages/eqmonitor_api/test/integration/` と専用の integration タグ設定を削除した。
- PR CI の専用結合テストジョブと、ステータスチェックからの依存も削除した。
- API パッケージの既存テストは、stub の起動やタグ除外なしで実行する。

```bash
cd packages/eqmonitor_api
mise exec -- dart test
mise exec -- dart analyze
```

- #1802 に伴い契約 drift テスト、生成 fixtures の検証テスト、契約 fixtures 一式も削除した。
- `bin/generate.dart` は backend の契約 fixtures をコピーしない。OpenAPI の取り込みとクライアント生成は継続する。

```bash
cd packages/eqmonitor_api
mise exec -- dart run bin/generate.dart
```

生成手順のみの変更を検証するときは、変更を反映した検証用コピーに固定された backend commit の
`api/api/openapi.json` を配置して実行できる。契約 fixtures や api-stub の起動は不要。
今回もこの構成で生成完走を確認した。
