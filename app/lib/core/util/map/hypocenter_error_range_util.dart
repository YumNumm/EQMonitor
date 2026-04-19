import 'dart:math';

/// 座標値の小数桁数から半精度（誤差の半幅）を計算する。
///
/// 例: 139.1  → 0.05  (10^-1 / 2)
/// 例: 139.16 → 0.005 (10^-2 / 2)
/// 例: 45.0   → 0.5   (10^0 / 2)
double halfPrecision(double value) {
  // 浮動小数点の誤差を避けるため十分な精度で文字列化し、末尾の 0 を除去
  final str = value.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '');
  final dotIndex = str.indexOf('.');
  if (dotIndex == -1) {
    return 0.5;
  }
  final decimalPlaces = str.length - dotIndex - 1;
  return 0.5 * pow(10.0, -decimalPlaces);
}

/// 緯度・経度から震央誤差矩形の GeoJSON Polygon coordinates を生成する。
///
/// 戻り値は閉じたリング（始点=終点）の座標リスト [lon, lat] の形式。
List<List<double>> hypocenterErrorPolygon(double lat, double lon) {
  final dLat = halfPrecision(lat);
  final dLon = halfPrecision(lon);
  return [
    [lon - dLon, lat - dLat],
    [lon + dLon, lat - dLat],
    [lon + dLon, lat + dLat],
    [lon - dLon, lat + dLat],
    [lon - dLon, lat - dLat], // close ring
  ];
}
