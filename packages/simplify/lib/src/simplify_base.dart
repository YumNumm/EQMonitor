import 'dart:math';

class Simplify {
  Simplify._();

  /// square distance between 2 points
  static double getSqDist(Point p1, Point p2) {
    var dx = p1.x - p2.x;
    var dy = p1.y - p2.y;
    return (dx * dx + dy * dy).toDouble();
  }

  /// square distance from a point to a segment
  static double getSqSegDist(Point p, Point p1, Point p2) {
    var x = p1.x;
    var y = p1.y;
    var dx = p2.x - x;
    var dy = p2.y - y;

    if (dx != 0 || dy != 0) {
      var t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy);

      if (t > 1) {
        x = p2.x;
        y = p2.y;
      } else if (t > 0) {
        x += dx * t;
        y += dy * t;
      }
    }

    dx = p.x - x;
    dy = p.y - y;

    return (dx * dx + dy * dy).toDouble();
  }

  /// basic distance-based simplification
  List<Point> simplifyRadialDistance(List<Point> points, double sqTolerance) {
    var prevPoint = points[0];
    var newPoints = [prevPoint];
    late Point<num> point;

    for (var i = 1, len = points.length; i < len; i++) {
      point = points[i];

      if (getSqDist(point, prevPoint) > sqTolerance) {
        newPoints.add(point);
        prevPoint = point;
      }
    }

    if (prevPoint != point) {
      newPoints.add(point);
    }

    return newPoints;
  }

  /// Simplification using optimized Douglas-Peucker algorithm with recursion elimination
  void _simplifyDPStep(
      {required List<Point> points,
      required int first,
      required int last,
      required double sqTolerance,
      required List<Point> simplified}) {
    var maxSqDist = sqTolerance;
    var index = 0;

    for (int i = first + 1; i < last; i++) {
      var sqDist = getSqSegDist(points[i], points[first], points[last]);

      if (sqDist > maxSqDist) {
        index = i;
        maxSqDist = sqDist;
      }
    }

    if (maxSqDist > sqTolerance) {
      if (index - first > 1) {
        _simplifyDPStep(
          points: points,
          first: first,
          last: index,
          sqTolerance: sqTolerance,
          simplified: simplified,
        );
      }
      simplified.add(points[index]);
      if (last - index > 1) {
        _simplifyDPStep(
          points: points,
          first: index,
          last: last,
          sqTolerance: sqTolerance,
          simplified: simplified,
        );
      }
    }
  }

  /// simplification using Ramer-Douglas-Peucker algorithm
  List<Point> simplifyDouglasPeucker(List<Point> points, double sqTolerance) {
    var last = points.length - 1;

    var simplified = [points[0]];
    _simplifyDPStep(
      points: points,
      first: 0,
      last: last,
      sqTolerance: sqTolerance,
      simplified: simplified,
    );
    simplified.add(points[last]);

    return simplified;
  }
}
