import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_offshore_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_forecast.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_observation.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TsunamiTelegramMeta meta(
    String id, {
    required DateTime publishedAt,
    String title = 'title',
    String? headline,
    DateTime? revokedAt,
  }) => TsunamiTelegramMeta(
    telegramId: id,
    serialNo: 1,
    title: title,
    headline: headline,
    publishedAt: publishedAt,
    reportedAt: publishedAt,
    targetedAt: null,
    revokedAt: revokedAt,
    infoKind: 'k',
  );

  TrackedTsunamiTimeline tracked({
    required List<TsunamiTelegramMeta> telegrams,
    List<TrackedRegion> regions = const [],
    List<TrackedOffshoreStation> offshoreStations = const [],
  }) => TrackedTsunamiTimeline(
    telegrams: telegrams,
    regions: regions,
    offshoreStations: offshoreStations,
  );

  group('kindEntry', () {
    test('kind の変化点が電文メタと結合されて公開型になる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt, title: '津波警報')],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.warning,
                telegramId: 't1',
              ),
            ],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.kind.single;
      expect(entry.kind, TsunamiWarningKind.warning);
      expect(entry.telegramId, 't1');
      expect(entry.title, '津波警報');
      expect(entry.publishedAt, publishedAt);
    });

    test('複数の kind 変化点がそれぞれ異なる電文メタと結合される', () {
      final publishedAt1 = DateTime(2026, 1, 15);
      final publishedAt2 = DateTime(2026, 1, 15, 1);
      final revokedAt = DateTime(2026, 1, 15, 5);

      final result = tracked(
        telegrams: [
          meta('t1', publishedAt: publishedAt1, title: '津波注意報'),
          meta(
            't2',
            publishedAt: publishedAt2,
            title: '津波警報',
            headline: '大津波',
            revokedAt: revokedAt,
          ),
        ],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.advisory,
                telegramId: 't1',
              ),
              TrackedValue(
                value: TsunamiWarningKind.warning,
                telegramId: 't2',
              ),
            ],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final kindEntries = result.regions.single.kind;
      expect(kindEntries, hasLength(2));

      expect(kindEntries[0].kind, TsunamiWarningKind.advisory);
      expect(kindEntries[0].telegramId, 't1');
      expect(kindEntries[0].title, '津波注意報');
      expect(kindEntries[0].headline, isNull);
      expect(kindEntries[0].publishedAt, publishedAt1);
      expect(kindEntries[0].revokedAt, isNull);

      expect(kindEntries[1].kind, TsunamiWarningKind.warning);
      expect(kindEntries[1].telegramId, 't2');
      expect(kindEntries[1].title, '津波警報');
      expect(kindEntries[1].headline, '大津波');
      expect(kindEntries[1].publishedAt, publishedAt2);
      expect(kindEntries[1].revokedAt, revokedAt);
    });
  });

  group('lastKind', () {
    test('lastKind も独立してメタ結合される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.warning,
                telegramId: 't1',
              ),
            ],
            lastKind: [
              TrackedValue(
                value: TsunamiWarningKind.advisory,
                telegramId: 't1',
              ),
            ],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final lastKindEntry = result.regions.single.lastKind.single;
      expect(lastKindEntry.kind, TsunamiWarningKind.advisory);
      expect(lastKindEntry.telegramId, 't1');
      expect(lastKindEntry.publishedAt, publishedAt);
    });
  });

  group('forecastFirstHeightEntry', () {
    test('非null値のフィールドがすべてマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: [
              TrackedValue(
                value: TsunamiForecastFirstHeight(
                  arrivalTime: arrivalTime,
                  condition: FirstHeightCondition.arriving,
                  revise: Revise.update,
                ),
                telegramId: 't1',
              ),
            ],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: const [],
            stations: const [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.forecastFirstHeight.single;
      expect(entry.arrivalTime, arrivalTime);
      expect(entry.condition, FirstHeightCondition.arriving);
      expect(entry.revise, Revise.update);
      expect(entry.telegramId, 't1');
      expect(entry.publishedAt, publishedAt);
    });

    test('null値では追跡項目フィールドがすべてnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [
              TrackedValue(value: null, telegramId: 't1'),
            ],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.forecastFirstHeight.single;
      expect(entry.arrivalTime, isNull);
      expect(entry.condition, isNull);
      expect(entry.revise, isNull);
      expect(entry.telegramId, 't1');
    });
  });

  group('forecastMaxHeightEntry', () {
    test('全フィールドが正しくマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [
              TrackedValue(
                value: TsunamiForecastMaxHeight(
                  value: 10,
                  isOver: true,
                  qualitative: QualitativeHeight.enormous,
                  isImportant: true,
                  revise: Revise.update,
                ),
                telegramId: 't1',
              ),
            ],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.forecastMaxHeight.single;
      expect(entry.value, 10.0);
      expect(entry.isOver, isTrue);
      expect(entry.qualitative, QualitativeHeight.enormous);
      expect(entry.isImportant, isTrue);
      expect(entry.revise, Revise.update);
      expect(entry.telegramId, 't1');
    });

    test('null値では追跡項目フィールドがすべてnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [
              TrackedValue(value: null, telegramId: 't1'),
            ],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.forecastMaxHeight.single;
      expect(entry.value, isNull);
      expect(entry.isOver, isNull);
      expect(entry.qualitative, isNull);
      expect(entry.isImportant, isNull);
      expect(entry.revise, isNull);
    });

    test('null→非null→null の3変化点がメタ付きで公開される', () {
      final publishedAt1 = DateTime(2026, 1, 15);
      final publishedAt2 = DateTime(2026, 1, 15, 1);
      final publishedAt3 = DateTime(2026, 1, 15, 2);

      final result = tracked(
        telegrams: [
          meta('t1', publishedAt: publishedAt1, title: '第1報'),
          meta('t2', publishedAt: publishedAt2, title: '第2報'),
          meta('t3', publishedAt: publishedAt3, title: '第3報'),
        ],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [
              TrackedValue(value: null, telegramId: 't1'),
              TrackedValue(
                value: TsunamiForecastMaxHeight(
                  value: 5,
                  isOver: null,
                  qualitative: QualitativeHeight.high,
                  isImportant: null,
                  revise: null,
                ),
                telegramId: 't2',
              ),
              TrackedValue(value: null, telegramId: 't3'),
            ],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entries = result.regions.single.forecastMaxHeight;
      expect(entries, hasLength(3));

      expect(entries[0].value, isNull);
      expect(entries[0].telegramId, 't1');
      expect(entries[0].title, '第1報');

      expect(entries[1].value, 5.0);
      expect(entries[1].qualitative, QualitativeHeight.high);
      expect(entries[1].telegramId, 't2');
      expect(entries[1].title, '第2報');

      expect(entries[2].value, isNull);
      expect(entries[2].telegramId, 't3');
      expect(entries[2].title, '第3報');
    });
  });

  group('estimationFirstHeightEntry', () {
    test('全フィールドが正しくマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final arrivalTime = DateTime(2026, 1, 15, 14);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: [
              TrackedValue(
                value: TsunamiEstimationFirstHeight(
                  arrivalTime: arrivalTime,
                  isAlreadyArrived: true,
                  revise: Revise.addition,
                ),
                telegramId: 't1',
              ),
            ],
            estimationMaxHeight: const [],
            stations: const [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.estimationFirstHeight.single;
      expect(entry.arrivalTime, arrivalTime);
      expect(entry.isAlreadyArrived, isTrue);
      expect(entry.revise, Revise.addition);
      expect(entry.telegramId, 't1');
    });

    test('null値では追跡項目フィールドがすべてnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [
              TrackedValue(value: null, telegramId: 't1'),
            ],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.estimationFirstHeight.single;
      expect(entry.arrivalTime, isNull);
      expect(entry.isAlreadyArrived, isNull);
      expect(entry.revise, isNull);
    });
  });

  group('estimationMaxHeightEntry', () {
    test('全フィールドが正しくマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final observedAt = DateTime(2026, 1, 15, 14, 30);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: [
              TrackedValue(
                value: TsunamiEstimationMaxHeight(
                  dateTime: observedAt,
                  value: 8.5,
                  isOver: true,
                  qualitative: QualitativeHeight.enormous,
                  isObserving: false,
                  revise: Revise.update,
                ),
                telegramId: 't1',
              ),
            ],
            stations: const [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.estimationMaxHeight.single;
      expect(entry.dateTime, observedAt);
      expect(entry.value, 8.5);
      expect(entry.isOver, isTrue);
      expect(entry.qualitative, QualitativeHeight.enormous);
      expect(entry.isObserving, isFalse);
      expect(entry.revise, Revise.update);
      expect(entry.telegramId, 't1');
    });

    test('null値では追跡項目フィールドがすべてnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [
              TrackedValue(value: null, telegramId: 't1'),
            ],
            stations: [],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.estimationMaxHeight.single;
      expect(entry.dateTime, isNull);
      expect(entry.value, isNull);
      expect(entry.isOver, isNull);
      expect(entry.qualitative, isNull);
      expect(entry.isObserving, isNull);
      expect(entry.revise, isNull);
    });
  });

  group('stationForecastEntry', () {
    test('forecast 非null・firstHeight 非null でフラット化される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final highTideAt = DateTime(2026, 1, 15, 18);
      final arrivalTime = DateTime(2026, 1, 15, 14);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: const [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [
                  TrackedValue(
                    value: TsunamiStationForecast(
                      highTideAt: highTideAt,
                      firstHeight: TsunamiForecastFirstHeight(
                        arrivalTime: arrivalTime,
                        condition: FirstHeightCondition.imminent,
                        revise: Revise.update,
                      ),
                    ),
                    telegramId: 't1',
                  ),
                ],
                observation: const [],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.forecast.single;
      expect(entry.highTideAt, highTideAt);
      expect(entry.firstHeightArrivalTime, arrivalTime);
      expect(entry.firstHeightCondition, FirstHeightCondition.imminent);
      expect(entry.firstHeightRevise, Revise.update);
      expect(entry.telegramId, 't1');
    });

    test('forecast 非null・firstHeight null でフラット化される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final highTideAt = DateTime(2026, 1, 15, 18);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: const [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [
                  TrackedValue(
                    value: TsunamiStationForecast(
                      highTideAt: highTideAt,
                      firstHeight: null,
                    ),
                    telegramId: 't1',
                  ),
                ],
                observation: const [],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.forecast.single;
      expect(entry.highTideAt, highTideAt);
      expect(entry.firstHeightArrivalTime, isNull);
      expect(entry.firstHeightCondition, isNull);
      expect(entry.firstHeightRevise, isNull);
    });

    test('forecast null では全フィールドがnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [
                  TrackedValue(value: null, telegramId: 't1'),
                ],
                observation: [],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.forecast.single;
      expect(entry.highTideAt, isNull);
      expect(entry.firstHeightArrivalTime, isNull);
      expect(entry.firstHeightCondition, isNull);
      expect(entry.firstHeightRevise, isNull);
      expect(entry.telegramId, 't1');
    });
  });

  group('stationObservationEntry', () {
    test('observation 非null・maxHeight 非null でフラット化される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      final maxDateTime = DateTime(2026, 1, 15, 15);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: const [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: const [],
                observation: [
                  TrackedValue(
                    value: TsunamiStationObservation(
                      sensor: 'GPS波浪計',
                      firstHeight: TsunamiObservationFirstHeight(
                        arrivalTime: arrivalTime,
                        initial: WaveInitial.push,
                        isUnidentifiable: false,
                        isMissing: false,
                        revise: null,
                      ),
                      maxHeight: TsunamiObservationMaxHeight(
                        dateTime: maxDateTime,
                        value: 2.5,
                        isOver: false,
                        isRising: true,
                        condition: ObservationMaxHeightCondition.observing,
                        isMissing: false,
                        revise: Revise.update,
                      ),
                    ),
                    telegramId: 't1',
                  ),
                ],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.observation.single;
      expect(entry.sensor, 'GPS波浪計');
      expect(entry.firstHeightArrivalTime, arrivalTime);
      expect(entry.firstHeightInitial, WaveInitial.push);
      expect(entry.firstHeightIsUnidentifiable, isFalse);
      expect(entry.firstHeightIsMissing, isFalse);
      expect(entry.firstHeightRevise, isNull);
      expect(entry.maxHeightDateTime, maxDateTime);
      expect(entry.maxHeightValue, 2.5);
      expect(entry.maxHeightIsOver, isFalse);
      expect(entry.maxHeightIsRising, isTrue);
      expect(
        entry.maxHeightCondition,
        ObservationMaxHeightCondition.observing,
      );
      expect(entry.maxHeightIsMissing, isFalse);
      expect(entry.maxHeightRevise, Revise.update);
      expect(entry.telegramId, 't1');
    });

    test('observation 非null・maxHeight null ではmaxフィールドのみnull', () {
      final publishedAt = DateTime(2026, 1, 15);
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          TrackedRegion(
            code: '100',
            name: '宮城',
            kind: const [],
            lastKind: const [],
            forecastFirstHeight: const [],
            forecastMaxHeight: const [],
            estimationFirstHeight: const [],
            estimationMaxHeight: const [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: const [],
                observation: [
                  TrackedValue(
                    value: TsunamiStationObservation(
                      sensor: null,
                      firstHeight: TsunamiObservationFirstHeight(
                        arrivalTime: arrivalTime,
                        initial: WaveInitial.pull,
                        isUnidentifiable: null,
                        isMissing: null,
                        revise: null,
                      ),
                      maxHeight: null,
                    ),
                    telegramId: 't1',
                  ),
                ],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.observation.single;
      expect(entry.sensor, isNull);
      expect(entry.firstHeightArrivalTime, arrivalTime);
      expect(entry.firstHeightInitial, WaveInitial.pull);
      expect(entry.maxHeightDateTime, isNull);
      expect(entry.maxHeightValue, isNull);
      expect(entry.maxHeightIsOver, isNull);
      expect(entry.maxHeightIsRising, isNull);
      expect(entry.maxHeightCondition, isNull);
      expect(entry.maxHeightIsMissing, isNull);
      expect(entry.maxHeightRevise, isNull);
    });

    test('observation null では全フィールドがnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [],
                observation: [
                  TrackedValue(value: null, telegramId: 't1'),
                ],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.observation.single;
      expect(entry.sensor, isNull);
      expect(entry.firstHeightArrivalTime, isNull);
      expect(entry.firstHeightInitial, isNull);
      expect(entry.firstHeightIsUnidentifiable, isNull);
      expect(entry.firstHeightIsMissing, isNull);
      expect(entry.firstHeightRevise, isNull);
      expect(entry.maxHeightDateTime, isNull);
      expect(entry.maxHeightValue, isNull);
      expect(entry.maxHeightIsOver, isNull);
      expect(entry.maxHeightIsRising, isNull);
      expect(entry.maxHeightCondition, isNull);
      expect(entry.maxHeightIsMissing, isNull);
      expect(entry.maxHeightRevise, isNull);
      expect(entry.telegramId, 't1');
    });

    test('識別不能・欠測フラグが正しくフラット化される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [],
                observation: [
                  TrackedValue(
                    value: TsunamiStationObservation(
                      sensor: null,
                      firstHeight: TsunamiObservationFirstHeight(
                        arrivalTime: null,
                        initial: null,
                        isUnidentifiable: true,
                        isMissing: null,
                        revise: null,
                      ),
                      maxHeight: TsunamiObservationMaxHeight(
                        dateTime: null,
                        value: null,
                        isOver: null,
                        isRising: null,
                        condition: null,
                        isMissing: true,
                        revise: null,
                      ),
                    ),
                    telegramId: 't1',
                  ),
                ],
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.regions.single.stations.single.observation.single;
      expect(entry.firstHeightIsUnidentifiable, isTrue);
      expect(entry.firstHeightIsMissing, isNull);
      expect(entry.maxHeightIsMissing, isTrue);
      expect(entry.maxHeightCondition, isNull);
    });
  });

  group('observationFirstHeightEntry (offshore)', () {
    test('非null型の全フィールドがマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final arrivalTime = DateTime(2026, 1, 15, 14);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        offshoreStations: [
          TrackedOffshoreStation(
            code: 'O1',
            name: '金華山沖',
            firstHeight: [
              TrackedValue(
                value: TsunamiObservationFirstHeight(
                  arrivalTime: arrivalTime,
                  initial: WaveInitial.push,
                  isUnidentifiable: false,
                  isMissing: false,
                  revise: Revise.addition,
                ),
                telegramId: 't1',
              ),
            ],
            maxHeight: const [],
          ),
        ],
      ).toPublic();

      final entry = result.offshoreStations.single.firstHeight.single;
      expect(entry.arrivalTime, arrivalTime);
      expect(entry.initial, WaveInitial.push);
      expect(entry.isUnidentifiable, isFalse);
      expect(entry.isMissing, isFalse);
      expect(entry.revise, Revise.addition);
      expect(entry.telegramId, 't1');
    });

    test('フィールドがnullでもエントリは生成される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        offshoreStations: [
          const TrackedOffshoreStation(
            code: 'O1',
            name: '金華山沖',
            firstHeight: [
              TrackedValue(
                value: TsunamiObservationFirstHeight(
                  arrivalTime: null,
                  initial: null,
                  isUnidentifiable: null,
                  isMissing: true,
                  revise: null,
                ),
                telegramId: 't1',
              ),
            ],
            maxHeight: [],
          ),
        ],
      ).toPublic();

      final entry = result.offshoreStations.single.firstHeight.single;
      expect(entry.arrivalTime, isNull);
      expect(entry.initial, isNull);
      expect(entry.isMissing, isTrue);
    });
  });

  group('observationMaxHeightEntry (offshore)', () {
    test('非null値の全フィールドがマッピングされる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final observedAt = DateTime(2026, 1, 15, 15);

      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        offshoreStations: [
          TrackedOffshoreStation(
            code: 'O1',
            name: '金華山沖',
            firstHeight: const [],
            maxHeight: [
              TrackedValue(
                value: TsunamiObservationMaxHeight(
                  dateTime: observedAt,
                  value: 3.5,
                  isOver: true,
                  isRising: false,
                  condition: ObservationMaxHeightCondition.important,
                  isMissing: false,
                  revise: Revise.update,
                ),
                telegramId: 't1',
              ),
            ],
          ),
        ],
      ).toPublic();

      final entry = result.offshoreStations.single.maxHeight.single;
      expect(entry.dateTime, observedAt);
      expect(entry.value, 3.5);
      expect(entry.isOver, isTrue);
      expect(entry.isRising, isFalse);
      expect(entry.condition, ObservationMaxHeightCondition.important);
      expect(entry.isMissing, isFalse);
      expect(entry.revise, Revise.update);
      expect(entry.telegramId, 't1');
    });

    test('null値では追跡項目フィールドがすべてnullになる', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        offshoreStations: [
          const TrackedOffshoreStation(
            code: 'O1',
            name: '金華山沖',
            firstHeight: [],
            maxHeight: [TrackedValue(value: null, telegramId: 't1')],
          ),
        ],
      ).toPublic();

      final entry = result.offshoreStations.single.maxHeight.single;
      expect(entry.dateTime, isNull);
      expect(entry.value, isNull);
      expect(entry.isOver, isNull);
      expect(entry.isRising, isNull);
      expect(entry.condition, isNull);
      expect(entry.isMissing, isNull);
      expect(entry.revise, isNull);
    });
  });

  group('複合シナリオ', () {
    test('複数地域・複数観測点が正しく公開型に変換される', () {
      final publishedAt = DateTime(2026, 1, 15);
      final result = tracked(
        telegrams: [meta('t1', publishedAt: publishedAt)],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.warning,
                telegramId: 't1',
              ),
            ],
            lastKind: [
              TrackedValue(
                value: TsunamiWarningKind.advisory,
                telegramId: 't1',
              ),
            ],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [
              TrackedRegionStation(
                code: 'S1',
                name: '石巻',
                forecast: [],
                observation: [],
              ),
              TrackedRegionStation(
                code: 'S2',
                name: '仙台',
                forecast: [],
                observation: [],
              ),
            ],
          ),
          const TrackedRegion(
            code: '200',
            name: '岩手',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.majorWarning,
                telegramId: 't1',
              ),
            ],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      ).toPublic();

      expect(result.regions, hasLength(2));
      expect(result.regions[0].code, '100');
      expect(result.regions[0].name, '宮城');
      expect(result.regions[0].stations, hasLength(2));
      expect(result.regions[0].stations[0].code, 'S1');
      expect(result.regions[0].stations[1].code, 'S2');
      expect(result.regions[1].code, '200');
      expect(
        result.regions[1].kind.single.kind,
        TsunamiWarningKind.majorWarning,
      );
    });

    test('空の追跡リストでは空の公開タイムラインが返る', () {
      final result = tracked(
        telegrams: const [],
      ).toPublic();

      expect(result.telegrams, isEmpty);
      expect(result.regions, isEmpty);
      expect(result.offshoreStations, isEmpty);
    });

    test('存在しない telegramId で ArgumentError がスローされる', () {
      final timeline = tracked(
        telegrams: [meta('t1', publishedAt: DateTime(2026, 1, 15))],
        regions: [
          const TrackedRegion(
            code: '100',
            name: '宮城',
            kind: [
              TrackedValue(
                value: TsunamiWarningKind.warning,
                telegramId: 'nonexistent',
              ),
            ],
            lastKind: [],
            forecastFirstHeight: [],
            forecastMaxHeight: [],
            estimationFirstHeight: [],
            estimationMaxHeight: [],
            stations: [],
          ),
        ],
      );

      expect(timeline.toPublic, throwsArgumentError);
    });
  });

  group('E2E: API → tracked → public', () {
    api.LatestTelegram tg(
      String id,
      DateTime at, {
      String title = 't',
      String? headline,
    }) => api.LatestTelegram(
      id: id,
      type: api.TelegramType.vtse51,
      title: title,
      editorialOffice: 'eo',
      publishingOffice: const ['po'],
      pressedAt: at,
      reportedAt: at,
      infoKind: 'k',
      headline: headline,
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

    test('kind が変化しない場合は1変化点のみ公開される', () {
      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15), title: '第1報'),
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
            telegram: tg('t2', DateTime(2026, 1, 15, 1), title: '第2報'),
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
            telegram: tg('t3', DateTime(2026, 1, 15, 2), title: '第3報'),
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

      final publicTimeline = response.toTrackedTimeline().toPublic();

      expect(publicTimeline.telegrams, hasLength(3));
      final kindEntries = publicTimeline.regions.single.kind;
      expect(kindEntries, hasLength(1));
      expect(kindEntries.single.kind, TsunamiWarningKind.warning);
      expect(kindEntries.single.title, '第1報');
    });

    test('kind が変化する場合は各変化点に正しい電文メタが付く', () {
      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg(
              't1',
              DateTime(2026, 1, 15),
              title: '第1報',
              headline: '注意報発表',
            ),
            state: stateWith(
              regions: [
                const api.TsunamiRegion(
                  code: '100',
                  name: '宮城',
                  kind: api.TsunamiWarningKind.advisory,
                  lastKind: api.TsunamiWarningKind.none,
                  stations: [],
                ),
              ],
            ),
          ),
          api.TsunamiTelegramWithState(
            telegram: tg(
              't2',
              DateTime(2026, 1, 15, 1),
              title: '第2報',
              headline: '警報に切替',
            ),
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
            telegram: tg(
              't3',
              DateTime(2026, 1, 15, 2),
              title: '第3報',
              headline: '大津波警報に切替',
            ),
            state: stateWith(
              regions: [
                const api.TsunamiRegion(
                  code: '100',
                  name: '宮城',
                  kind: api.TsunamiWarningKind.majorWarning,
                  lastKind: api.TsunamiWarningKind.warning,
                  stations: [],
                ),
              ],
            ),
          ),
        ],
      );

      final publicTimeline = response.toTrackedTimeline().toPublic();

      final kindEntries = publicTimeline.regions.single.kind;
      expect(kindEntries, hasLength(3));

      expect(kindEntries[0].kind, TsunamiWarningKind.advisory);
      expect(kindEntries[0].title, '第1報');
      expect(kindEntries[0].headline, '注意報発表');

      expect(kindEntries[1].kind, TsunamiWarningKind.warning);
      expect(kindEntries[1].title, '第2報');
      expect(kindEntries[1].headline, '警報に切替');

      expect(kindEntries[2].kind, TsunamiWarningKind.majorWarning);
      expect(kindEntries[2].title, '第3報');
      expect(kindEntries[2].headline, '大津波警報に切替');

      final lastKindEntries = publicTimeline.regions.single.lastKind;
      expect(lastKindEntries, hasLength(3));
      expect(lastKindEntries[0].kind, TsunamiWarningKind.none);
      expect(lastKindEntries[1].kind, TsunamiWarningKind.advisory);
      expect(lastKindEntries[2].kind, TsunamiWarningKind.warning);
    });

    test('forecastFirstHeight が変化しない場合は1変化点のみ', () {
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);

      api.TsunamiState stateWithForecast() => stateWith(
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
                condition: api.FirstHeightCondition.imminent,
              ),
            ),
          ),
        ],
      );

      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15)),
            state: stateWithForecast(),
          ),
          api.TsunamiTelegramWithState(
            telegram: tg('t2', DateTime(2026, 1, 15, 1)),
            state: stateWithForecast(),
          ),
        ],
      );

      final publicTimeline = response.toTrackedTimeline().toPublic();

      final entries = publicTimeline.regions.single.forecastFirstHeight;
      expect(entries, hasLength(1));
      expect(entries.single.arrivalTime, arrivalTime);
      expect(entries.single.condition, FirstHeightCondition.imminent);
      expect(entries.single.telegramId, 't1');
    });

    test('forecastFirstHeight が変化すると各変化点に電文メタが付く', () {
      final arrivalTime1 = DateTime(2026, 1, 15, 14, 30);
      final arrivalTime2 = DateTime(2026, 1, 15, 14, 15);

      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15), title: '第1報'),
            state: stateWith(
              regions: [
                api.TsunamiRegion(
                  code: '100',
                  name: '宮城',
                  kind: api.TsunamiWarningKind.warning,
                  lastKind: api.TsunamiWarningKind.warning,
                  stations: const [],
                  forecast: api.TsunamiRegionForecast(
                    firstHeight: api.TsunamiRegionForecastFirstHeight(
                      arrivalTime: arrivalTime1,
                      condition: api.FirstHeightCondition.imminent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          api.TsunamiTelegramWithState(
            telegram: tg('t2', DateTime(2026, 1, 15, 1), title: '第2報'),
            state: stateWith(
              regions: [
                api.TsunamiRegion(
                  code: '100',
                  name: '宮城',
                  kind: api.TsunamiWarningKind.warning,
                  lastKind: api.TsunamiWarningKind.warning,
                  stations: const [],
                  forecast: api.TsunamiRegionForecast(
                    firstHeight: api.TsunamiRegionForecastFirstHeight(
                      arrivalTime: arrivalTime2,
                      condition: api.FirstHeightCondition.arriving,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      final publicTimeline = response.toTrackedTimeline().toPublic();

      final entries = publicTimeline.regions.single.forecastFirstHeight;
      expect(entries, hasLength(2));

      expect(entries[0].arrivalTime, arrivalTime1);
      expect(entries[0].condition, FirstHeightCondition.imminent);
      expect(entries[0].title, '第1報');

      expect(entries[1].arrivalTime, arrivalTime2);
      expect(entries[1].condition, FirstHeightCondition.arriving);
      expect(entries[1].title, '第2報');
    });

    test('station observation が複数電文で変化する場合のフラット化', () {
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      final maxDateTime = DateTime(2026, 1, 15, 15);

      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15), title: '第1報'),
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
            telegram: tg('t2', DateTime(2026, 1, 15, 1), title: '第2報'),
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
                          arrivalTime: arrivalTime,
                          initial: api.WaveInitial.push,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          api.TsunamiTelegramWithState(
            telegram: tg('t3', DateTime(2026, 1, 15, 2), title: '第3報'),
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
                          arrivalTime: arrivalTime,
                          initial: api.WaveInitial.push,
                        ),
                        maxHeight: api.TsunamiStationObservationMaxHeight(
                          observedAt: maxDateTime,
                          value: 2.5,
                          isRising: true,
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

      final publicTimeline = response.toTrackedTimeline().toPublic();

      final entries = publicTimeline.regions.single.stations.single.observation;
      expect(entries, hasLength(3));

      expect(entries[0].sensor, isNull);
      expect(entries[0].firstHeightArrivalTime, isNull);
      expect(entries[0].maxHeightValue, isNull);
      expect(entries[0].title, '第1報');

      expect(entries[1].firstHeightArrivalTime, arrivalTime);
      expect(entries[1].firstHeightInitial, WaveInitial.push);
      expect(entries[1].maxHeightValue, isNull);
      expect(entries[1].title, '第2報');

      expect(entries[2].firstHeightArrivalTime, arrivalTime);
      expect(entries[2].firstHeightInitial, WaveInitial.push);
      expect(entries[2].maxHeightValue, 2.5);
      expect(entries[2].maxHeightIsRising, isTrue);
      expect(entries[2].maxHeightDateTime, maxDateTime);
      expect(entries[2].title, '第3報');
    });

    test('offshore station の E2E 変換', () {
      final arrivalTime = DateTime(2026, 1, 15, 14);
      final maxDateTime = DateTime(2026, 1, 15, 15);

      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15), title: '第1報'),
            state: stateWith(
              offshoreStations: [
                api.TsunamiOffshoreStation(
                  code: 'O1',
                  name: '金華山沖',
                  firstHeight: api.TsunamiStationObservationFirstHeight(
                    arrivalTime: arrivalTime,
                    initial: api.WaveInitial.push,
                  ),
                ),
              ],
            ),
          ),
          api.TsunamiTelegramWithState(
            telegram: tg('t2', DateTime(2026, 1, 15, 1), title: '第2報'),
            state: stateWith(
              offshoreStations: [
                api.TsunamiOffshoreStation(
                  code: 'O1',
                  name: '金華山沖',
                  firstHeight: api.TsunamiStationObservationFirstHeight(
                    arrivalTime: arrivalTime,
                    initial: api.WaveInitial.push,
                  ),
                  maxHeight: api.TsunamiStationObservationMaxHeight(
                    observedAt: maxDateTime,
                    value: 1.5,
                    isRising: true,
                    condition: api.ObservationMaxHeightCondition.observing,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      final publicTimeline = response.toTrackedTimeline().toPublic();

      final offshore = publicTimeline.offshoreStations.single;
      expect(offshore.code, 'O1');
      expect(offshore.name, '金華山沖');

      expect(offshore.firstHeight, hasLength(1));
      expect(offshore.firstHeight.single.arrivalTime, arrivalTime);
      expect(offshore.firstHeight.single.initial, WaveInitial.push);
      expect(offshore.firstHeight.single.title, '第1報');

      expect(offshore.maxHeight, hasLength(2));
      expect(offshore.maxHeight[0].value, isNull);
      expect(offshore.maxHeight[0].title, '第1報');
      expect(offshore.maxHeight[1].value, 1.5);
      expect(offshore.maxHeight[1].isRising, isTrue);
      expect(
        offshore.maxHeight[1].condition,
        ObservationMaxHeightCondition.observing,
      );
      expect(offshore.maxHeight[1].title, '第2報');
    });
  });
}
