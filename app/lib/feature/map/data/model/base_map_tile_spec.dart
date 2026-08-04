/// 同梱ベース地図 (`all.pmtiles`) が持つズーム方向の制約。
///
/// スタイル・レイヤー側の閾値をタイルの実態から独立に決めると、
/// フィルタが一致せず例外もログも出ないまま「何も描画されない」状態になる。
/// タイル側の制約はここに集約し、参照側は必ずこの値を使うこと。
abstract final class BaseMapTileSpec {
  /// `areaInformationCityQuake` の地物が存在する最小ズーム。
  ///
  /// タイル生成時に市区町村の全 feature へ `tippecanoe: {minzoom: 6}` を
  /// 付与しているため（backend `tools/base-map-pmtiles/convert_to_geojson.py`
  /// の `CITY_QUAKE_FEATURE_MINZOOM`）、これ未満のズームのタイルには
  /// 市区町村ポリゴンが 1 件も含まれない。
  /// 市区町村の塗りつぶしはこのズーム未満では細分区域へフォールバックさせる。
  static const cityMinZoom = 6.0;
}
