import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/worker/estimated_intensity_isolate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EstimatedIntensityIsolate', () {
    late EstimatedIntensityIsolate isolate;

    const points = <CalculationPoint>[
      (lat: 35.0, lon: 139.0, arv400: 1.0),
      (lat: 35.5, lon: 139.5, arv400: 1.2),
    ];

    setUp(() async {
      isolate = await EstimatedIntensityIsolate.spawn(points: points);
    });

    tearDown(() async {
      await isolate.dispose();
    });

    test('computeSingle returns intensity per point', () async {
      final intensities = await isolate.computeSingle(
        jmaMagnitude: 5.5,
        depth: 10,
        lat: 35.2,
        lon: 139.2,
      );

      expect(intensities, hasLength(points.length));
      expect(intensities.every((value) => value.isFinite), isTrue);
    });

    test('computeMax returns max intensity across hypocenters', () async {
      final intensities = await isolate.computeMax(
        eews: [
          (
            jmaMagnitude: 5.0,
            depth: 10,
            lat: 35.0,
            lon: 139.0,
          ),
          (
            jmaMagnitude: 6.0,
            depth: 20,
            lat: 35.1,
            lon: 139.1,
          ),
        ],
      );

      expect(intensities, hasLength(points.length));
      expect(intensities.every((value) => value.isFinite), isTrue);
    });
  });
}
