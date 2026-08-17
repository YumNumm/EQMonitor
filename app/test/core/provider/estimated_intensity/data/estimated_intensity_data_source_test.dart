import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EstimatedIntensityDataSource', () {
    test('M8で断層半径の外側にある遠方点は近距離点より低い震度になる', () {
      final intensities = EstimatedIntensityDataSource()
          .getEstimatedIntensity(
            points: const <CalculationPoint>[
              (lat: 35, lon: 135.55, arv400: 1),
              (lat: 35, lon: 136.1, arv400: 1),
            ],
            jmaMagnitude: 8,
            depth: 10,
            hypocenter: (lat: 35, lon: 135),
          )
          .toList();

      expect(intensities.first - intensities.last, greaterThan(0.5));
    });
  });
}
