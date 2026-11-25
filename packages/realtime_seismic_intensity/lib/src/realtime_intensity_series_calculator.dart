import 'dart:math';
import 'dart:typed_data';

import 'package:realtime_seismic_intensity/src/jma_intensity_filter.dart';
import 'package:realtime_seismic_intensity/src/jma_intensity_filter_design.dart';
import 'package:realtime_seismic_intensity/src/measured_intensity_formula.dart';
import 'package:realtime_seismic_intensity/src/ranked_window.dart';
import 'package:realtime_seismic_intensity/src/realtime_intensity_series.dart';

final class const RealtimeIntensitySeriesCalculator() {
  RealtimeIntensitySeries calculate({
    required DateTime startTime,
    required int samplingRate,
    required List<double> ns,
    required List<double> ew,
    required List<double> ud,
    int windowSeconds = 60,
    int stepsPerSecond = 1,
  }) {
    final rank = samplingRate * 3 ~/ 10;
    if (rank < 1) {
      throw ArgumentError.value(samplingRate, 'samplingRate', 'too small');
    }
    if (windowSeconds <= 0) {
      throw ArgumentError.value(windowSeconds, 'windowSeconds', 'must be > 0');
    }
    if (stepsPerSecond <= 0 || samplingRate % stepsPerSecond != 0) {
      throw ArgumentError.value(
        stepsPerSecond,
        'stepsPerSecond',
        'must divide samplingRate',
      );
    }
    final composite = _composite(
      samplingRate: samplingRate,
      components: [ns, ew, ud],
    );
    final stepSamples = samplingRate ~/ stepsPerSecond;
    final windowSamples = samplingRate * windowSeconds;
    final window = RankedWindow(values: composite);
    const formula = MeasuredIntensityFormula();
    final values = <double?>[];
    var added = 0;
    var removed = 0;
    for (var end = stepSamples; end <= composite.length; end += stepSamples) {
      for (; added < end; added++) {
        window.add(added);
      }
      final start = max(0, end - windowSamples);
      for (; removed < start; removed++) {
        window.remove(removed);
      }
      final count = end - start;
      values.add(
        count < rank
            ? null
            : formula.fromAcceleration(window.smallest(count - rank + 1)),
      );
    }
    return RealtimeIntensitySeries(
      startTime: startTime,
      values: values,
      interval: Duration(
        microseconds: Duration.microsecondsPerSecond ~/ stepsPerSecond,
      ),
    );
  }

  Float64List _composite({
    required int samplingRate,
    required List<List<double>> components,
  }) {
    final length = components.map((c) => c.length).reduce(min);
    final design = JmaIntensityFilterDesign(samplingRate: samplingRate);
    final composite = Float64List(length);
    for (final samples in components) {
      final filter = JmaIntensityFilter(design: design);
      final offset = _mean(samples, length);
      for (var i = 0; i < length; i++) {
        final value = filter.process(samples[i] - offset);
        composite[i] += value * value;
      }
    }
    for (var i = 0; i < length; i++) {
      composite[i] = sqrt(composite[i]);
    }
    return composite;
  }

  // 記録全長の平均値をオフセットとして差し引く。防災科研が公開する最大加速度と同じ扱い。
  double _mean(List<double> samples, int length) {
    if (length == 0) {
      return 0;
    }
    var sum = 0.0;
    for (var i = 0; i < length; i++) {
      sum += samples[i];
    }
    return sum / length;
  }
}
