import 'package:realtime_seismic_intensity/src/biquad_coefficients.dart';

final class BiquadFilter({required BiquadCoefficients coefficients}) {
  final _b0 = coefficients.b0 / coefficients.a0;
  final _b1 = coefficients.b1 / coefficients.a0;
  final _b2 = coefficients.b2 / coefficients.a0;
  final _a1 = coefficients.a1 / coefficients.a0;
  final _a2 = coefficients.a2 / coefficients.a0;
  var _x1 = 0.0;
  var _x2 = 0.0;
  var _y1 = 0.0;
  var _y2 = 0.0;

  double process(double input) {
    final output = _b0 * input + _b1 * _x1 + _b2 * _x2 - _a1 * _y1 - _a2 * _y2;
    _x2 = _x1;
    _x1 = input;
    _y2 = _y1;
    _y1 = output;
    return output;
  }

  void reset() {
    _x1 = 0;
    _x2 = 0;
    _y1 = 0;
    _y2 = 0;
  }
}
