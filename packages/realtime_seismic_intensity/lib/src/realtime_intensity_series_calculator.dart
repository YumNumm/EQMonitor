import 'dart:typed_data';

import 'package:realtime_seismic_intensity/src/realtime_intensity_calculator.dart';
import 'package:realtime_seismic_intensity/src/realtime_intensity_series.dart';

final class const RealtimeIntensitySeriesCalculator() {
  RealtimeIntensitySeries calculate({
    required DateTime startTime,
    required int samplingRate,
    required List<double> ns,
    required List<double> ew,
    required List<double> ud,
    int windowSeconds = 60,
  }) {
    final calculator = RealtimeIntensityCalculator(
      samplingRate: samplingRate,
      windowSeconds: windowSeconds,
    );
    final length = [ns.length, ew.length, ud.length].reduce(
      (a, b) => a < b ? a : b,
    );
    final components = [
      _withoutOffset(ns, length),
      _withoutOffset(ew, length),
      _withoutOffset(ud, length),
    ];
    final values = <double?>[];
    for (var start = 0; start + samplingRate <= length; start += samplingRate) {
      final end = start + samplingRate;
      values.add(
        calculator.addSecond(
          ns: Float64List.sublistView(components[0], start, end),
          ew: Float64List.sublistView(components[1], start, end),
          ud: Float64List.sublistView(components[2], start, end),
        ),
      );
    }
    return RealtimeIntensitySeries(startTime: startTime, values: values);
  }

  // 記録全長の平均値をオフセットとして差し引く。防災科研が公開する最大加速度と同じ扱い。
  Float64List _withoutOffset(List<double> samples, int length) {
    var sum = 0.0;
    for (var i = 0; i < length; i++) {
      sum += samples[i];
    }
    final mean = length == 0 ? 0.0 : sum / length;
    final result = Float64List(length);
    for (var i = 0; i < length; i++) {
      result[i] = samples[i] - mean;
    }
    return result;
  }
}
