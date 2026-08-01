import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_bounds_calculator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_eligibility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeActivityEligibility', () {
    test('通常地震かつM6.0なら対象にする', () {
      final earthquake = _earthquake(magnitude: 6);

      expect(
        const EarthquakeActivityEligibility().isEligible(earthquake),
        isTrue,
      );
    });

    test('Mが閾値未満でも最大震度5弱なら対象にする', () {
      final earthquake = _earthquake(
        magnitude: 5.9,
        maxIntensity: JmaIntensity.fiveLower,
      );

      expect(
        const EarthquakeActivityEligibility().isEligible(earthquake),
        isTrue,
      );
    });

    test('遠地地震は規模が大きくても対象にしない', () {
      final earthquake = _earthquake(
        magnitude: 8,
        earthquakeType: EarthquakeType.distant,
      );

      expect(
        const EarthquakeActivityEligibility().isEligible(earthquake),
        isFalse,
      );
    });
  });

  group('EarthquakeActivityQuery', () {
    final originTime = DateTime.utc(2026, 7, 1, 12);
    final query = EarthquakeActivityQuery(
      baseEventId: 'base',
      baseOriginTime: originTime,
      latitude: 35,
      longitude: 139,
      depth: 40,
      beforeDays: 1,
      afterDays: 365,
      radiusKm: 25,
      depthOffsetKm: 20,
    );

    test('開始時刻は地震発生時刻の指定日前になる', () {
      expect(query.start, DateTime.utc(2026, 6, 30, 12));
    });

    test('実効終了時刻は指定終了時刻と現在時刻の早い方になる', () {
      final now = DateTime.utc(2026, 7, 8, 12);

      expect(query.effectiveEnd(now: now), now);
    });

    test('深さ下限を0kmへ丸める', () {
      final shallowQuery = query.copyWith(depth: 10, depthOffsetKm: 20);

      expect(shallowQuery.depthGte, 0);
      expect(shallowQuery.depthLte, 30);
    });
  });

  test('半径25kmを包含する外接矩形を返す', () {
    const calculator = EarthquakeActivityBoundsCalculator();

    final bounds = calculator.calculate(
      latitude: 35,
      longitude: 139,
      radiusKm: 25,
    );

    expect(bounds.latitudeGte, closeTo(34.7752, 0.001));
    expect(bounds.latitudeLte, closeTo(35.2248, 0.001));
    expect(bounds.longitudeGte, closeTo(138.7255, 0.002));
    expect(bounds.longitudeLte, closeTo(139.2745, 0.002));
  });
}

Earthquake _earthquake({
  required double magnitude,
  JmaIntensity? maxIntensity,
  EarthquakeType earthquakeType = EarthquakeType.normal,
}) => Earthquake(
  eventId: 'base',
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 1, 12),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [],
  hypocenter: EarthquakeHypocenter(
    code: '001',
    name: 'テスト震源',
    coordinates: const Coordinate.latLng(latitude: 35, longitude: 139),
    magnitude: EarthquakeMagnitude.value(value: magnitude),
    depth: const EarthquakeDepth.value(value: 40),
    detailedCode: null,
    detailedName: null,
  ),
  intensity: maxIntensity == null
      ? null
      : EarthquakeIntensity(
          maxIntensity: maxIntensity,
          maxLpgmIntensity: null,
          regions: const {},
          intensityTree: const {},
          lpgmIntensityTree: const {},
        ),
  earthquakeType: earthquakeType,
  estimatedIntensityTileUrl: null,
);
