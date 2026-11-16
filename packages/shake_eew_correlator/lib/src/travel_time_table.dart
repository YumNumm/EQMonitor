final class const TravelTimeEntry({
  required final double pSeconds,
  required final double sSeconds,
  required final double depth,
  required final double distance,
});

final class const TravelTime({
  required final double pSeconds,
  required final double sSeconds,
});

/// JMA2001 走時表。深さと震央距離の双方向に線形補間し、範囲外は端の値を使う。
final class TravelTimeTable {
  new({required Iterable<TravelTimeEntry> entries}) {
    final byDepth = <double, List<TravelTimeEntry>>{};
    for (final entry in entries) {
      (byDepth[entry.depth] ??= []).add(entry);
    }
    for (final rows in byDepth.values) {
      rows.sort((a, b) => a.distance.compareTo(b.distance));
    }
    _depths = byDepth.keys.toList()..sort();
    _rows = [for (final depth in _depths) byDepth[depth] ?? const []];
  }

  late final List<double> _depths;
  late final List<List<TravelTimeEntry>> _rows;

  bool get isEmpty => _depths.isEmpty;

  TravelTime lookup({required double depth, required double distance}) {
    if (_depths.isEmpty) {
      throw StateError('Travel time table is empty');
    }
    if (depth <= _depths.first) {
      return _interpolateDistance(_rows.first, distance);
    }
    if (depth >= _depths.last) {
      return _interpolateDistance(_rows.last, distance);
    }
    var lower = 0;
    for (var index = 0; index < _depths.length - 1; index++) {
      if (depth >= _depths[index] && depth <= _depths[index + 1]) {
        lower = index;
        break;
      }
    }
    final lowerTime = _interpolateDistance(_rows[lower], distance);
    final upperTime = _interpolateDistance(_rows[lower + 1], distance);
    final ratio =
        (depth - _depths[lower]) / (_depths[lower + 1] - _depths[lower]);
    return TravelTime(
      pSeconds:
          lowerTime.pSeconds +
          ratio * (upperTime.pSeconds - lowerTime.pSeconds),
      sSeconds:
          lowerTime.sSeconds +
          ratio * (upperTime.sSeconds - lowerTime.sSeconds),
    );
  }

  TravelTime _interpolateDistance(List<TravelTimeEntry> rows, double distance) {
    final first = rows.first;
    if (distance <= first.distance) {
      return TravelTime(pSeconds: first.pSeconds, sSeconds: first.sSeconds);
    }
    final last = rows.last;
    if (distance >= last.distance) {
      return TravelTime(pSeconds: last.pSeconds, sSeconds: last.sSeconds);
    }
    var low = 0;
    var high = rows.length - 1;
    while (high - low > 1) {
      final middle = (low + high) ~/ 2;
      if (rows[middle].distance <= distance) {
        low = middle;
      } else {
        high = middle;
      }
    }
    final lower = rows[low];
    final upper = rows[high];
    final ratio =
        (distance - lower.distance) / (upper.distance - lower.distance);
    return TravelTime(
      pSeconds: lower.pSeconds + ratio * (upper.pSeconds - lower.pSeconds),
      sSeconds: lower.sSeconds + ratio * (upper.sSeconds - lower.sSeconds),
    );
  }
}
