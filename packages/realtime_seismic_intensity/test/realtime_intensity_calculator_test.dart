import 'dart:math';
import 'dart:typed_data';

import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';
import 'package:test/test.dart';

void main() {
  Float64List sine({
    required int samplingRate,
    required int second,
    required double frequency,
    required double amplitude,
  }) => Float64List.fromList([
    for (var i = 0; i < samplingRate; i++)
      amplitude * sin(2 * pi * frequency * (second + i / samplingRate)),
  ]);

  group('RealtimeIntensityCalculator', () {
    // 1 Hz での告示のフィルタの倍率は 0.9964。100 gal なら a ≒ 99.6 gal、2log10(a) + 0.94 ≒ 4.937。
    for (final samplingRate in [100, 200]) {
      test('$samplingRate Hz・1 Hz・100 gal の正弦波で 4.9 になること', () {
        final calculator = RealtimeIntensityCalculator(
          samplingRate: samplingRate,
        );
        final zero = Float64List(samplingRate);
        double? value;
        for (var second = 0; second < 30; second++) {
          value = calculator.addSecond(
            ns: sine(
              samplingRate: samplingRate,
              second: second,
              frequency: 1,
              amplitude: 100,
            ),
            ew: zero,
            ud: zero,
          );
        }
        expect(value, 4.9);
      });
    }

    test('揺れが終わっても窓の 60 秒間は値を保ち、窓から外れると下がること', () {
      final calculator = RealtimeIntensityCalculator(samplingRate: 100);
      final zero = Float64List(100);
      final values = <double?>[
        for (var second = 0; second < 5; second++)
          calculator.addSecond(
            ns: sine(
              samplingRate: 100,
              second: second,
              frequency: 1,
              amplitude: 100,
            ),
            ew: zero,
            ud: zero,
          ),
        for (var second = 5; second < 80; second++)
          calculator.addSecond(ns: zero, ew: zero, ud: zero),
      ];

      expect(values[4], 4.9);
      expect(values[59], 4.9);
      expect(values[70], anyOf(isNull, lessThan(2)));
    });

    test('3成分を合成すること', () {
      final single = RealtimeIntensityCalculator(samplingRate: 100);
      final triple = RealtimeIntensityCalculator(samplingRate: 100);
      final zero = Float64List(100);
      double? singleValue;
      double? tripleValue;
      for (var second = 0; second < 30; second++) {
        final wave = sine(
          samplingRate: 100,
          second: second,
          frequency: 1,
          amplitude: 10,
        );
        singleValue = single.addSecond(ns: wave, ew: zero, ud: zero);
        tripleValue = triple.addSecond(ns: wave, ew: wave, ud: wave);
      }

      expect(singleValue, 2.9);
      expect(tripleValue, 3.4);
    });

    test('入力がすべて 0 の場合は null を返すこと', () {
      final calculator = RealtimeIntensityCalculator(samplingRate: 100);
      final zero = Float64List(100);

      expect(calculator.addSecond(ns: zero, ew: zero, ud: zero), isNull);
    });

    test('1秒分と異なるサンプル数を渡すと例外になること', () {
      final calculator = RealtimeIntensityCalculator(samplingRate: 100);

      expect(
        () => calculator.addSecond(
          ns: Float64List(99),
          ew: Float64List(100),
          ud: Float64List(100),
        ),
        throwsArgumentError,
      );
    });

    test('reset で窓とフィルタの状態を捨てること', () {
      final calculator = RealtimeIntensityCalculator(samplingRate: 100);
      final zero = Float64List(100);
      for (var second = 0; second < 10; second++) {
        calculator.addSecond(
          ns: sine(
            samplingRate: 100,
            second: second,
            frequency: 1,
            amplitude: 100,
          ),
          ew: zero,
          ud: zero,
        );
      }
      calculator.reset();

      expect(calculator.addSecond(ns: zero, ew: zero, ud: zero), isNull);
    });
  });
}
