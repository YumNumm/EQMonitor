/// 同梱ベース地図 (`all.pmtiles`) が持つズーム方向の制約。
///
/// スタイル・レイヤー側の閾値をタイルの実態から独立に決めると、
/// フィルタが一致せず例外もログも出ないまま「何も描画されない」状態になる。
/// タイル側の制約はここに集約し、参照側は必ずこの値を使うこと。
abstract final class BaseMapTileSpec {
  /// `areaInformationCityQuake` の地物が存在する最小ズーム。
  ///
  /// タイル生成時の `tippecanoe: {minzoom}` (backend
  /// `tools/base-map-pmtiles/convert_to_geojson.py` の
  /// `CITY_QUAKE_FEATURE_MINZOOM`) と一致させる。これはタイルセット自身の
  /// 最小ズーム (`-Z0`) と同じなので、市区町村ポリゴンは全ズームに存在する。
  ///
  /// 0 なのでこの値による下限クランプは実質無効だが、定数は残す。タイル側で
  /// 再びこの層を高ズームへ寄せる（`--maximum-tile-bytes` を上げる代わりに
  /// minzoom を上げる）判断をしたときに、参照側を一箇所直せば追従できる。
  static const cityMinZoom = 0.0;
}
