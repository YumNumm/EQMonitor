import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_station_index.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_estimated_region_calculator.dart';
import 'package:eqmonitor/feature/eew/data/logic/s_wave_travel_time_lookup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const calculator = EewEstimatedRegionCalculator(
    sWaveTravelTimeLookup: SWaveTravelTimeLookup(),
  );
  final originTime = DateTime.utc(2026, 8, 17);

  group('EewEstimatedRegionCalculator', () {
    test('震度は最大地点、到達時刻は最早地点から独立して集約する', () {
      final result = calculator.calculate(
        stations: [
          station(regionCode: '100', longitude: 135),
          station(regionCode: '100', longitude: 136),
        ],
        intensities: const [3, 6],
        tables: travelTimeTables,
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: originTime,
      );

      expect(result.single.intensity, 6);
      expect(
        result.single.sWaveArrivalTime,
        originTime.add(const Duration(seconds: 10)),
      );
    });

    test('走時表の距離軸には深さを合成せず震央距離を使う', () {
      final result = calculator.calculate(
        stations: [station(regionCode: '100', longitude: 135)],
        intensities: const [4],
        tables: travelTimeTables,
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: originTime,
      );

      expect(
        result.single.sWaveArrivalTime,
        originTime.add(const Duration(seconds: 10)),
      );
    });

    test('regionCodeごとに最大震度と最早到達時刻を集約する', () {
      final result = calculator.calculate(
        stations: [
          station(regionCode: '100', longitude: 135),
          station(regionCode: '100', longitude: 136),
          station(regionCode: '200', longitude: 135),
          station(regionCode: '200', longitude: 136),
        ],
        intensities: const [3, 6, 5, 4],
        tables: travelTimeTables,
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: originTime,
      );

      expect(result, hasLength(2));
      expect(result[0].regionCode, '100');
      expect(result[0].intensity, 6);
      expect(
        result[0].sWaveArrivalTime,
        originTime.add(const Duration(seconds: 10)),
      );
      expect(result[1].regionCode, '200');
      expect(result[1].intensity, 5);
      expect(
        result[1].sWaveArrivalTime,
        originTime.add(const Duration(seconds: 10)),
      );
    });

    test('観測点と震度の件数が一致しない場合は空リストを返す', () {
      final result = calculator.calculate(
        stations: [station(regionCode: '100', longitude: 135)],
        intensities: const [],
        tables: travelTimeTables,
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: originTime,
      );

      expect(result, isEmpty);
    });

    test('発震時刻がない場合も最大震度を集約して到達時刻をnullにする', () {
      final result = calculator.calculate(
        stations: [
          station(regionCode: '100', longitude: 135),
          station(regionCode: '100', longitude: 136),
        ],
        intensities: const [3, 6],
        tables: travelTimeTables,
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: null,
      );

      expect(result.single.intensity, 6);
      expect(result.single.sWaveArrivalTime, isNull);
    });

    test('一部地点が走時表の範囲外でも取得可能な地点の最早時刻を使う', () {
      final result = calculator.calculate(
        stations: [
          station(regionCode: '100', longitude: 135),
          station(regionCode: '100', longitude: 138),
        ],
        intensities: const [3, 6],
        tables: const TravelTimeTables(
          table: [
            TravelTimeTable(p: 5, s: 10, depth: 100, distance: 0),
            TravelTimeTable(p: 10, s: 20, depth: 100, distance: 100),
          ],
        ),
        depth: 100,
        latitude: 35,
        longitude: 135,
        originTime: originTime,
      );

      expect(result.single.intensity, 6);
      expect(
        result.single.sWaveArrivalTime,
        originTime.add(const Duration(seconds: 10)),
      );
    });
  });
}

EstimatedIntensityRegionStation station({
  required String regionCode,
  required double longitude,
}) => (
  regionCode: regionCode,
  regionName: '地域$regionCode',
  point: (lat: 35, lon: longitude, arv400: 1),
);

const travelTimeTables = TravelTimeTables(
  table: [
    TravelTimeTable(p: 5, s: 10, depth: 100, distance: 0),
    TravelTimeTable(p: 10, s: 20, depth: 100, distance: 100),
    TravelTimeTable(p: 15, s: 30, depth: 100, distance: 200),
  ],
);
