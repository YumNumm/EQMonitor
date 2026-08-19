import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EstimatedIntensityDataSource', () {
    test('震源距離から断層半径を1回だけ控除する', () {
      final intensity = EstimatedIntensityDataSource()
          .getEstimatedIntensity(
            points: const <CalculationPoint>[
              (lat: 35, lon: 135, arv400: 1),
            ],
            jmaMagnitude: 8,
            depth: 100,
            hypocenter: (lat: 35, lon: 135),
          )
          .single;

      // Mw=7.829、断層半径=58.0056108074km、震源距離=100kmより、
      // 距離減衰式へ渡す距離は 100 - 58.0056108074 = 41.9943891926km。
      expect(intensity, closeTo(5.864152324684017, 1e-12));
      expect(intensity, isNot(closeTo(5.188102686384953, 1e-6)));
      expect(intensity, isNot(closeTo(5.649711365951958, 1e-6)));
    });
  });
}
