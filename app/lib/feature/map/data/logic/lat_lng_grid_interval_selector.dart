import 'dart:math' as math;

final class LatLngGridIntervalSelector {
  const new();

  static const intervals = <double>[
    90,
    45,
    30,
    15,
    10,
    5,
    2,
    1,
    0.5,
    0.25,
    0.1,
    0.05,
    0.025,
    0.01,
  ];

  double select({required int zoomLevel}) {
    if (zoomLevel < 0 || zoomLevel > 30) {
      throw RangeError.range(zoomLevel, 0, 30, 'zoomLevel');
    }
    final tileSpan = 360 / math.pow(2, zoomLevel);
    final threshold = tileSpan / 8;
    return intervals.reversed.firstWhere(
      (interval) => interval >= threshold,
      orElse: () => intervals.last,
    );
  }
}
