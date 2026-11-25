import 'dart:math';
import 'dart:typed_data';

import 'package:realtime_seismic_intensity/src/jma_intensity_filter.dart';
import 'package:realtime_seismic_intensity/src/jma_intensity_filter_design.dart';
import 'package:realtime_seismic_intensity/src/measured_intensity_formula.dart';

final class RealtimeIntensityCalculator({
  required final int samplingRate,
  final int windowSeconds = 60,
}) {
  this {
    if (samplingRate * 3 ~/ 10 < 1) {
      throw ArgumentError.value(samplingRate, 'samplingRate', 'too small');
    }
    if (windowSeconds <= 0) {
      throw ArgumentError.value(windowSeconds, 'windowSeconds', 'must be > 0');
    }
  }

  late final _design = JmaIntensityFilterDesign(samplingRate: samplingRate);
  late final List<JmaIntensityFilter> _filters = [
    for (var axis = 0; axis < 3; axis++) JmaIntensityFilter(design: _design),
  ];
  late final _rank = samplingRate * 3 ~/ 10;
  late final _composite = Float64List(samplingRate);
  late final List<Float64List> _topValues = [
    for (var group = 0; group < windowSeconds; group++) Float64List(_rank),
  ];
  late final _cursors = Int32List(windowSeconds);
  final _formula = const MeasuredIntensityFormula();
  var _nextGroup = 0;
  var _filledGroups = 0;

  double? addSecond({
    required List<double> ns,
    required List<double> ew,
    required List<double> ud,
  }) {
    if (ns.length != samplingRate ||
        ew.length != samplingRate ||
        ud.length != samplingRate) {
      throw ArgumentError('Each component must have $samplingRate samples');
    }
    for (var i = 0; i < samplingRate; i++) {
      final x = _filters[0].process(ns[i]);
      final y = _filters[1].process(ew[i]);
      final z = _filters[2].process(ud[i]);
      _composite[i] = sqrt(x * x + y * y + z * z);
    }
    _storeTopValues();
    return _formula.fromAcceleration(_rankedAcceleration());
  }

  void reset() {
    for (final filter in _filters) {
      filter.reset();
    }
    _nextGroup = 0;
    _filledGroups = 0;
  }

  void _storeTopValues() {
    _composite.sort();
    final top = _topValues[_nextGroup];
    for (var i = 0; i < _rank; i++) {
      top[i] = _composite[samplingRate - 1 - i];
    }
    _nextGroup = (_nextGroup + 1) % windowSeconds;
    _filledGroups = min(_filledGroups + 1, windowSeconds);
  }

  // 各秒の上位値は降順に並んでいるため、先頭どうしを比べて大きい方から 0.3 秒分を取り出す。
  double _rankedAcceleration() {
    _cursors.fillRange(0, _filledGroups, 0);
    var value = 0.0;
    for (var picked = 0; picked < _rank; picked++) {
      var best = -1;
      var bestValue = double.negativeInfinity;
      for (var group = 0; group < _filledGroups; group++) {
        final cursor = _cursors[group];
        if (cursor >= _rank) {
          continue;
        }
        final candidate = _topValues[group][cursor];
        if (candidate > bestValue) {
          bestValue = candidate;
          best = group;
        }
      }
      value = bestValue;
      _cursors[best]++;
    }
    return value;
  }
}
