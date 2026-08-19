import 'package:eqmonitor/feature/location/data/logic/current_location_precision.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  const resolver = CurrentLocationPrecisionResolver();

  group('CurrentLocationPrecisionResolver.resolve', () {
    test('精度許可あり・水平精度が閾値以内なら市区町村まで使う', () {
      expect(
        resolver.resolve(
          accuracyStatus: LocationAccuracyStatus.precise,
          horizontalAccuracyMeters: 65,
        ),
        CurrentLocationPrecision.city,
      );
    });

    test('水平精度が閾値ちょうどなら市区町村まで使う', () {
      expect(
        resolver.resolve(
          accuracyStatus: LocationAccuracyStatus.precise,
          horizontalAccuracyMeters: currentLocationCityAccuracyThresholdMeters,
        ),
        CurrentLocationPrecision.city,
      );
    });

    test('水平精度が閾値を超えたら細分区域に留める', () {
      expect(
        resolver.resolve(
          accuracyStatus: LocationAccuracyStatus.precise,
          horizontalAccuracyMeters:
              currentLocationCityAccuracyThresholdMeters + 0.1,
        ),
        CurrentLocationPrecision.region,
      );
    });

    test('「おおよその位置」許可なら水平精度が良くても細分区域に留める', () {
      expect(
        resolver.resolve(
          accuracyStatus: LocationAccuracyStatus.reduced,
          horizontalAccuracyMeters: 10,
        ),
        CurrentLocationPrecision.region,
      );
    });

    test('権限精度が未取得なら細分区域に留める', () {
      expect(
        resolver.resolve(
          accuracyStatus: null,
          horizontalAccuracyMeters: 10,
        ),
        CurrentLocationPrecision.region,
      );
    });

    test('水平精度が不明・無効値なら細分区域に留める', () {
      for (final accuracy in <double?>[null, 0, -1]) {
        expect(
          resolver.resolve(
            accuracyStatus: LocationAccuracyStatus.precise,
            horizontalAccuracyMeters: accuracy,
          ),
          CurrentLocationPrecision.region,
          reason: 'horizontalAccuracyMeters=$accuracy',
        );
      }
    });
  });
}
