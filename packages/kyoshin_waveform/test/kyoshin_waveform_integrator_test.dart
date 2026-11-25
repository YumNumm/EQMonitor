import 'dart:math';
import 'dart:typed_data';

import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:test/test.dart';

void main() {
  const integrator = KyoshinWaveformIntegrator();
  const samplingRate = 100;

  Float64List sine({required double frequency, required double amplitude}) =>
      Float64List.fromList([
        for (var i = 0; i < 120 * samplingRate; i++)
          amplitude * sin(2 * pi * frequency * i / samplingRate),
      ]);

  double peakBetween(Float64List samples, int fromSecond, int toSecond) {
    var peak = 0.0;
    for (var i = fromSecond * samplingRate; i < toSecond * samplingRate; i++) {
      peak = max(peak, samples[i].abs());
    }
    return peak;
  }

  group('KyoshinWaveformIntegrator', () {
    // 正弦波 A sin(2πft) の速度の振幅は A/(2πf)、変位の振幅は A/(2πf)^2。
    test('1 Hz・100 gal の正弦波から速度と変位の振幅を求められること', () {
      final acceleration = sine(frequency: 1, amplitude: 100);

      final velocity = integrator.velocity(
        accelerationGal: acceleration,
        samplingRate: samplingRate,
      );
      final displacement = integrator.displacement(
        accelerationGal: acceleration,
        samplingRate: samplingRate,
      );

      expect(peakBetween(velocity, 40, 80), closeTo(100 / (2 * pi), 0.05));
      expect(
        peakBetween(displacement, 40, 80),
        closeTo(100 / pow(2 * pi, 2), 0.01),
      );
    });

    test('一定の加速度のずれは速度・変位に残さないこと', () {
      final acceleration = Float64List(60 * samplingRate)
        ..fillRange(0, 60 * samplingRate, 1);

      final velocity = integrator.velocity(
        accelerationGal: acceleration,
        samplingRate: samplingRate,
      );

      expect(peakBetween(velocity, 20, 40), lessThan(0.05));
    });

    test('速度は加速度より 90 度遅れた位相になること', () {
      final acceleration = sine(frequency: 1, amplitude: 100);

      final velocity = integrator.velocity(
        accelerationGal: acceleration,
        samplingRate: samplingRate,
      );

      // sin を積分すると -cos になるため、整数秒の時刻では負の最大になる。
      expect(velocity[60 * samplingRate], closeTo(-100 / (2 * pi), 0.05));
    });
  });
}
