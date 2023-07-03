import 'dart:math';

import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:extensions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simplify/simplify.dart';

part 'map_shrinker_viewmodel.g.dart';

@Riverpod(keepAlive: true)
MapShrinker mapShrinker(MapShrinkerRef ref) => MapShrinker();

class MapShrinker {
  MapShrinker() : _cache = {};

  /// {id, {zoomLevel, [GlobalPoint]}}
  final Map<String, Map<int, List<GlobalPoint>>> _cache;

  List<GlobalPoint> applyShrinker({
    required String id,
    required int zoomLevel,
    required List<GlobalPoint> points,
  }) {
    final target = _cache.getOrNull<Map<int, List<GlobalPoint>>>(id);
    final targetCache = target?.getOrNull<List<GlobalPoint>>(zoomLevel);
    if (targetCache != null) {
      return targetCache;
    }
    // Apply DP
    final base = pow(zoomLevel, 2);
    final shrinked = simplify(
      points.map((e) => Point(e.x * base, e.y * base)).toList(),
      tolerance: 1,
    )
        .map(
          (e) => GlobalPoint(
            e.x / base.toDouble(),
            e.y / base.toDouble(),
          ),
        )
        .toList();
    // Save Cache
    _cache.putIfAbsent(id, () => {});
    // 2点以下の場合は線を描画しない

    // Save Cache
    _cache[id]!.putIfAbsent(zoomLevel, () => shrinked);
    return shrinked;
  }

  List<List<GlobalPoint>?> applyShrinkerToMultiLineString({
    required String id,
    required int zoomLevel,
    required List<List<GlobalPoint>> points,
  }) {
    return points.map((e) {
      return applyShrinker(
        id: id + e.hashCode.toString(),
        zoomLevel: zoomLevel,
        points: e,
      );
    }).toList();
  }

  void clearCache() {
    _cache.clear();
  }
}
