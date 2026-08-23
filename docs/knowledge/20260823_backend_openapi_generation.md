# バックエンド OpenAPI の生成手順

バックエンドの `generate:openapi` は生成結果を標準出力へ出すだけで、
`api/api/openapi.json` 自体は更新しない。スキーマ変更後はリダイレクトして保存する。

```shell
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api generate:openapi \
  > backend/api/api/openapi.json
mise exec -- dart run packages/eqmonitor_api/bin/generate.dart
```

生成後は、追加したプロパティがバックエンドの OpenAPI と Dart の生成型の
両方に存在することを確認する。

```shell
rg 'max_intensity_class' backend/api/api/openapi.json \
  packages/eqmonitor_api/lib/src/models
```
