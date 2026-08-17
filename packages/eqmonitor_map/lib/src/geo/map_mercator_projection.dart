import 'dart:math' as math;

/// Web Mercator投影。`docs/knowledge/20260805_maplibre_native_renderer_reference.md`
/// が記録するMapLibre Native (`TransformState::zoomScale`/`Projection::project_`)
/// と同じ定数・式を使う。zoomのpixel基準を512に固定しているのは、既存の
/// vector tileと同じ見た目を保つため（tileSize_D相当）。
class MapMercatorProjection {
  const new();

  /// Web Mercatorが表現できる緯度の上限(絶対値)。北緯・南緯共通。
  /// `atan(sinh(pi))`をdegreeへ変換した値で、投影がy軸方向に発散しない範囲。
  static const maxLatitude = 85.0511287798066;

  /// 1タイルが対応するlogical pixel数。zoomのpixel基準。
  static const tilePixelSize = 512.0;

  /// `zoom`におけるworld全体の一辺の長さに対する倍率。`2^zoom`。
  double scaleForZoom(double zoom) {
    if (!zoom.isFinite) {
      throw ArgumentError.value(zoom, 'zoom', 'must be finite');
    }
    return math.pow(2, zoom).toDouble();
  }

  /// `zoom`におけるworld全体のlogical pixelサイズ。`scaleForZoom(zoom) * tilePixelSize`。
  double worldSizeForZoom(double zoom) => scaleForZoom(zoom) * tilePixelSize;

  /// WGS84の経度緯度をnormalized Mercator座標へ変換する。
  ///
  /// Xは東向き、Yは南向きで原点は左上、値域は共に`[0,1)`。経度は
  /// `[-180,180)`へ周期的にwrapし、date lineを跨いでも連続な値を返す。
  /// 緯度は[maxLatitude]へclampするが、渡された`latitude`自体は
  /// 書き換えない(呼び出し側のWGS84値はそのまま保持される)。
  ({double x, double y}) lngLatToNormalized({
    required double longitude,
    required double latitude,
  }) {
    if (!longitude.isFinite) {
      throw ArgumentError.value(longitude, 'longitude', 'must be finite');
    }
    if (!latitude.isFinite) {
      throw ArgumentError.value(latitude, 'latitude', 'must be finite');
    }
    final wrappedLongitude = _wrapLongitude(longitude);
    final clampedLatitude = latitude.clamp(-maxLatitude, maxLatitude);

    final x = (wrappedLongitude + 180) / 360;
    final latRad = clampedLatitude * math.pi / 180;
    final y =
        0.5 - math.log(math.tan(math.pi / 4 + latRad / 2)) / (2 * math.pi);
    return (x: x, y: y);
  }

  /// [lngLatToNormalized]の逆変換。`x`は`[0,1)`へwrapしてから解く。
  ({double longitude, double latitude}) normalizedToLngLat({
    required double x,
    required double y,
  }) {
    if (!x.isFinite) {
      throw ArgumentError.value(x, 'x', 'must be finite');
    }
    if (!y.isFinite) {
      throw ArgumentError.value(y, 'y', 'must be finite');
    }
    final wrappedX = x - x.floor();
    final longitude = wrappedX * 360 - 180;
    final latRad = 2 * math.atan(math.exp(math.pi * (1 - 2 * y))) - math.pi / 2;
    final latitude = latRad * 180 / math.pi;
    return (longitude: longitude, latitude: latitude);
  }

  /// 経度を`[-180,180)`へ周期360で畳み込む。
  double _wrapLongitude(double longitude) {
    final wrapped = (longitude + 180) % 360;
    return (wrapped < 0 ? wrapped + 360 : wrapped) - 180;
  }
}
