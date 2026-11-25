import 'dart:math';
import 'dart:typed_data';

import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';
import 'package:test/test.dart';

void main() {
  final start = DateTime.utc(2026, 11, 6, 10, 39, 42);

  group('RealtimeIntensitySeries', () {
    final target = RealtimeIntensitySeries(
      startTime: start,
      values: const [1.0, 2.0, null, 3.0],
    );

    test('開始から1秒経つまでは null を返すこと', () {
      expect(target.valueAt(start), isNull);
      expect(
        target.valueAt(start.add(const Duration(milliseconds: 999))),
        isNull,
      );
      expect(
        target.valueAt(start.subtract(const Duration(seconds: 5))),
        isNull,
      );
    });

    test('直前に確定した1秒の値を返すこと', () {
      expect(target.valueAt(start.add(const Duration(seconds: 1))), 1.0);
      expect(
        target.valueAt(start.add(const Duration(milliseconds: 2500))),
        2.0,
      );
      expect(target.valueAt(start.add(const Duration(seconds: 3))), isNull);
      expect(target.valueAt(start.add(const Duration(seconds: 4))), 3.0);
    });

    test('計算周期が 0.1 秒のときは 0.1 秒ごとに値を引くこと', () {
      final tenHz = RealtimeIntensitySeries(
        startTime: start,
        values: const [1.0, 2.0, 3.0],
        interval: const Duration(milliseconds: 100),
      );

      expect(
        tenHz.valueAt(start.add(const Duration(milliseconds: 99))),
        isNull,
      );
      expect(tenHz.valueAt(start.add(const Duration(milliseconds: 150))), 1.0);
      expect(tenHz.valueAt(start.add(const Duration(milliseconds: 300))), 3.0);
      expect(
        tenHz.valueAt(start.add(const Duration(milliseconds: 400))),
        isNull,
      );
      expect(tenHz.endTime, start.add(const Duration(milliseconds: 300)));
    });

    test('記録の終端を過ぎると null を返すこと', () {
      expect(target.valueAt(start.add(const Duration(seconds: 5))), isNull);
      expect(target.endTime, start.add(const Duration(seconds: 4)));
    });

    test('最大値を返すこと', () {
      expect(target.maxValue, 3.0);
      expect(
        RealtimeIntensitySeries(startTime: start, values: const []).maxValue,
        isNull,
      );
    });
  });

  group('RealtimeIntensitySeriesCalculator', () {
    List<double> wave({required double offset}) => [
      for (var i = 0; i < 30 * 100; i++) offset + 100 * sin(2 * pi * i / 100),
    ];

    test('1秒ごとの値を返し、記録全長の平均値を差し引くこと', () {
      const calculator = RealtimeIntensitySeriesCalculator();
      final zero = List<double>.filled(30 * 100 + 50, 0);
      final withoutOffset = calculator.calculate(
        startTime: start,
        samplingRate: 100,
        ns: wave(offset: 0),
        ew: zero,
        ud: zero,
      );
      final withOffset = calculator.calculate(
        startTime: start,
        samplingRate: 100,
        ns: wave(offset: 500),
        ew: zero,
        ud: zero,
      );

      expect(withoutOffset.values, hasLength(30));
      expect(withoutOffset.values.last, 4.9);
      expect(withOffset.values.last, withoutOffset.values.last);
    });

    test('1秒刻みでは RealtimeIntensityCalculator の逐次計算と同じ値になること', () {
      final random = Random(7);
      List<double> noise(double amplitude) => [
        for (var i = 0; i < 150 * 100; i++)
          (random.nextDouble() - 0.5) * amplitude * (i ~/ 3000 + 1),
      ];
      final components = [noise(3), noise(2), noise(1)];
      final centered = [
        for (final samples in components)
          Float64List.fromList([
            for (final value in samples)
              value - samples.reduce((a, b) => a + b) / samples.length,
          ]),
      ];

      final batch = const RealtimeIntensitySeriesCalculator().calculate(
        startTime: start,
        samplingRate: 100,
        ns: components[0],
        ew: components[1],
        ud: components[2],
      );
      final streaming = RealtimeIntensityCalculator(samplingRate: 100);
      final expected = [
        for (var second = 0; second < 150; second++)
          streaming.addSecond(
            ns: Float64List.sublistView(
              centered[0],
              second * 100,
              second * 100 + 100,
            ),
            ew: Float64List.sublistView(
              centered[1],
              second * 100,
              second * 100 + 100,
            ),
            ud: Float64List.sublistView(
              centered[2],
              second * 100,
              second * 100 + 100,
            ),
          ),
      ];

      expect(batch.values, expected);
    });

    test('10 Hz では 0.1 秒ごとに値を返し、1秒刻みの値と各秒の終わりで一致すること', () {
      const calculator = RealtimeIntensitySeriesCalculator();
      final zero = List<double>.filled(30 * 100, 0);
      final everySecond = calculator.calculate(
        startTime: start,
        samplingRate: 100,
        ns: wave(offset: 0),
        ew: zero,
        ud: zero,
      );
      final tenHz = calculator.calculate(
        startTime: start,
        samplingRate: 100,
        ns: wave(offset: 0),
        ew: zero,
        ud: zero,
        stepsPerSecond: 10,
      );

      expect(tenHz.interval, const Duration(milliseconds: 100));
      expect(tenHz.values, hasLength(300));
      expect(tenHz.values.take(2), [null, null]);
      for (var second = 0; second < 30; second++) {
        expect(tenHz.values[second * 10 + 9], everySecond.values[second]);
      }
      expect(
        tenHz.valueAt(start.add(const Duration(milliseconds: 1250))),
        tenHz.values[11],
      );
    });

    test('サンプリング周波数を割り切れない計算周期は例外になること', () {
      expect(
        () => const RealtimeIntensitySeriesCalculator().calculate(
          startTime: start,
          samplingRate: 100,
          ns: const [],
          ew: const [],
          ud: const [],
          stepsPerSecond: 3,
        ),
        throwsArgumentError,
      );
    });
  });
}
