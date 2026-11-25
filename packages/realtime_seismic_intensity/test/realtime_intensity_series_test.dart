import 'dart:math';

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
  });
}
