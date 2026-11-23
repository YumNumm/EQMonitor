import 'dart:math' as math;

import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_grid_cell_builder.g.dart';

@riverpod
ShakeDetectionGridCellBuilder shakeDetectionGridCellBuilder(Ref ref) =>
    ShakeDetectionGridCellBuilder();

class const ShakeDetectionGridCell({
  required final double minLat,
  required final double maxLat,
  required final double minLng,
  required final double maxLng,
  required final ShakeDetectionLevel level,
}) {
  /// 経度方向のセル幅（度）。
  ///
  /// 緯度方向はメルカトル投影上で同じ長さになるよう区切るため、
  /// 地図上では緯度によらず正方形になる。
  static const step = 0.5;

  static const _mercatorMaxLatitude = 85.05112878;

  factory at({
    required int latIndex,
    required int lngIndex,
    required ShakeDetectionLevel level,
  }) => ShakeDetectionGridCell(
    minLat: latitudeOfIndex(latIndex),
    maxLat: latitudeOfIndex(latIndex + 1),
    minLng: longitudeOfIndex(lngIndex),
    maxLng: longitudeOfIndex(lngIndex + 1),
    level: level,
  );

  static int lngIndexOf(double longitude) => (longitude / step).floor();

  static int latIndexOf(double latitude) {
    final radians =
        latitude.clamp(-_mercatorMaxLatitude, _mercatorMaxLatitude) *
        math.pi /
        180;
    final mercatorDegrees =
        math.log(math.tan(math.pi / 4 + radians / 2)) * 180 / math.pi;
    return (mercatorDegrees / step).floor();
  }

  static double longitudeOfIndex(int index) => index * step;

  static double latitudeOfIndex(int index) {
    final mercatorRadians = index * step * math.pi / 180;
    return (2 * math.atan(math.exp(mercatorRadians)) - math.pi / 2) *
        180 /
        math.pi;
  }

  /// MapLibre の line-sort-key（大きいほど上）
  int get sortKey => level.index;

  /// GeoJSON Polygon 用の閉じたリング（[lng, lat]）
  List<List<double>> get polygonCoordinates {
    final tl = [minLng, maxLat];
    final tr = [maxLng, maxLat];
    final br = [maxLng, minLat];
    final bl = [minLng, minLat];
    return [tl, tr, br, bl, tl];
  }
}

/// 観測点をグリッドに集約し、セルごとの最大レベルを求める
class ShakeDetectionGridCellBuilder {
  /// 検知エンジンの `ShakeEventLevel.fromIntensity` と同じ閾値
  ShakeDetectionLevel levelFromIntensity(num intensity) => switch (intensity) {
    >= 5.5 => .stronger,
    >= 3.5 => .strong,
    >= 2.5 => .medium,
    >= 0.5 => .weak,
    _ => .weaker,
  };

  /// 複数イベントの観測点を集約し、レベル昇順（高レベルが末尾＝上）で返す
  List<ShakeDetectionGridCell> buildFromPointGroups({
    required List<List<ShakeDetectionPoint>> pointGroups,
  }) {
    final cells = [for (final points in pointGroups) ...build(points: points)];
    cells.sort((a, b) => a.level.index.compareTo(b.level.index));
    return cells;
  }

  List<ShakeDetectionGridCell> build({
    required List<ShakeDetectionPoint> points,
  }) {
    if (points.isEmpty) {
      return const [];
    }

    final maxByCell = <(int, int), ShakeDetectionLevel>{};
    for (final point in points) {
      final lat = point.latitude;
      final lng = point.longitude;
      final latIndex = ShakeDetectionGridCell.latIndexOf(lat);
      final lngIndex = ShakeDetectionGridCell.lngIndexOf(lng);
      final level = switch (point.intensity) {
        final intensity? => levelFromIntensity(intensity),
        null => ShakeDetectionLevel.weaker,
      };
      final key = (latIndex, lngIndex);
      final existing = maxByCell[key];
      if (existing == null || level.index > existing.index) {
        maxByCell[key] = level;
      }
    }

    final cells = [
      for (final entry in maxByCell.entries)
        ShakeDetectionGridCell.at(
          latIndex: entry.key.$1,
          lngIndex: entry.key.$2,
          level: entry.value,
        ),
    ];
    cells.sort((a, b) => a.level.index.compareTo(b.level.index));
    return cells;
  }
}
