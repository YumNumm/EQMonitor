import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_grid_cell_builder.g.dart';

@riverpod
ShakeDetectionGridCellBuilder shakeDetectionGridCellBuilder(Ref ref) =>
    ShakeDetectionGridCellBuilder();

class ShakeDetectionGridCell {
  const ShakeDetectionGridCell({
    required this.minLat,
    required this.minLng,
    required this.level,
  });

  static const step = 0.25;

  final double minLat;
  final double minLng;
  final ShakeDetectionLevel level;

  double get maxLat => minLat + step;
  double get maxLng => minLng + step;

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

/// 観測点を 0.25° グリッドに集約し、セルごとの最大レベルを求める
class ShakeDetectionGridCellBuilder {
  /// バックエンド `getShakeLevelFromIntensity` と同じ閾値
  ShakeDetectionLevel levelFromIntensity(num intensity) => switch (intensity) {
    > 4.5 => .stronger,
    > 2.5 => .strong,
    > 0.5 => .medium,
    > -1 => .weak,
    _ => .weaker,
  };

  /// 複数イベントの観測点を集約し、レベル昇順（高レベルが末尾＝上）で返す
  List<ShakeDetectionGridCell> buildFromPointGroups({
    required List<List<Points>> pointGroups,
  }) {
    final cells = [for (final points in pointGroups) ...build(points: points)];
    cells.sort((a, b) => a.level.index.compareTo(b.level.index));
    return cells;
  }

  List<ShakeDetectionGridCell> build({required List<Points> points}) {
    if (points.isEmpty) {
      return const [];
    }

    final maxByCell = <(int, int), ShakeDetectionLevel>{};
    for (final point in points) {
      final lat = point.location.latitude.toDouble();
      final lng = point.location.longitude.toDouble();
      final latIndex = (lat / ShakeDetectionGridCell.step).floor();
      final lngIndex = (lng / ShakeDetectionGridCell.step).floor();
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
        ShakeDetectionGridCell(
          minLat: entry.key.$1 * ShakeDetectionGridCell.step,
          minLng: entry.key.$2 * ShakeDetectionGridCell.step,
          level: entry.value,
        ),
    ];
    cells.sort((a, b) => a.level.index.compareTo(b.level.index));
    return cells;
  }
}
