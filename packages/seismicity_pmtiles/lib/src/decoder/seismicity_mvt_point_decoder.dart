import 'dart:math' as math;

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

typedef SeismicityMvtPoint = ({
  int globalX,
  int globalY,
  double longitude,
  double latitude,
});

final class SeismicityMvtPointDecoder {
  const new();

  SeismicityMvtPoint decode({
    required List<int> geometry,
    required int z,
    required int x,
    required int y,
    required int extent,
    required int tileId,
    required int featureIndex,
  }) {
    Never fail(String reason) =>
        throw SeismicityPmTilesException.invalidHypocenterFeature(
          tileId: tileId,
          featureIndex: featureIndex,
          field: 'geometry',
          reason: reason,
        );

    if (geometry.length != 3 || geometry.first != 9) {
      fail('invalid_point_geometry');
    }
    if (extent <= 0) {
      fail('invalid_extent');
    }
    const maxInt64 = 0x7fffffffffffffff;
    if (z < 0 || z > 62) {
      fail('coordinate_overflow');
    }
    final tileCount = 1 << z;
    if (extent > maxInt64 ~/ tileCount) {
      fail('coordinate_overflow');
    }
    final worldWidth = extent * tileCount;
    final localX = _zigZagDecode(geometry[1]);
    final localY = _zigZagDecode(geometry[2]);

    final tileOriginX = _positiveModulo(x, tileCount) * extent;
    final wrappedLocalX = _positiveModulo(localX, worldWidth);
    final distanceToWrap = worldWidth - tileOriginX;
    final globalX = wrappedLocalX >= distanceToWrap
        ? wrappedLocalX - distanceToWrap
        : tileOriginX + wrappedLocalX;

    if (y < 0 || y >= tileCount) {
      fail('global_y_out_of_range');
    }
    final tileOriginY = y * extent;
    if (localY < -tileOriginY || localY > worldWidth - tileOriginY) {
      fail('global_y_out_of_range');
    }
    final globalY = tileOriginY + localY;
    final longitude = globalX / worldWidth * 360 - 180;
    final mercatorY = math.pi * (1 - 2 * globalY / worldWidth);
    final sinh = (math.exp(mercatorY) - math.exp(-mercatorY)) / 2;
    final latitude = math.atan(sinh) * 180 / math.pi;
    if (!longitude.isFinite || !latitude.isFinite) {
      fail('non_finite_coordinate');
    }
    return (
      globalX: globalX,
      globalY: globalY,
      longitude: longitude,
      latitude: latitude,
    );
  }
}

int _zigZagDecode(int value) => (value >> 1) ^ -(value & 1);

int _positiveModulo(int value, int modulus) {
  final remainder = value.remainder(modulus);
  return remainder < 0 ? remainder + modulus : remainder;
}
