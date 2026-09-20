# OpenAPIのdiscriminatorなしunionをDartクライアントに取り込むとき

Backend submoduleの `openapi.json` に `oneOf` / `anyOf` unionが追加されたら、
`packages/eqmonitor_api/bin/generate.dart` で生成結果を確認する。
discriminatorがないunionは `swagger_parser` が `fromJson` を
`throw UnimplementedError()` のまま生成することがある。

## 対応

1. variantを一意に判定できるJSONフィールドをBackendの契約から確認する。
2. `generate.dart` の `_patchUnionFromJson` を使う専用パッチを追加する。
3. 対象モデルの単体テストで、unionの全variantのJSONをパースする。

例: `Earthquake.hypocenters` は `datasource` で判別する。

- `JMA_DISASTER_INFORMATION_XML`: XML電文由来
- `JMA_INTENSITY_DATABASE`: 震度データベース由来

## 検証コマンド

```sh
mise exec -C packages/eqmonitor_api -- dart run bin/generate.dart
mise exec -C packages/eqmonitor_api -- dart test
```

Backend更新後は生成コードのコンパイルだけでなく、
対象モデルのデシリアライズも個別の単体テストで確認する。api-stub 由来の契約 drift テストは #1802 に伴い削除済み。
