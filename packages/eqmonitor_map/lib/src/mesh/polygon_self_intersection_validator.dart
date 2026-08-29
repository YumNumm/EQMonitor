import 'dart:collection';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/polygon_orientation.dart';

/// Polygon境界をX方向に走査し、非隣接辺の接触・交差・重複を拒否する。
final class PolygonSelfIntersectionValidator {
  const new();

  int validate({
    required List<Int32List> rings,
    required int maxIntersectionChecks,
  }) {
    final segments = <_PolygonSegment>[
      for (var ringIndex = 0; ringIndex < rings.length; ringIndex++)
        for (
          var edgeIndex = 0;
          edgeIndex < rings[ringIndex].length ~/ 2;
          edgeIndex++
        )
          _PolygonSegment.fromRing(
            ring: rings[ringIndex],
            ringIndex: ringIndex,
            edgeIndex: edgeIndex,
          ),
    ]..sort(_comparePolygonSegments);
    final active = LinkedHashSet<_PolygonSegment>.identity();
    final expiration = SplayTreeMap<int, List<_PolygonSegment>>();
    var checks = 0;

    for (final segment in segments) {
      while (expiration.isNotEmpty) {
        final maxX = expiration.firstKey();
        if (maxX == null || maxX >= segment.minX) {
          break;
        }
        active.removeAll(expiration.remove(maxX) ?? const []);
      }
      for (final other in active) {
        if (_areAdjacentPolygonSegments(segment, other)) {
          continue;
        }
        checks++;
        if (checks > maxIntersectionChecks) {
          throw FillMeshBuildException.limitExceeded(
            reason:
                'Polygon intersection checks exceed the configured limit '
                '($maxIntersectionChecks).',
          );
        }
        if (_rangesOverlap(
              segment.minY,
              segment.maxY,
              other.minY,
              other.maxY,
            ) &&
            _polygonSegmentsIntersect(segment, other)) {
          throw const FillMeshBuildException.selfIntersection(
            reason: 'Polygon boundaries intersect or touch.',
          );
        }
      }
      active.add(segment);
      expiration.putIfAbsent(segment.maxX, () => []).add(segment);
    }
    return checks;
  }
}

final class _PolygonSegment {
  _PolygonSegment({
    required this.ringIndex,
    required this.edgeIndex,
    required this.edgeCount,
    required this.ax,
    required this.ay,
    required this.bx,
    required this.by,
  }) : minX = ax < bx ? ax : bx,
       maxX = ax > bx ? ax : bx,
       minY = ay < by ? ay : by,
       maxY = ay > by ? ay : by;

  factory _PolygonSegment.fromRing({
    required Int32List ring,
    required int ringIndex,
    required int edgeIndex,
  }) {
    final edgeCount = ring.length ~/ 2;
    final next = (edgeIndex + 1) % edgeCount;
    return _PolygonSegment(
      ringIndex: ringIndex,
      edgeIndex: edgeIndex,
      edgeCount: edgeCount,
      ax: ring[edgeIndex * 2],
      ay: ring[edgeIndex * 2 + 1],
      bx: ring[next * 2],
      by: ring[next * 2 + 1],
    );
  }

  final int ringIndex;
  final int edgeIndex;
  final int edgeCount;
  final int ax;
  final int ay;
  final int bx;
  final int by;
  final int minX;
  final int maxX;
  final int minY;
  final int maxY;
}

int _comparePolygonSegments(_PolygonSegment left, _PolygonSegment right) {
  final byMinX = left.minX.compareTo(right.minX);
  if (byMinX != 0) {
    return byMinX;
  }
  final byMinY = left.minY.compareTo(right.minY);
  if (byMinY != 0) {
    return byMinY;
  }
  final byRing = left.ringIndex.compareTo(right.ringIndex);
  return byRing != 0 ? byRing : left.edgeIndex.compareTo(right.edgeIndex);
}

bool _areAdjacentPolygonSegments(_PolygonSegment a, _PolygonSegment b) {
  if (a.ringIndex != b.ringIndex) {
    return false;
  }
  final distance = (a.edgeIndex - b.edgeIndex).abs();
  return distance == 1 || distance == a.edgeCount - 1;
}

bool _rangesOverlap(int aMin, int aMax, int bMin, int bMax) =>
    aMin <= bMax && bMin <= aMax;

bool _polygonSegmentsIntersect(_PolygonSegment a, _PolygonSegment b) {
  const orientation = PolygonOrientation();
  final abA = orientation.sign(
    ax: a.ax,
    ay: a.ay,
    bx: a.bx,
    by: a.by,
    cx: b.ax,
    cy: b.ay,
  );
  final abB = orientation.sign(
    ax: a.ax,
    ay: a.ay,
    bx: a.bx,
    by: a.by,
    cx: b.bx,
    cy: b.by,
  );
  final cdA = orientation.sign(
    ax: b.ax,
    ay: b.ay,
    bx: b.bx,
    by: b.by,
    cx: a.ax,
    cy: a.ay,
  );
  final cdB = orientation.sign(
    ax: b.ax,
    ay: b.ay,
    bx: b.bx,
    by: b.by,
    cx: a.bx,
    cy: a.by,
  );
  if (abA == 0 && _pointIsOnPolygonSegment(b.ax, b.ay, a)) {
    return true;
  }
  if (abB == 0 && _pointIsOnPolygonSegment(b.bx, b.by, a)) {
    return true;
  }
  if (cdA == 0 && _pointIsOnPolygonSegment(a.ax, a.ay, b)) {
    return true;
  }
  if (cdB == 0 && _pointIsOnPolygonSegment(a.bx, a.by, b)) {
    return true;
  }
  return (abA < 0) != (abB < 0) && (cdA < 0) != (cdB < 0);
}

bool _pointIsOnPolygonSegment(int x, int y, _PolygonSegment segment) =>
    x >= segment.minX &&
    x <= segment.maxX &&
    y >= segment.minY &&
    y <= segment.maxY;
