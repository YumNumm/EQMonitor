# MapLibreカスタム範囲の座標順序

MapLibreの`LngLatBounds`は経度と緯度を別フィールドで公開する一方、
`lat_lng`パッケージの`LatLng`コンストラクタは`LatLng(lat, lon)`の順で受け取る。
ホーム地図の表示範囲を変換するときは、次の対応を使う。

```dart
LatLng(region.latitudeSouth, region.longitudeWest)
LatLng(region.latitudeNorth, region.longitudeEast)
```

`longitudeWest`を第1引数へ渡すと緯度・経度が反転する。再発防止テストは、
異なる値の緯度・経度を使ってprovider状態、保存JSON、再読込後の値を検証する。

```shell
mise exec -- flutter test app/test/feature/home/data/flow/save_home_map_bounds_flow_test.dart
```
