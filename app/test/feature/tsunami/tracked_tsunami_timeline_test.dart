import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 電文を組み立てるヘルパ（テスト内ローカル関数: lib のトップレベル関数禁止に倣う）
  api.LatestTelegram tg(String id, DateTime at, {num? serialNo}) =>
      api.LatestTelegram(
        id: id,
        type: api.TelegramType.vtse51,
        title: 't',
        editorialOffice: 'eo',
        publishingOffice: const ['po'],
        pressedAt: at,
        reportedAt: at,
        infoKind: 'k',
        serialNo: serialNo,
      );

  api.TsunamiState stateWith({
    List<api.TsunamiRegion> regions = const [],
    List<api.TsunamiOffshoreStation> offshoreStations = const [],
  }) => api.TsunamiState(
    id: 'x',
    eventIds: const ['e'],
    isActive: true,
    isCanceled: false,
    updatedAt: DateTime(2026),
    earthquakes: const [],
    latestTelegrams: const [],
    regions: regions,
    offshoreStations: offshoreStations,
  );

  test('kind の変化点のみが記録される', () {
    api.TsunamiState stateWithKind(api.TsunamiWarningKind kind) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: kind,
          lastKind: kind,
          stations: const [],
        ),
      ],
    );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithKind(api.TsunamiWarningKind.warning),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithKind(api.TsunamiWarningKind.warning), // 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithKind(api.TsunamiWarningKind.majorWarning), // 変化
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.telegrams.map((e) => e.telegramId), ['t1', 't2', 't3']);
    final region = timeline.regions.single;
    expect(region.kind.map((e) => e.telegramId), ['t1', 't3']);
    expect(region.kind.map((e) => e.value), [
      TsunamiWarningKind.warning,
      TsunamiWarningKind.majorWarning,
    ]);
  });

  test('multi-field concern (forecastMaxHeight) の変化点のみが記録される', () {
    api.TsunamiState stateWithMaxHeight(num value) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          forecast: api.TsunamiRegionForecast(
            maxHeight: api.TsunamiRegionForecastMaxHeight(
              value: value,
              qualitative: api.QualitativeHeight.high,
              revise: api.Revise.update,
            ),
          ),
        ),
      ],
    );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithMaxHeight(3),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithMaxHeight(3), // 全フィールド同値 → 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithMaxHeight(5), // value 変化
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(
      region.forecastMaxHeight.map((e) => e.telegramId),
      ['t1', 't3'],
    );
    expect(region.forecastMaxHeight.map((e) => e.value?.value), [3.0, 5.0]);
  });

  test('nullable tracked field の null→非null遷移が2点になる', () {
    api.TsunamiRegion region(api.TsunamiRegionForecast? forecast) =>
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          forecast: forecast,
        );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(regions: [region(null)]), // forecast なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              region(
                const api.TsunamiRegionForecast(
                  maxHeight: api.TsunamiRegionForecastMaxHeight(value: 4),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final tracked = response.toTrackedTimeline().regions.single;

    expect(
      tracked.forecastMaxHeight.map((e) => e.telegramId),
      ['t1', 't2'],
    );
    expect(tracked.forecastMaxHeight[0].value, isNull);
    expect(tracked.forecastMaxHeight[1].value?.value, 4.0);
  });

  test('station-level の observation 変化点が記録される', () {
    api.TsunamiState stateWithObservationValue(num maxValue) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: [
            api.TsunamiRegionStation(
              code: 'S1',
              name: '石巻',
              observation: api.TsunamiStationObservation(
                firstHeight: const api.TsunamiStationObservationFirstHeight(
                  initial: api.WaveInitial.push,
                ),
                maxHeight: api.TsunamiStationObservationMaxHeight(
                  value: maxValue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithObservationValue(1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithObservationValue(1), // 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithObservationValue(2), // 変化
        ),
      ],
    );

    final station = response.toTrackedTimeline().regions.single.stations.single;

    expect(station.code, 'S1');
    expect(station.observation.map((e) => e.telegramId), ['t1', 't3']);
    expect(
      station.observation.map((e) => e.value?.maxHeight?.value),
      [1.0, 2.0],
    );
  });

  test('offshore-station の変化点が記録される', () {
    api.TsunamiState stateWithOffshoreValue(num maxValue) => stateWith(
      offshoreStations: [
        api.TsunamiOffshoreStation(
          code: 'O1',
          name: '金華山沖',
          firstHeight: const api.TsunamiStationObservationFirstHeight(
            initial: api.WaveInitial.push,
          ),
          maxHeight: api.TsunamiStationObservationMaxHeight(value: maxValue),
        ),
      ],
    );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithOffshoreValue(1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithOffshoreValue(1), // 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithOffshoreValue(2), // 変化
        ),
      ],
    );

    final offshore = response.toTrackedTimeline().offshoreStations.single;

    expect(offshore.code, 'O1');
    expect(offshore.maxHeight.map((e) => e.telegramId), ['t1', 't3']);
    expect(offshore.maxHeight.map((e) => e.value?.value), [1.0, 2.0]);
  });

  test('同時刻電文は serialNo 昇順で整列される', () {
    api.TsunamiState stateWithKind(api.TsunamiWarningKind kind) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: kind,
          lastKind: kind,
          stations: const [],
        ),
      ],
    );
    final at = DateTime(2026, 1, 15);
    // 投入順は serialNo 降順だが、整列後は昇順になるべき
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t2', at, serialNo: 2),
          state: stateWithKind(api.TsunamiWarningKind.majorWarning),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t1', at, serialNo: 1),
          state: stateWithKind(api.TsunamiWarningKind.warning),
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.telegrams.map((e) => e.telegramId), ['t1', 't2']);
    expect(timeline.regions.single.kind.map((e) => e.value), [
      TsunamiWarningKind.warning,
      TsunamiWarningKind.majorWarning,
    ]);
  });
}
