# 市区町村最大震度 API の集計時刻は aggregated_at

## 結論

`GET /v2/earthquake/intensity/city/max` の集計時刻は `response_at` ではなく `aggregated_at`。
アプリの最終更新時刻表示は `CityMaxIntensity.aggregatedAt` を使う。shake detection などの別用途 `responseAt` は混ぜない。

本番 API（eqmonitor-api v2.0.2）は `aggregated_at` を返す。クライアントが `response_at` のままだとデシリアライズ結果が常に null になり、震度履歴画面の最終更新時刻が出ない。

## 更新手順

backend submodule を対象タグへ合わせてから、OpenAPI 経由で `eqmonitor_api` を再生成する。手元の `packages/eqmonitor_api/openapi/openapi.json` は gitignore されており、生成元は submodule 側の `backend/api/api/openapi.json`。

```bash
git -C backend fetch origin
git -C backend checkout eqmonitor-api-v2.0.2
cd packages/eqmonitor_api
mise exec -- dart run bin/generate.dart
```

再生成後は `CityMaxIntensityResponse.aggregatedAt` とアプリモデル `CityMaxIntensity.aggregatedAt` を揃える。

## 受け入れ確認

- `aggregated_at` が日時なら震度履歴パネルに「最終更新」が出る
- `aggregated_at` が null でも `items` は表示される
- `packages/eqmonitor_api/test/city_max_intensity_response_test.dart` が通る
