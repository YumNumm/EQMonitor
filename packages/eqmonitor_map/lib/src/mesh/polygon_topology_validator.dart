import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/polygon_orientation.dart';

typedef PolygonRings = ({Int32List exterior, List<Int32List> holes});

/// 交差しないring間の包含関係がPolygon topologyとして正しいか検証する。
final class PolygonTopologyValidator {
  const new();

  int validate({
    required List<PolygonRings> polygons,
    required int maxChecks,
  }) {
    final counter = _TopologyCheckCounter(maxChecks: maxChecks);
    for (final polygon in polygons) {
      for (final hole in polygon.holes) {
        if (_locatePoint(
              ring: polygon.exterior,
              x: hole.first,
              y: hole[1],
              counter: counter,
            ) !=
            _PointRingLocation.inside) {
          throw const FillMeshBuildException.invalidTopology(
            reason: 'A hole is not strictly inside its exterior.',
          );
        }
      }
      _rejectNestedRings(rings: polygon.holes, counter: counter);
    }
    _rejectNestedRings(
      rings: [for (final polygon in polygons) polygon.exterior],
      counter: counter,
    );
    return counter.used;
  }
}

enum _PointRingLocation { outside, inside, boundary }

final class _TopologyCheckCounter {
  _TopologyCheckCounter({required this.maxChecks});

  final int maxChecks;
  var used = 0;

  void consume() {
    used++;
    if (used > maxChecks) {
      throw FillMeshBuildException.limitExceeded(
        reason:
            'Polygon topology checks exceed the configured limit '
            '($maxChecks).',
      );
    }
  }
}

void _rejectNestedRings({
  required List<Int32List> rings,
  required _TopologyCheckCounter counter,
}) {
  for (var left = 0; left < rings.length; left++) {
    for (var right = left + 1; right < rings.length; right++) {
      if (_locatePoint(
                ring: rings[left],
                x: rings[right].first,
                y: rings[right][1],
                counter: counter,
              ) !=
              _PointRingLocation.outside ||
          _locatePoint(
                ring: rings[right],
                x: rings[left].first,
                y: rings[left][1],
                counter: counter,
              ) !=
              _PointRingLocation.outside) {
        throw const FillMeshBuildException.invalidTopology(
          reason: 'Polygon rings must not contain one another.',
        );
      }
    }
  }
}

_PointRingLocation _locatePoint({
  required Int32List ring,
  required int x,
  required int y,
  required _TopologyCheckCounter counter,
}) {
  const orientation = PolygonOrientation();
  var inside = false;
  for (var index = 0; index < ring.length ~/ 2; index++) {
    counter.consume();
    final next = (index + 1) % (ring.length ~/ 2);
    final ax = ring[index * 2];
    final ay = ring[index * 2 + 1];
    final bx = ring[next * 2];
    final by = ring[next * 2 + 1];
    final sign = orientation.sign(
      ax: ax,
      ay: ay,
      bx: bx,
      by: by,
      cx: x,
      cy: y,
    );
    if (sign == 0 &&
        x >= (ax < bx ? ax : bx) &&
        x <= (ax > bx ? ax : bx) &&
        y >= (ay < by ? ay : by) &&
        y <= (ay > by ? ay : by)) {
      return _PointRingLocation.boundary;
    }
    if ((ay > y) != (by > y) && (sign > 0) == (by > ay)) {
      inside = !inside;
    }
  }
  return inside ? _PointRingLocation.inside : _PointRingLocation.outside;
}
