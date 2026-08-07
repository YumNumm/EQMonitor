# 地図タップ地点の地域判定は Worker Isolate 経由で行う

`JmaMapUtility().findNearestItem` は protobuf の各ポリゴンを
`Polygon.decode` / `MultiPolygon.decode` しながら内外判定するため、
main isolate で呼ぶと UI が固まる。`AREA_INFORMATION_CITY` は 1,911 件、
`AREA_FORECAST_LOCAL_E` は 193 件あり、市区町村判定はタップごとに数百 ms 規模の
ジャンクになる。

## ルール

判定は `app/lib/feature/location/data/nearest_jma_feature.dart` の provider
経由で行う。常駐 Worker Isolate（`jmaMapIsolateProvider`）上で実行される。

```dart
final city = await ref.read(
  jmaMapAreaInformationCityInsideProvider(LatLng(point.lat, point.lon)).future,
);
final code = city?.property?.code;
```

- `jmaMapAreaForecastLocalEInsideProvider`: 細分区域（3 桁コード）
- `jmaMapAreaInformationCityInsideProvider`: 市区町村（7 桁コード）
- `jmaMapAreaForecastLocalEewInsideProvider`: EEW 用区域（4 桁コード）
- `jmaMapAreaTsunamiNearestProvider`: 津波予報区（海岸線までの距離も返す）

地図を全画面で使うページでは、初回タップを待たせないよう
`ref.watch(jmaMapIsolateProvider)` で Isolate を事前に温めておく。

## `queryLayers` との使い分け

`MapController.queryLayers(screenPoint)` は「命中したレイヤー」しか返さず、
フィーチャのプロパティを持たない。ヒット有無のゲートに使うと、
レイヤーの有無・ズーム帯・タイルの minzoom に暗黙依存して
「タップしても何も起きない」状態になりやすい。

プロパティが必要なら `MapController.featuresAtPoint(point, layerIds: [...])`
（`RenderedFeature.properties` を返す）を使う。ただしタイル側のプロパティ名に
依存するため、コード体系が確定している場合は上記の Isolate 判定のほうが安全。

## ズーム帯による意味づけ

市区町村ポリゴンは `BaseMapTileSpec.cityMinZoom`（6.0）未満のタイルに存在しない。
ポリゴン判定はズームに関係なく市区町村を返してしまうので、
「市区町村としてタップを解釈するか」は `MapController.camera?.zoom` で明示的に
判定すること。
