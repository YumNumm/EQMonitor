import 'dart:math' as math;

import 'package:knet_dsp/knet_dsp.dart';
import 'package:test/test.dart';

void main() {
  group('FourierSpectrumAnalyzer', () {
    const analyzer = FourierSpectrumAnalyzer();

    test('周波数軸が正しく設定される', () {
      const dt = 0.01; // fs = 100 Hz
      final x = List<double>.filled(256, 1);
      final result = analyzer.compute(x, dt);

      expect(result.frequencies.first, closeTo(0.0, 1e-10));
      expect(result.frequencies.last, closeTo(50.0, 1e-3));
    });

    test('正弦波のフーリエスペクトルにピークがある', () {
      const dt = 0.01;
      const fs = 1.0 / dt;
      const freq = 10.0;
      const n = 512;
      final x = List<double>.generate(
        n,
        (i) => math.cos(2 * math.pi * freq * i / fs),
      );
      final result = analyzer.compute(x, dt);

      // ピーク位置が 10 Hz 付近にある
      var maxIdx = 0;
      var maxAmp = 0.0;
      for (var i = 0; i < result.amplitudes.length; i++) {
        if (result.amplitudes[i] > maxAmp) {
          maxAmp = result.amplitudes[i];
          maxIdx = i;
        }
      }
      final peakFreq = result.frequencies[maxIdx];
      expect(peakFreq, closeTo(freq, 1.0)); // 1 Hz 以内の誤差
    });
  });

  group('PowerSpectrumAnalyzer', () {
    test('パワースペクトルが非負', () {
      final analyzer = PowerSpectrumAnalyzer();
      final x = List<double>.generate(
        256,
        (i) => math.sin(2 * math.pi * 5.0 * i * 0.01),
      );
      final result = analyzer.compute(x, 0.01);
      for (final p in result.power) {
        expect(p, greaterThanOrEqualTo(0.0));
      }
    });
  });

  group('EnergySpectrumAnalyzer', () {
    test('エネルギースペクトルが非負', () {
      final analyzer = EnergySpectrumAnalyzer();
      final x = List<double>.generate(
        256,
        (i) => math.cos(2 * math.pi * 5.0 * i * 0.01),
      );
      final result = analyzer.compute(x, 0.01);
      for (final e in result.energy) {
        expect(e, greaterThanOrEqualTo(0.0));
      }
    });
  });

  group('ResponseSpectrumAnalyzer', () {
    test('応答スペクトルの周期数が正しい', () {
      const analyzer = ResponseSpectrumAnalyzer();
      const dt = 0.01;
      final accel = List<double>.generate(
        1000,
        (i) => math.sin(2 * math.pi * 1 * i * dt) * 100,
      );
      final result = analyzer.compute(accel, dt);

      expect(result.sa.length, equals(result.periods.length));
      expect(result.sv.length, equals(result.periods.length));
      expect(result.sd.length, equals(result.periods.length));
    });

    test('応答スペクトルが非負', () {
      const analyzer = ResponseSpectrumAnalyzer();
      const dt = 0.01;
      final accel = List<double>.generate(
        1000,
        (i) => math.sin(2 * math.pi * 2 * i * dt) * 50,
      );
      final result = analyzer.compute(accel, dt);

      for (final sa in result.sa) {
        expect(sa, greaterThanOrEqualTo(0.0));
      }
      for (final sv in result.sv) {
        expect(sv, greaterThanOrEqualTo(0.0));
      }
      for (final sd in result.sd) {
        expect(sd, greaterThanOrEqualTo(0.0));
      }
    });

    test('共振周期付近で応答が大きくなる', () {
      // 入力: 1 Hz 正弦波 → T=1.0s 付近で最大応答を期待
      const dt = 0.005;
      const n = 4000;
      const inputFreq = 1.0;

      final accel = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * inputFreq * i * dt) * 100,
      );

      const periods = [0.5, 0.8, 1.0, 1.2, 2.0];
      const analyzer = ResponseSpectrumAnalyzer(periods: periods);
      final result = analyzer.compute(accel, dt);

      // T=1.0s の応答が T=0.5s よりも大きい（インデックス 2 と 0）
      final sa1 = result.sa[2]; // T=1.0s
      final sa05 = result.sa[0]; // T=0.5s
      expect(sa1, greaterThan(sa05));
    });

    test('ゼロ入力で応答もゼロ', () {
      const analyzer = ResponseSpectrumAnalyzer();
      final accel = List<double>.filled(500, 0);
      final result = analyzer.compute(accel, 0.01);
      for (final sa in result.sa) {
        expect(sa, closeTo(0.0, 1e-10));
      }
    });
  });
}
