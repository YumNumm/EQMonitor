import 'dart:math';
import 'dart:ui';

import 'package:eqmonitor/common/component/map/model/projected_feature_layer.dart';
import 'package:eqmonitor/common/component/map/utils/web_mercator_projection.dart';
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

  /// {id, {zoomLevel, Path}}
  final Map<String, Map<int, Path>> _pathCache = {};

  /// {id, {zoomLevel, Path}}
  final Map<int, Map<int, List<Point<double>>>> _polygonCache = {};
  final Map<int, Map<int, List<Point<double>>>> _polylineCache = {};

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
    final shrinked = simplify(
      points.map((e) => Point(e.x * zoomLevel, e.y * zoomLevel)).toList(),
      tolerance: 1,
    )
        .map(
          (e) => GlobalPoint(
            e.x / zoomLevel,
            e.y / zoomLevel,
          ),
        )
        .toList();
    // Save Cache
    _cache.putIfAbsent(id, () => {});
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

  Path applyShrinkerToPath({
    required String cacheId,
    required int zoomLevel,
    required List<GlobalPoint> points,
    bool isClosed = false,
  }) {
    // cacheを確認
    final target = _pathCache.getOrNull<Map<int, Path>>(cacheId);
    final targetCache = target?.getOrNull<Path>(zoomLevel);
    if (targetCache != null) {
      return targetCache;
    }

    // ZoomLevelを適用
    final zoomed = points
        .map(
          (e) => Point(
            e.x * zoomLevel,
            e.y * zoomLevel,
          ),
        )
        .toList();
    // Apply DP
    final simplified = simplify(
      zoomed,
      highestQuality: false,
      tolerance: 1,
    );
    final path = Path()
      ..addPolygon(
        simplified.map((e) => Offset(e.x, e.y)).toList(),
        isClosed,
      );
    // Cache
    _pathCache.putIfAbsent(cacheId, () => {});
    _pathCache[cacheId]!.putIfAbsent(zoomLevel, () => path);
    return path;
  }

  List<Point<double>> applyShrinkerToPolygonFeature({
    required int zoom,
    required ProjectedPolygonFeature feature,
  }) {
    final cacheZoomLevel = sqrt(zoom).floor();
    // check cache
    final target = _polygonCache
            .getOrNull<Map<int, List<Point<double>>>>(feature.hashCode) ??
        (_polygonCache[feature.hashCode] = {});
    final targetCache = target.getOrNull<List<Point<double>>>(cacheZoomLevel);
    if (targetCache != null) {
      return targetCache;
    }

    final points = feature.points;
    // Zoomを適用
    final zoomed = points
        .map(
          (e) => Point(
            e.x * zoom,
            e.y * zoom,
          ),
        )
        .toList();
    // Apply DP
    final simplified = simplify(
      zoomed,
      tolerance: 1,
      highestQuality: true,
    );
    return target[cacheZoomLevel] = simplified;
  }

  Path applyShrinkerToPolylineFeature({
    required int zoom,
    required ProjectedPolylineFeature feature,
  }) {
    // check cache
    final target = _polylineCache.getOrNull<Map<int, Path>>(feature.hashCode) ??
        (_polylineCache[feature.hashCode] = {});
    final targetCache = target.getOrNull<Path>(zoom);
    if (targetCache != null) {
      return targetCache;
    }

    final points = feature.points;
    // Zoomを適用
    final zoomed = points
        .map(
          (e) => Point(
            e.x * zoom,
            e.y * zoom,
          ),
        )
        .toList();

    // Apply DP
    final simplified = simplify(
      zoomed,
      highestQuality: false,
      tolerance: 1,
    );
    final path = Path()
      ..addPolygon(
        simplified.map((e) => Offset(e.x, e.y)).toList(),
        false,
      );
    return target[zoom] = path;
  }

  void clearCache() {
    _cache.clear();
  }
}
