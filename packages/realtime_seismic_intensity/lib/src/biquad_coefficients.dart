import 'dart:math';

final class const BiquadCoefficients({
  required final double b0,
  required final double b1,
  required final double b2,
  required final double a0,
  required final double a1,
  required final double a2,
}) {
  double magnitudeAt({required double frequency, required int samplingRate}) {
    final omega = 2 * pi * frequency / samplingRate;
    final c1 = cos(omega);
    final s1 = sin(omega);
    final c2 = cos(2 * omega);
    final s2 = sin(2 * omega);
    final numeratorReal = b0 + b1 * c1 + b2 * c2;
    final numeratorImaginary = -(b1 * s1 + b2 * s2);
    final denominatorReal = a0 + a1 * c1 + a2 * c2;
    final denominatorImaginary = -(a1 * s1 + a2 * s2);
    return sqrt(
      (numeratorReal * numeratorReal +
              numeratorImaginary * numeratorImaginary) /
          (denominatorReal * denominatorReal +
              denominatorImaginary * denominatorImaginary),
    );
  }
}
