import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
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
              isOver: false,
              isImportant: false,
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
                  maxHeight: api.TsunamiRegionForecastMaxHeight(
                    value: 4,
                    isOver: false,
                    isImportant: false,
                  ),
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
                  isUnidentifiable: false,
                  isMissing: false,
                ),
                maxHeight: api.TsunamiStationObservationMaxHeight(
                  value: maxValue,
                  isOver: false,
                  isRising: false,
                  isMissing: false,
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
            isUnidentifiable: false,
            isMissing: false,
          ),
          maxHeight: api.TsunamiStationObservationMaxHeight(
            value: maxValue,
            isOver: false,
            isRising: false,
            isMissing: false,
          ),
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

  test('forecastFirstHeight の変化点のみが記録される', () {
    api.TsunamiState stateWithFirstHeight({
      DateTime? arrivalTime,
      api.FirstHeightCondition? condition,
    }) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          forecast: api.TsunamiRegionForecast(
            firstHeight: api.TsunamiRegionForecastFirstHeight(
              arrivalTime: arrivalTime,
              condition: condition,
            ),
          ),
        ),
      ],
    );

    final arrivalTime1 = DateTime(2026, 1, 15, 14, 30);
    final arrivalTime2 = DateTime(2026, 1, 15, 14, 45);

    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithFirstHeight(
            arrivalTime: arrivalTime1,
            condition: api.FirstHeightCondition.imminent,
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithFirstHeight(
            arrivalTime: arrivalTime1,
            condition: api.FirstHeightCondition.imminent,
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithFirstHeight(
            arrivalTime: arrivalTime2,
            condition: api.FirstHeightCondition.arriving,
          ),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(
      region.forecastFirstHeight.map((e) => e.telegramId),
      ['t1', 't3'],
    );
    expect(region.forecastFirstHeight[0].value, isNotNull);
    expect(region.forecastFirstHeight[0].value!.arrivalTime, arrivalTime1);
    expect(
      region.forecastFirstHeight[0].value!.condition,
      FirstHeightCondition.imminent,
    );
    expect(region.forecastFirstHeight[1].value!.arrivalTime, arrivalTime2);
    expect(
      region.forecastFirstHeight[1].value!.condition,
      FirstHeightCondition.arriving,
    );
  });

  test('estimationFirstHeight の変化点が記録される', () {
    final arrivalTime1 = DateTime(2026, 1, 15, 14);

    api.TsunamiState stateWithEstimation({
      DateTime? arrivalTime,
      bool isAlreadyArrived = false,
    }) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          estimation: api.TsunamiRegionEstimation(
            firstHeight: api.TsunamiRegionEstimationFirstHeight(
              arrivalTime: arrivalTime,
              isAlreadyArrived: isAlreadyArrived,
            ),
            maxHeight: const api.TsunamiRegionEstimationMaxHeight(
              value: 3,
              isOver: false,
              isObserving: false,
            ),
          ),
        ),
      ],
    );

    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithEstimation(arrivalTime: arrivalTime1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithEstimation(arrivalTime: arrivalTime1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithEstimation(isAlreadyArrived: true),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(
      region.estimationFirstHeight.map((e) => e.telegramId),
      ['t1', 't3'],
    );
    expect(
      region.estimationFirstHeight[0].value,
      TsunamiEstimationFirstHeight(
        arrivalTime: arrivalTime1,
        isAlreadyArrived: false,
        revise: null,
      ),
    );
    expect(
      region.estimationFirstHeight[1].value,
      const TsunamiEstimationFirstHeight(
        arrivalTime: null,
        isAlreadyArrived: true,
        revise: null,
      ),
    );
  });

  test('estimationMaxHeight の変化点が記録される', () {
    final observedAt1 = DateTime(2026, 1, 15, 14);
    final observedAt2 = DateTime(2026, 1, 15, 15);

    api.TsunamiState stateWithEstimationMax({
      DateTime? observedAt,
      num? value,
      api.QualitativeHeight? qualitative,
    }) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          estimation: api.TsunamiRegionEstimation(
            firstHeight: const api.TsunamiRegionEstimationFirstHeight(
              isAlreadyArrived: false,
            ),
            maxHeight: api.TsunamiRegionEstimationMaxHeight(
              observedAt: observedAt,
              value: value,
              qualitative: qualitative,
              isOver: false,
              isObserving: false,
            ),
          ),
        ),
      ],
    );

    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithEstimationMax(
            observedAt: observedAt1,
            value: 3,
            qualitative: api.QualitativeHeight.high,
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithEstimationMax(
            observedAt: observedAt1,
            value: 3,
            qualitative: api.QualitativeHeight.high,
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithEstimationMax(
            observedAt: observedAt2,
            value: 5,
            qualitative: api.QualitativeHeight.enormous,
          ),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(
      region.estimationMaxHeight.map((e) => e.telegramId),
      ['t1', 't3'],
    );
    expect(region.estimationMaxHeight[0].value?.dateTime, observedAt1);
    expect(region.estimationMaxHeight[0].value?.value, 3.0);
    expect(
      region.estimationMaxHeight[0].value?.qualitative,
      QualitativeHeight.high,
    );
    expect(region.estimationMaxHeight[1].value?.dateTime, observedAt2);
    expect(region.estimationMaxHeight[1].value?.value, 5.0);
    expect(
      region.estimationMaxHeight[1].value?.qualitative,
      QualitativeHeight.enormous,
    );
  });

  test('station forecast の変化点が記録される', () {
    final highTideAt1 = DateTime(2026, 1, 15, 18);
    final highTideAt2 = DateTime(2026, 1, 15, 19);

    api.TsunamiState stateWithStationForecast(DateTime highTideAt) => stateWith(
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
              forecast: api.TsunamiStationForecast(
                highTideAt: highTideAt,
                firstHeight: const api.TsunamiStationForecastFirstHeight(
                  condition: api.FirstHeightCondition.imminent,
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
          state: stateWithStationForecast(highTideAt1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithStationForecast(highTideAt1),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWithStationForecast(highTideAt2),
        ),
      ],
    );

    final station = response.toTrackedTimeline().regions.single.stations.single;

    expect(station.forecast.map((e) => e.telegramId), ['t1', 't3']);
    expect(station.forecast[0].value?.highTideAt, highTideAt1);
    expect(
      station.forecast[0].value?.firstHeight?.condition,
      FirstHeightCondition.imminent,
    );
    expect(station.forecast[1].value?.highTideAt, highTideAt2);
  });

  test('estimation が null→非null→null に遷移すると3変化点になる', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
                estimation: api.TsunamiRegionEstimation(
                  firstHeight: api.TsunamiRegionEstimationFirstHeight(
                    isAlreadyArrived: true,
                  ),
                  maxHeight: api.TsunamiRegionEstimationMaxHeight(
                    value: 5,
                    isOver: false,
                    isObserving: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 15, 2)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
            ],
          ),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(
      region.estimationFirstHeight.map((e) => e.telegramId),
      ['t1', 't2', 't3'],
    );
    expect(region.estimationFirstHeight[0].value, isNull);
    expect(region.estimationFirstHeight[1].value, isNotNull);
    expect(region.estimationFirstHeight[1].value!.isAlreadyArrived, isTrue);
    expect(region.estimationFirstHeight[2].value, isNull);

    expect(
      region.estimationMaxHeight.map((e) => e.telegramId),
      ['t1', 't2', 't3'],
    );
    expect(region.estimationMaxHeight[0].value, isNull);
    expect(region.estimationMaxHeight[1].value?.value, 5.0);
    expect(region.estimationMaxHeight[2].value, isNull);
  });

  test('複数地域が独立して追跡される', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
              const api.TsunamiRegion(
                code: '200',
                name: '岩手',
                kind: api.TsunamiWarningKind.advisory,
                lastKind: api.TsunamiWarningKind.advisory,
                stations: [],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.majorWarning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
              const api.TsunamiRegion(
                code: '200',
                name: '岩手',
                kind: api.TsunamiWarningKind.advisory,
                lastKind: api.TsunamiWarningKind.advisory,
                stations: [],
              ),
            ],
          ),
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.regions, hasLength(2));
    expect(timeline.regions[0].code, '100');
    expect(timeline.regions[0].kind.map((e) => e.value), [
      TsunamiWarningKind.warning,
      TsunamiWarningKind.majorWarning,
    ]);
    expect(timeline.regions[1].code, '200');
    expect(timeline.regions[1].kind.map((e) => e.value), [
      TsunamiWarningKind.advisory,
    ]);
  });

  test('後続電文で新しい地域が追加されると両方追跡される', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
              const api.TsunamiRegion(
                code: '200',
                name: '岩手',
                kind: api.TsunamiWarningKind.advisory,
                lastKind: api.TsunamiWarningKind.none,
                stations: [],
              ),
            ],
          ),
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.regions, hasLength(2));
    expect(timeline.regions[0].code, '100');
    expect(timeline.regions[0].kind, hasLength(1));
    expect(timeline.regions[1].code, '200');
    expect(timeline.regions[1].kind.single.value, TsunamiWarningKind.advisory);
    expect(timeline.regions[1].kind.single.telegramId, 't2');
  });

  test('後続電文で新しい観測点が追加される', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [
                  api.TsunamiRegionStation(code: 'S1', name: '石巻'),
                ],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [
                  api.TsunamiRegionStation(code: 'S1', name: '石巻'),
                  api.TsunamiRegionStation(
                    code: 'S2',
                    name: '仙台',
                    observation: api.TsunamiStationObservation(
                      firstHeight: api.TsunamiStationObservationFirstHeight(
                        initial: api.WaveInitial.push,
                        isUnidentifiable: false,
                        isMissing: false,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(region.stations, hasLength(2));
    expect(region.stations[0].code, 'S1');
    expect(region.stations[1].code, 'S2');
    expect(region.stations[1].observation.single.telegramId, 't2');
  });

  test('offshore-station の firstHeight (非null型) の変化点が正しく記録される', () {
    final arrivalTime1 = DateTime(2026, 1, 15, 14, 30);

    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            offshoreStations: [
              const api.TsunamiOffshoreStation(
                code: 'O1',
                name: '金華山沖',
                firstHeight: api.TsunamiStationObservationFirstHeight(
                  initial: api.WaveInitial.push,
                  isUnidentifiable: false,
                  isMissing: false,
                ),
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            offshoreStations: [
              api.TsunamiOffshoreStation(
                code: 'O1',
                name: '金華山沖',
                firstHeight: api.TsunamiStationObservationFirstHeight(
                  arrivalTime: arrivalTime1,
                  initial: api.WaveInitial.push,
                  isUnidentifiable: false,
                  isMissing: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final offshore = response.toTrackedTimeline().offshoreStations.single;

    expect(offshore.firstHeight, hasLength(2));
    expect(offshore.firstHeight[0].value.arrivalTime, isNull);
    expect(offshore.firstHeight[0].value.initial, WaveInitial.push);
    expect(offshore.firstHeight[1].value.arrivalTime, arrivalTime1);
  });

  test('station forecast null→非null 遷移が記録される', () {
    final highTideAt = DateTime(2026, 1, 15, 18);
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [
                  api.TsunamiRegionStation(code: 'S1', name: '石巻'),
                ],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
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
                    forecast: api.TsunamiStationForecast(
                      highTideAt: highTideAt,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final station = response.toTrackedTimeline().regions.single.stations.single;

    expect(station.forecast, hasLength(2));
    expect(station.forecast[0].value, isNull);
    expect(station.forecast[1].value, isNotNull);
    expect(station.forecast[1].value!.highTideAt, highTideAt);
  });

  test('電文メタ (headline, revokedAt, targetedAt) が正しく保持される', () {
    final revokedAt = DateTime(2026, 1, 15, 5);
    final targetedAt = DateTime(2026, 1, 15, 3);
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: api.LatestTelegram(
            id: 't1',
            type: api.TelegramType.vtse51,
            title: '津波警報',
            editorialOffice: '気象庁',
            publishingOffice: const ['気象庁'],
            pressedAt: DateTime(2026, 1, 15),
            reportedAt: DateTime(2026, 1, 15),
            infoKind: '津波警報・注意報・予報a',
            headline: '津波警報が発表されました',
            revokedAt: revokedAt,
            targetedAt: targetedAt,
            serialNo: 3,
          ),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [],
              ),
            ],
          ),
        ),
      ],
    );

    final meta = response.toTrackedTimeline().telegrams.single;

    expect(meta.telegramId, 't1');
    expect(meta.title, '津波警報');
    expect(meta.headline, '津波警報が発表されました');
    expect(meta.revokedAt, revokedAt);
    expect(meta.targetedAt, targetedAt);
    expect(meta.serialNo, 3);
    expect(meta.infoKind, '津波警報・注意報・予報a');
  });

  test('空の電文リストでは空のタイムラインが返る', () {
    const response = api.TsunamiTelegramsResponse(telegrams: []);
    final timeline = response.toTrackedTimeline();

    expect(timeline.telegrams, isEmpty);
    expect(timeline.regions, isEmpty);
    expect(timeline.offshoreStations, isEmpty);
  });

  test('kind と lastKind が独立して追跡される', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.advisory,
                stations: [],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.majorWarning,
                lastKind: api.TsunamiWarningKind.advisory,
                stations: [],
              ),
            ],
          ),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(region.kind, hasLength(2));
    expect(
      region.kind.map((e) => e.value),
      [TsunamiWarningKind.warning, TsunamiWarningKind.majorWarning],
    );
    expect(region.lastKind, hasLength(1));
    expect(region.lastKind.single.value, TsunamiWarningKind.advisory);
  });

  test('station observation null→非null 遷移が記録される', () {
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWith(
            regions: [
              const api.TsunamiRegion(
                code: '100',
                name: '宮城',
                kind: api.TsunamiWarningKind.warning,
                lastKind: api.TsunamiWarningKind.warning,
                stations: [
                  api.TsunamiRegionStation(code: 'S1', name: '石巻'),
                ],
              ),
            ],
          ),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWith(
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
                      firstHeight: api.TsunamiStationObservationFirstHeight(
                        arrivalTime: DateTime(2026, 1, 15, 14),
                        initial: api.WaveInitial.pull,
                        isUnidentifiable: false,
                        isMissing: false,
                      ),
                      maxHeight: const api.TsunamiStationObservationMaxHeight(
                        value: 1.5,
                        isOver: false,
                        isRising: false,
                        isMissing: false,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final station = response.toTrackedTimeline().regions.single.stations.single;

    expect(station.observation, hasLength(2));
    expect(station.observation[0].value, isNull);
    expect(station.observation[1].value, isNotNull);
    expect(
      station.observation[1].value!.firstHeight.arrivalTime,
      DateTime(2026, 1, 15, 14),
    );
    expect(station.observation[1].value!.firstHeight.initial, WaveInitial.pull);
    expect(station.observation[1].value!.maxHeight?.value, 1.5);
  });

  test('forecastFirstHeight の revise フィールドも変化点判定に含まれる', () {
    api.TsunamiState stateWithRevise(api.Revise? revise) => stateWith(
      regions: [
        api.TsunamiRegion(
          code: '100',
          name: '宮城',
          kind: api.TsunamiWarningKind.warning,
          lastKind: api.TsunamiWarningKind.warning,
          stations: const [],
          forecast: api.TsunamiRegionForecast(
            firstHeight: api.TsunamiRegionForecastFirstHeight(
              arrivalTime: DateTime(2026, 1, 15, 14),
              revise: revise,
            ),
          ),
        ),
      ],
    );

    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 15)),
          state: stateWithRevise(null),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 15, 1)),
          state: stateWithRevise(api.Revise.update),
        ),
      ],
    );

    final region = response.toTrackedTimeline().regions.single;

    expect(region.forecastFirstHeight, hasLength(2));
    expect(region.forecastFirstHeight[0].value?.revise, isNull);
    expect(region.forecastFirstHeight[1].value?.revise, Revise.update);
  });
}
