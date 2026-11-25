import 'package:realtime_seismic_intensity/src/biquad_filter.dart';
import 'package:realtime_seismic_intensity/src/jma_intensity_filter_design.dart';

final class JmaIntensityFilter({required JmaIntensityFilterDesign design}) {
  final List<BiquadFilter> _stages = [
    for (final coefficients in design.stages)
      BiquadFilter(coefficients: coefficients),
  ];

  double process(double input) {
    var value = input;
    for (final stage in _stages) {
      value = stage.process(value);
    }
    return value * JmaIntensityFilterDesign.gain;
  }

  void reset() {
    for (final stage in _stages) {
      stage.reset();
    }
  }
}
