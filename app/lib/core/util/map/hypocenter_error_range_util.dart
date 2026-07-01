import 'dart:math';

/// 座標値の信頼できる小数桁数から半精度（誤差の半幅）を計算する。
///
/// 例: decimalPlaces=0 → 0.5
/// 例: decimalPlaces=1 → 0.05
/// 例: decimalPlaces=3 → 0.0005
double halfPrecision({required int decimalPlaces}) {
  if (decimalPlaces < 0) {
    throw ArgumentError.value(
      decimalPlaces,
      'decimalPlaces',
      'must be greater than or equal to 0',
    );
  }
  return 0.5 * pow(10.0, -decimalPlaces);
}

/// 緯度・経度から震央誤差矩形の GeoJSON Polygon coordinates を生成する。
///
/// 戻り値は閉じたリング（始点=終点）の座標リスト [lon, lat] の形式。
List<List<double>> hypocenterErrorPolygon({
  required double lat,
  required double lon,
  required int decimalPlaces,
}) {
  final halfWidth = halfPrecision(decimalPlaces: decimalPlaces);
  return [
    [lon - halfWidth, lat - halfWidth],
    [lon + halfWidth, lat - halfWidth],
    [lon + halfWidth, lat + halfWidth],
    [lon - halfWidth, lat + halfWidth],
    [lon - halfWidth, lat - halfWidth], // close ring
  ];
}
