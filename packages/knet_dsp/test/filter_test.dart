import 'dart:math' as math;

import 'package:knet_dsp/knet_dsp.dart';
import 'package:test/test.dart';

double _rms(List<double> x) {
  if (x.isEmpty) {
    return 0;
  }
  var sum = 0.0;
  for (final v in x) {
    sum += v * v;
  }
  return math.sqrt(sum / x.length);
}

void main() {
  group('IntegrationFilter', () {
    const filter = IntegrationFilter();

    test('定数加速度を積分すると線形速度', () {
      const dt = 0.01;
      const accel = 1.0; // 1 gal
      const n = 100;
      final x = List<double>.filled(n, accel);
      final v = filter.apply(x, dt);

      // v[n] ≈ accel * n * dt（台形則なので初期値 0）
      for (var i = 1; i < n; i++) {
        expect(v[i], closeTo(accel * i * dt, 1e-10));
      }
    });

    test('正弦波を積分するとピーク間振幅が 2/(2π*f) になる', () {
      // 初期値 0 から ∫sin(2πft)dt を計算すると
      // y(t) = -cos(2πft)/(2πf) + 1/(2πf) となり、
      // ピーク間振幅（max - min）= 2/(2πf) になる。
      const dt = 0.001;
      const fs = 1.0 / dt;
      const freq = 1.0; // 1 Hz
      const n = 4000;
      final x = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * freq * i / fs),
      );
      final y = filter.apply(x, dt);

      // 安定域でのピーク間振幅を確認
      // 期待ピーク間振幅 = 2/(2π*f)
      const expectedPeakToPeak = 2.0 / (2 * math.pi * freq);
      final stable = y.sublist(n ~/ 2);
      var maxVal = stable[0];
      var minVal = stable[0];
      for (final v in stable) {
        if (v > maxVal) {
          maxVal = v;
        }
        if (v < minVal) {
          minVal = v;
        }
      }
      final peakToPeak = maxVal - minVal;
      expect(peakToPeak, closeTo(expectedPeakToPeak, expectedPeakToPeak * 0.05));
    });

    test('空入力は空を返す', () {
      expect(filter.apply([], 0.01), isEmpty);
    });
  });

  group('DifferentiationFilter', () {
    const filter = DifferentiationFilter();

    test('線形入力の微分は定数', () {
      const dt = 0.01;
      const slope = 5.0;
      final x = List<double>.generate(100, (i) => slope * i * dt);
      final y = filter.apply(x, dt);

      // 中間部は slope になるはず
      for (var i = 1; i < y.length - 1; i++) {
        expect(y[i], closeTo(slope, 1e-6));
      }
    });

    test('定数入力の微分はゼロ', () {
      final x = List<double>.filled(50, 3.14);
      final y = filter.apply(x, 0.01);
      for (final v in y) {
        expect(v, closeTo(0.0, 1e-10));
      }
    });

    test('空入力は空を返す', () {
      expect(filter.apply([], 0.01), isEmpty);
    });

    test('1要素入力は0を返す', () {
      expect(filter.apply([5.0], 0.01), equals([0.0]));
    });
  });

  group('ButterworthLpf', () {
    test('通過帯域の信号はほぼ通過する', () {
      // fs = 100 Hz, カットオフ 20 Hz, 5 Hz 信号 → 通過
      const dt = 0.01;
      const n = 2048;
      final signal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 5.0 * i * dt),
      );

      const lpf = ButterworthLpf(cutoffHz: 20);
      final filtered = lpf.apply(signal, dt);

      final inRms = _rms(signal.sublist(n ~/ 4));
      final outRms = _rms(filtered.sublist(n ~/ 4));

      // 通過帯域では信号がほぼ保存される（80% 以上）
      expect(outRms, greaterThan(inRms * 0.8));
    });

    test('阻止帯域の信号は大幅に減衰する', () {
      // fs = 100 Hz, カットオフ 5 Hz, 40 Hz 信号 → 阻止
      const dt = 0.01;
      const n = 2048;
      final signal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 40 * i * dt),
      );

      const lpf = ButterworthLpf(cutoffHz: 5);
      final filtered = lpf.apply(signal, dt);

      final inRms = _rms(signal.sublist(n ~/ 4));
      final outRms = _rms(filtered.sublist(n ~/ 4));

      // 阻止帯域では大幅に減衰（20% 以下）
      expect(outRms, lessThan(inRms * 0.20));
    });
  });

  group('ButterworthHpf', () {
    test('通過帯域の信号はほぼ通過する', () {
      // fs = 100 Hz, カットオフ 5 Hz, 30 Hz 信号 → 通過
      const dt = 0.01;
      const n = 2048;
      final signal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 30 * i * dt),
      );

      const hpf = ButterworthHpf(cutoffHz: 5);
      final filtered = hpf.apply(signal, dt);

      final inRms = _rms(signal.sublist(n ~/ 4));
      final outRms = _rms(filtered.sublist(n ~/ 4));

      expect(outRms, greaterThan(inRms * 0.8));
    });

    test('阻止帯域の信号は大幅に減衰する', () {
      // fs = 100 Hz, カットオフ 20 Hz, 1 Hz 信号 → 阻止
      const dt = 0.01;
      const n = 4096;
      final signal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 1 * i * dt),
      );

      const hpf = ButterworthHpf(cutoffHz: 20);
      final filtered = hpf.apply(signal, dt);

      final inRms = _rms(signal.sublist(n ~/ 4));
      final outRms = _rms(filtered.sublist(n ~/ 4));

      expect(outRms, lessThan(inRms * 0.20));
    });
  });

  group('ButterworthBpf', () {
    test('通過帯域の信号はほぼ通過し、阻止帯域は減衰する', () {
      const dt = 0.01;
      const n = 8192;

      // 通過帯域: 5〜20 Hz, 10 Hz 信号
      final passSignal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 10 * i * dt),
      );
      // 阻止帯域: 1 Hz 信号（HPF カットオフ 5 Hz の遥か下）
      final stopLowSignal = List<double>.generate(
        n,
        (i) => math.sin(2 * math.pi * 1 * i * dt),
      );

      const bpf = ButterworthBpf(lowHz: 5, highHz: 20);

      final filteredPass = bpf.apply(passSignal, dt);
      final filteredStopLow = bpf.apply(stopLowSignal, dt);

      // 中央部分（安定域）で評価
      const start = n ~/ 4;
      const end = 3 * n ~/ 4;
      final passRatio = _rms(filteredPass.sublist(start, end)) /
          _rms(passSignal.sublist(start, end));
      final stopLowRatio = _rms(filteredStopLow.sublist(start, end)) /
          _rms(stopLowSignal.sublist(start, end));

      // 通過帯域での信号保存（50% 以上）
      expect(passRatio, greaterThan(0.5));
      // 阻止帯域での大幅減衰（10% 以下）
      expect(stopLowRatio, lessThan(0.10));
    });
  });
}
