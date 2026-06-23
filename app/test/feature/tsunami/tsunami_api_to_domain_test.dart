import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
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
  group('enum toDomain', () {
    test('TsunamiWarningKind の全値が変換される', () {
      expect(
        api.TsunamiWarningKind.majorWarning.toDomain(),
        TsunamiWarningKind.majorWarning,
      );
      expect(
        api.TsunamiWarningKind.warning.toDomain(),
        TsunamiWarningKind.warning,
      );
      expect(
        api.TsunamiWarningKind.warningCancel.toDomain(),
        TsunamiWarningKind.warningCancel,
      );
      expect(
        api.TsunamiWarningKind.advisory.toDomain(),
        TsunamiWarningKind.advisory,
      );
      expect(
        api.TsunamiWarningKind.advisoryCancel.toDomain(),
        TsunamiWarningKind.advisoryCancel,
      );
      expect(
        api.TsunamiWarningKind.forecast.toDomain(),
        TsunamiWarningKind.forecast,
      );
      expect(
        api.TsunamiWarningKind.none.toDomain(),
        TsunamiWarningKind.none,
      );
    });

    test('Revise の全値が変換される', () {
      expect(api.Revise.addition.toDomain(), Revise.addition);
      expect(api.Revise.update.toDomain(), Revise.update);
    });

    test('QualitativeHeight の全値が変換される', () {
      expect(
        api.QualitativeHeight.enormous.toDomain(),
        QualitativeHeight.enormous,
      );
      expect(
        api.QualitativeHeight.high.toDomain(),
        QualitativeHeight.high,
      );
    });

    test('FirstHeightCondition の全値が変換される', () {
      expect(
        api.FirstHeightCondition.arriving.toDomain(),
        FirstHeightCondition.arriving,
      );
      expect(
        api.FirstHeightCondition.firstWaveConfirmed.toDomain(),
        FirstHeightCondition.firstWaveConfirmed,
      );
      expect(
        api.FirstHeightCondition.imminent.toDomain(),
        FirstHeightCondition.imminent,
      );
    });

    test('WaveInitial の全値が変換される', () {
      expect(api.WaveInitial.push.toDomain(), WaveInitial.push);
      expect(api.WaveInitial.pull.toDomain(), WaveInitial.pull);
    });

    test('ObservationMaxHeightCondition の全値が変換される', () {
      expect(
        api.ObservationMaxHeightCondition.minor.toDomain(),
        ObservationMaxHeightCondition.minor,
      );
      expect(
        api.ObservationMaxHeightCondition.observing.toDomain(),
        ObservationMaxHeightCondition.observing,
      );
      expect(
        api.ObservationMaxHeightCondition.important.toDomain(),
        ObservationMaxHeightCondition.important,
      );
    });
  });

  group('LatestTelegram.toTelegramMeta', () {
    test('全フィールドが正しくマッピングされる', () {
      final pressedAt = DateTime(2026, 1, 15, 10);
      final reportedAt = DateTime(2026, 1, 15, 10, 5);
      final targetedAt = DateTime(2026, 1, 15, 9);
      final revokedAt = DateTime(2026, 1, 15, 12);

      final apiTelegram = api.LatestTelegram(
        id: 'telegram-001',
        type: api.TelegramType.vtse51,
        title: '津波警報・注意報・予報a',
        editorialOffice: '気象庁',
        publishingOffice: const ['気象庁'],
        pressedAt: pressedAt,
        reportedAt: reportedAt,
        infoKind: '津波警報・注意報・予報',
        serialNo: 3,
        headline: '大津波警報を発表しました',
        targetedAt: targetedAt,
        revokedAt: revokedAt,
      );

      final result = apiTelegram.toTelegramMeta();

      expect(result.telegramId, 'telegram-001');
      expect(result.serialNo, 3);
      expect(result.title, '津波警報・注意報・予報a');
      expect(result.headline, '大津波警報を発表しました');
      expect(result.publishedAt, pressedAt);
      expect(result.reportedAt, reportedAt);
      expect(result.targetedAt, targetedAt);
      expect(result.revokedAt, revokedAt);
      expect(result.infoKind, '津波警報・注意報・予報');
    });

    test('optional フィールドが null でも変換できる', () {
      final pressedAt = DateTime(2026, 1, 15);
      final apiTelegram = api.LatestTelegram(
        id: 'telegram-002',
        type: api.TelegramType.vtse51,
        title: '津波情報',
        editorialOffice: '気象庁',
        publishingOffice: const ['気象庁'],
        pressedAt: pressedAt,
        reportedAt: pressedAt,
        infoKind: '津波情報',
      );

      final result = apiTelegram.toTelegramMeta();

      expect(result.telegramId, 'telegram-002');
      expect(result.serialNo, isNull);
      expect(result.headline, isNull);
      expect(result.targetedAt, isNull);
      expect(result.revokedAt, isNull);
    });

    test('serialNo が小数を含む num でも int に変換される', () {
      final apiTelegram = api.LatestTelegram(
        id: 't1',
        type: api.TelegramType.vtse51,
        title: 't',
        editorialOffice: 'eo',
        publishingOffice: const ['po'],
        pressedAt: DateTime(2026),
        reportedAt: DateTime(2026),
        infoKind: 'k',
        serialNo: 5,
      );

      expect(apiTelegram.toTelegramMeta().serialNo, 5);
      expect(apiTelegram.toTelegramMeta().serialNo, isA<int>());
    });
  });

  group('TsunamiRegionForecastFirstHeight.toDomain', () {
    test('全フィールドが非nullの場合', () {
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      const apiModel = api.TsunamiRegionForecastFirstHeight(
        condition: api.FirstHeightCondition.imminent,
        revise: api.Revise.update,
      );
      final withArrival = api.TsunamiRegionForecastFirstHeight(
        arrivalTime: arrivalTime,
        condition: api.FirstHeightCondition.arriving,
        revise: api.Revise.addition,
      );

      final result1 = apiModel.toDomain();
      expect(result1.arrivalTime, isNull);
      expect(result1.condition, FirstHeightCondition.imminent);
      expect(result1.revise, Revise.update);

      final result2 = withArrival.toDomain();
      expect(result2.arrivalTime, arrivalTime);
      expect(result2.condition, FirstHeightCondition.arriving);
      expect(result2.revise, Revise.addition);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.TsunamiRegionForecastFirstHeight();

      final result = apiModel.toDomain();

      expect(result.arrivalTime, isNull);
      expect(result.condition, isNull);
      expect(result.revise, isNull);
    });
  });

  group('TsunamiRegionForecastMaxHeight.toDomain', () {
    test('全フィールドが非nullの場合', () {
      const apiModel = api.TsunamiRegionForecastMaxHeight(
        value: 10,
        isOver: true,
        qualitative: api.QualitativeHeight.enormous,
        isImportant: true,
        revise: api.Revise.update,
      );

      final result = apiModel.toDomain();

      expect(result.value, 10.0);
      expect(result.value, isA<double>());
      expect(result.isOver, isTrue);
      expect(result.qualitative, QualitativeHeight.enormous);
      expect(result.isImportant, isTrue);
      expect(result.revise, Revise.update);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.TsunamiRegionForecastMaxHeight();

      final result = apiModel.toDomain();

      expect(result.value, isNull);
      expect(result.isOver, isNull);
      expect(result.qualitative, isNull);
      expect(result.isImportant, isNull);
      expect(result.revise, isNull);
    });

    test('value が int の場合に double に変換される', () {
      const apiModel = api.TsunamiRegionForecastMaxHeight(value: 3);

      final result = apiModel.toDomain();

      expect(result.value, 3.0);
      expect(result.value, isA<double>());
    });
  });

  group('FirstHeight.toDomain (estimation first height)', () {
    test('全フィールドが非nullの場合', () {
      final arrivalTime = DateTime(2026, 1, 15, 14);
      final apiModel = api.FirstHeight(
        arrivalTime: arrivalTime,
        isAlreadyArrived: true,
        revise: api.Revise.update,
      );

      final result = apiModel.toDomain();

      expect(result.arrivalTime, arrivalTime);
      expect(result.isAlreadyArrived, isTrue);
      expect(result.revise, Revise.update);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.FirstHeight();

      final result = apiModel.toDomain();

      expect(result.arrivalTime, isNull);
      expect(result.isAlreadyArrived, isNull);
      expect(result.revise, isNull);
    });
  });

  group('MaxHeight.toDomain (estimation max height)', () {
    test('全フィールドが非nullの場合', () {
      final observedAt = DateTime(2026, 1, 15, 15);
      final apiModel = api.MaxHeight(
        observedAt: observedAt,
        value: 8,
        isOver: true,
        qualitative: api.QualitativeHeight.enormous,
        isObserving: false,
        revise: api.Revise.update,
      );

      final result = apiModel.toDomain();

      expect(result.dateTime, observedAt);
      expect(result.value, 8.0);
      expect(result.value, isA<double>());
      expect(result.isOver, isTrue);
      expect(result.qualitative, QualitativeHeight.enormous);
      expect(result.isObserving, isFalse);
      expect(result.revise, Revise.update);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.MaxHeight();

      final result = apiModel.toDomain();

      expect(result.dateTime, isNull);
      expect(result.value, isNull);
      expect(result.isOver, isNull);
      expect(result.qualitative, isNull);
      expect(result.isObserving, isNull);
      expect(result.revise, isNull);
    });

    test('observedAt が dateTime にマッピングされる', () {
      final observedAt = DateTime(2026, 6, 1, 12, 30);
      final apiModel = api.MaxHeight(observedAt: observedAt);

      expect(apiModel.toDomain().dateTime, observedAt);
    });
  });

  group('TsunamiStationObservationFirstHeight.toDomain', () {
    test('全フィールドが非nullの場合', () {
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      final apiModel = api.TsunamiStationObservationFirstHeight(
        arrivalTime: arrivalTime,
        initial: api.WaveInitial.push,
        isUnidentifiable: false,
        isMissing: false,
        revise: api.Revise.addition,
      );

      final result = apiModel.toDomain();

      expect(result.arrivalTime, arrivalTime);
      expect(result.initial, WaveInitial.push);
      expect(result.isUnidentifiable, isFalse);
      expect(result.isMissing, isFalse);
      expect(result.revise, Revise.addition);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.TsunamiStationObservationFirstHeight();

      final result = apiModel.toDomain();

      expect(result.arrivalTime, isNull);
      expect(result.initial, isNull);
      expect(result.isUnidentifiable, isNull);
      expect(result.isMissing, isNull);
      expect(result.revise, isNull);
    });

    test('識別不能時のパターン', () {
      const apiModel = api.TsunamiStationObservationFirstHeight(
        isUnidentifiable: true,
      );

      final result = apiModel.toDomain();

      expect(result.arrivalTime, isNull);
      expect(result.initial, isNull);
      expect(result.isUnidentifiable, isTrue);
    });

    test('欠測時のパターン', () {
      const apiModel = api.TsunamiStationObservationFirstHeight(
        isMissing: true,
      );

      final result = apiModel.toDomain();

      expect(result.arrivalTime, isNull);
      expect(result.isMissing, isTrue);
    });
  });

  group('TsunamiStationObservationMaxHeight.toDomain', () {
    test('全フィールドが非nullの場合', () {
      final observedAt = DateTime(2026, 1, 15, 15);
      final apiModel = api.TsunamiStationObservationMaxHeight(
        observedAt: observedAt,
        value: 2.5,
        isOver: false,
        isRising: true,
        condition: api.ObservationMaxHeightCondition.observing,
        isMissing: false,
        revise: api.Revise.update,
      );

      final result = apiModel.toDomain();

      expect(result.dateTime, observedAt);
      expect(result.value, 2.5);
      expect(result.isOver, isFalse);
      expect(result.isRising, isTrue);
      expect(result.condition, ObservationMaxHeightCondition.observing);
      expect(result.isMissing, isFalse);
      expect(result.revise, Revise.update);
    });

    test('全フィールドが null の場合', () {
      const apiModel = api.TsunamiStationObservationMaxHeight();

      final result = apiModel.toDomain();

      expect(result.dateTime, isNull);
      expect(result.value, isNull);
      expect(result.isOver, isNull);
      expect(result.isRising, isNull);
      expect(result.condition, isNull);
      expect(result.isMissing, isNull);
      expect(result.revise, isNull);
    });

    test('observedAt が dateTime にマッピングされる', () {
      final observedAt = DateTime(2026, 6, 1, 12, 30);
      final apiModel = api.TsunamiStationObservationMaxHeight(
        observedAt: observedAt,
      );

      expect(apiModel.toDomain().dateTime, observedAt);
    });

    test('value が int の場合に double に変換される', () {
      const apiModel = api.TsunamiStationObservationMaxHeight(value: 3);

      final result = apiModel.toDomain();

      expect(result.value, 3.0);
      expect(result.value, isA<double>());
    });

    test('上昇中で観測範囲超過のパターン', () {
      const apiModel = api.TsunamiStationObservationMaxHeight(
        value: 10,
        isOver: true,
        isRising: true,
        condition: api.ObservationMaxHeightCondition.important,
      );

      final result = apiModel.toDomain();

      expect(result.value, 10.0);
      expect(result.isOver, isTrue);
      expect(result.isRising, isTrue);
      expect(result.condition, ObservationMaxHeightCondition.important);
    });

    test('欠測時のパターン', () {
      const apiModel = api.TsunamiStationObservationMaxHeight(
        isMissing: true,
      );

      final result = apiModel.toDomain();

      expect(result.value, isNull);
      expect(result.isMissing, isTrue);
    });
  });

  group('TsunamiStationForecast.toDomain', () {
    test('firstHeight ありの場合', () {
      final highTideAt = DateTime(2026, 1, 15, 18);
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      final apiModel = api.TsunamiStationForecast(
        highTideAt: highTideAt,
        firstHeight: api.FirstHeight2(
          arrivalTime: arrivalTime,
          condition: api.FirstHeightCondition.imminent,
          revise: api.Revise.update,
        ),
      );

      final result = apiModel.toDomain();

      expect(result.highTideAt, highTideAt);
      expect(result.firstHeight, isNotNull);
      expect(result.firstHeight!.arrivalTime, arrivalTime);
      expect(result.firstHeight!.condition, FirstHeightCondition.imminent);
      expect(result.firstHeight!.revise, Revise.update);
    });

    test('firstHeight なしの場合', () {
      final highTideAt = DateTime(2026, 1, 15, 18);
      final apiModel = api.TsunamiStationForecast(highTideAt: highTideAt);

      final result = apiModel.toDomain();

      expect(result.highTideAt, highTideAt);
      expect(result.firstHeight, isNull);
    });

    test('FirstHeight2 の全フィールド null の場合', () {
      final highTideAt = DateTime(2026, 1, 15, 18);
      final apiModel = api.TsunamiStationForecast(
        highTideAt: highTideAt,
        firstHeight: const api.FirstHeight2(),
      );

      final result = apiModel.toDomain();

      expect(result.firstHeight, isNotNull);
      expect(result.firstHeight!.arrivalTime, isNull);
      expect(result.firstHeight!.condition, isNull);
      expect(result.firstHeight!.revise, isNull);
    });
  });

  group('TsunamiStationObservation.toDomain', () {
    test('sensor あり・maxHeight ありの場合', () {
      final arrivalTime = DateTime(2026, 1, 15, 14, 30);
      final observedAt = DateTime(2026, 1, 15, 15);
      final apiModel = api.TsunamiStationObservation(
        sensor: 'GPS波浪計',
        firstHeight: api.TsunamiStationObservationFirstHeight(
          arrivalTime: arrivalTime,
          initial: api.WaveInitial.push,
          isUnidentifiable: false,
          isMissing: false,
          revise: api.Revise.addition,
        ),
        maxHeight: api.TsunamiStationObservationMaxHeight(
          observedAt: observedAt,
          value: 2.5,
          isOver: false,
          isRising: true,
          condition: api.ObservationMaxHeightCondition.observing,
          isMissing: false,
          revise: api.Revise.update,
        ),
      );

      final result = apiModel.toDomain();

      expect(result.sensor, 'GPS波浪計');
      expect(result.firstHeight.arrivalTime, arrivalTime);
      expect(result.firstHeight.initial, WaveInitial.push);
      expect(result.firstHeight.isUnidentifiable, isFalse);
      expect(result.firstHeight.isMissing, isFalse);
      expect(result.firstHeight.revise, Revise.addition);
      expect(result.maxHeight, isNotNull);
      expect(result.maxHeight!.dateTime, observedAt);
      expect(result.maxHeight!.value, 2.5);
      expect(result.maxHeight!.isOver, isFalse);
      expect(result.maxHeight!.isRising, isTrue);
      expect(
        result.maxHeight!.condition,
        ObservationMaxHeightCondition.observing,
      );
      expect(result.maxHeight!.isMissing, isFalse);
      expect(result.maxHeight!.revise, Revise.update);
    });

    test('sensor なし・maxHeight なしの場合', () {
      const apiModel = api.TsunamiStationObservation(
        firstHeight: api.TsunamiStationObservationFirstHeight(
          initial: api.WaveInitial.pull,
        ),
      );

      final result = apiModel.toDomain();

      expect(result.sensor, isNull);
      expect(result.firstHeight.initial, WaveInitial.pull);
      expect(result.maxHeight, isNull);
    });

    test('firstHeight は常に非null (required)', () {
      const apiModel = api.TsunamiStationObservation(
        firstHeight: api.TsunamiStationObservationFirstHeight(),
      );

      final result = apiModel.toDomain();

      expect(result.firstHeight, isNotNull);
      expect(result.firstHeight.arrivalTime, isNull);
      expect(result.firstHeight.initial, isNull);
    });
  });

  group('複合シナリオ: TsunamiState の全観測データからの変換', () {
    api.LatestTelegram tg(String id, DateTime at) => api.LatestTelegram(
      id: id,
      type: api.TelegramType.vtse51,
      title: '津波警報・注意報・予報a',
      editorialOffice: '気象庁',
      publishingOffice: const ['気象庁'],
      pressedAt: at,
      reportedAt: at,
      infoKind: '津波警報・注意報・予報',
      headline: '大津波警報発表',
      serialNo: 1,
    );

    api.TsunamiState stateWith({
      List<api.TsunamiRegion> regions = const [],
      List<api.TsunamiOffshoreStation> offshoreStations = const [],
    }) => api.TsunamiState(
      id: 'state-001',
      eventIds: const ['event-001'],
      isActive: true,
      isCanceled: false,
      updatedAt: DateTime(2026, 1, 15),
      earthquakes: const [],
      latestTelegrams: const [],
      regions: regions,
      offshoreStations: offshoreStations,
    );

    test(
      '地域予報 (forecast) の全フィールドが正しく変換される',
      () {
        final arrivalTime = DateTime(2026, 1, 15, 14, 30);
        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                regions: [
                  api.TsunamiRegion(
                    code: '100',
                    name: '宮城県',
                    kind: api.TsunamiWarningKind.majorWarning,
                    lastKind: api.TsunamiWarningKind.warning,
                    stations: const [],
                    forecast: api.TsunamiRegionForecast(
                      firstHeight: api.TsunamiRegionForecastFirstHeight(
                        arrivalTime: arrivalTime,
                        condition: api.FirstHeightCondition.imminent,
                        revise: api.Revise.update,
                      ),
                      maxHeight: const api.TsunamiRegionForecastMaxHeight(
                        value: 10,
                        isOver: true,
                        qualitative: api.QualitativeHeight.enormous,
                        isImportant: true,
                        revise: api.Revise.update,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final timeline = response.toTrackedTimeline();
        final region = timeline.regions.single;

        expect(region.code, '100');
        expect(region.name, '宮城県');
        expect(region.kind.single.value, TsunamiWarningKind.majorWarning);
        expect(region.lastKind.single.value, TsunamiWarningKind.warning);

        final forecastFirstHeight = region.forecastFirstHeight.single.value;
        expect(forecastFirstHeight, isNotNull);
        expect(forecastFirstHeight!.arrivalTime, arrivalTime);
        expect(forecastFirstHeight.condition, FirstHeightCondition.imminent);
        expect(forecastFirstHeight.revise, Revise.update);

        final forecastMaxHeight = region.forecastMaxHeight.single.value;
        expect(forecastMaxHeight, isNotNull);
        expect(forecastMaxHeight!.value, 10.0);
        expect(forecastMaxHeight.isOver, isTrue);
        expect(forecastMaxHeight.qualitative, QualitativeHeight.enormous);
        expect(forecastMaxHeight.isImportant, isTrue);
        expect(forecastMaxHeight.revise, Revise.update);
      },
    );

    test(
      '地域推定値 (estimation) の全フィールドが正しく変換される',
      () {
        final arrivalTime = DateTime(2026, 1, 15, 14);
        final observedAt = DateTime(2026, 1, 15, 15);
        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                regions: [
                  api.TsunamiRegion(
                    code: '100',
                    name: '宮城県',
                    kind: api.TsunamiWarningKind.majorWarning,
                    lastKind: api.TsunamiWarningKind.warning,
                    stations: const [],
                    estimation: api.TsunamiRegionEstimation(
                      firstHeight: api.FirstHeight(
                        arrivalTime: arrivalTime,
                        isAlreadyArrived: true,
                        revise: api.Revise.addition,
                      ),
                      maxHeight: api.MaxHeight(
                        observedAt: observedAt,
                        value: 8,
                        isOver: true,
                        qualitative: api.QualitativeHeight.enormous,
                        isObserving: false,
                        revise: api.Revise.update,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final timeline = response.toTrackedTimeline();
        final region = timeline.regions.single;

        final estimationFirstHeight = region.estimationFirstHeight.single.value;
        expect(estimationFirstHeight, isNotNull);
        expect(estimationFirstHeight!.arrivalTime, arrivalTime);
        expect(estimationFirstHeight.isAlreadyArrived, isTrue);
        expect(estimationFirstHeight.revise, Revise.addition);

        final estimationMaxHeight = region.estimationMaxHeight.single.value;
        expect(estimationMaxHeight, isNotNull);
        expect(estimationMaxHeight!.dateTime, observedAt);
        expect(estimationMaxHeight.value, 8.0);
        expect(estimationMaxHeight.isOver, isTrue);
        expect(estimationMaxHeight.qualitative, QualitativeHeight.enormous);
        expect(estimationMaxHeight.isObserving, isFalse);
        expect(estimationMaxHeight.revise, Revise.update);
      },
    );

    test(
      '観測点予報 (station forecast) の全フィールドが正しく変換される',
      () {
        final highTideAt = DateTime(2026, 1, 15, 18);
        final arrivalTime = DateTime(2026, 1, 15, 14, 30);
        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                regions: [
                  api.TsunamiRegion(
                    code: '100',
                    name: '宮城県',
                    kind: api.TsunamiWarningKind.warning,
                    lastKind: api.TsunamiWarningKind.warning,
                    stations: [
                      api.TsunamiRegionStation(
                        code: 'S1',
                        name: '石巻港',
                        forecast: api.TsunamiStationForecast(
                          highTideAt: highTideAt,
                          firstHeight: api.FirstHeight2(
                            arrivalTime: arrivalTime,
                            condition: api.FirstHeightCondition.imminent,
                            revise: api.Revise.update,
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

        final timeline = response.toTrackedTimeline();
        final station = timeline.regions.single.stations.single;

        expect(station.code, 'S1');
        expect(station.name, '石巻港');

        final forecast = station.forecast.single.value;
        expect(forecast, isNotNull);
        expect(forecast!.highTideAt, highTideAt);
        expect(forecast.firstHeight, isNotNull);
        expect(forecast.firstHeight!.arrivalTime, arrivalTime);
        expect(forecast.firstHeight!.condition, FirstHeightCondition.imminent);
        expect(forecast.firstHeight!.revise, Revise.update);
      },
    );

    test(
      '観測点観測値 (station observation) の全フィールドが正しく変換される',
      () {
        final arrivalTime = DateTime(2026, 1, 15, 14, 30);
        final maxObservedAt = DateTime(2026, 1, 15, 15);
        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                regions: [
                  api.TsunamiRegion(
                    code: '100',
                    name: '宮城県',
                    kind: api.TsunamiWarningKind.warning,
                    lastKind: api.TsunamiWarningKind.warning,
                    stations: [
                      api.TsunamiRegionStation(
                        code: 'S1',
                        name: '石巻港',
                        observation: api.TsunamiStationObservation(
                          sensor: 'GPS波浪計',
                          firstHeight: api.TsunamiStationObservationFirstHeight(
                            arrivalTime: arrivalTime,
                            initial: api.WaveInitial.push,
                            isUnidentifiable: false,
                            isMissing: false,
                            revise: api.Revise.addition,
                          ),
                          maxHeight: api.TsunamiStationObservationMaxHeight(
                            observedAt: maxObservedAt,
                            value: 2.5,
                            isOver: false,
                            isRising: true,
                            condition:
                                api.ObservationMaxHeightCondition.observing,
                            isMissing: false,
                            revise: api.Revise.update,
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

        final timeline = response.toTrackedTimeline();
        final station = timeline.regions.single.stations.single;
        final observation = station.observation.single.value;

        expect(observation, isNotNull);
        expect(observation!.sensor, 'GPS波浪計');

        expect(observation.firstHeight.arrivalTime, arrivalTime);
        expect(observation.firstHeight.initial, WaveInitial.push);
        expect(observation.firstHeight.isUnidentifiable, isFalse);
        expect(observation.firstHeight.isMissing, isFalse);
        expect(observation.firstHeight.revise, Revise.addition);

        expect(observation.maxHeight, isNotNull);
        expect(observation.maxHeight!.dateTime, maxObservedAt);
        expect(observation.maxHeight!.value, 2.5);
        expect(observation.maxHeight!.isOver, isFalse);
        expect(observation.maxHeight!.isRising, isTrue);
        expect(
          observation.maxHeight!.condition,
          ObservationMaxHeightCondition.observing,
        );
        expect(observation.maxHeight!.isMissing, isFalse);
        expect(observation.maxHeight!.revise, Revise.update);
      },
    );

    test(
      '沖合観測点 (offshore station) の全フィールドが正しく変換される',
      () {
        final arrivalTime = DateTime(2026, 1, 15, 14);
        final maxObservedAt = DateTime(2026, 1, 15, 15);
        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                offshoreStations: [
                  api.TsunamiOffshoreStation(
                    code: 'O1',
                    name: '金華山沖GPS波浪計',
                    sensor: 'GPS波浪計',
                    firstHeight: api.TsunamiStationObservationFirstHeight(
                      arrivalTime: arrivalTime,
                      initial: api.WaveInitial.push,
                      isUnidentifiable: false,
                      isMissing: false,
                      revise: api.Revise.addition,
                    ),
                    maxHeight: api.TsunamiStationObservationMaxHeight(
                      observedAt: maxObservedAt,
                      value: 1.5,
                      isOver: false,
                      isRising: true,
                      condition: api.ObservationMaxHeightCondition.observing,
                      isMissing: false,
                      revise: api.Revise.update,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final timeline = response.toTrackedTimeline();
        final offshore = timeline.offshoreStations.single;

        expect(offshore.code, 'O1');
        expect(offshore.name, '金華山沖GPS波浪計');

        final firstHeight = offshore.firstHeight.single.value;
        expect(firstHeight.arrivalTime, arrivalTime);
        expect(firstHeight.initial, WaveInitial.push);
        expect(firstHeight.isUnidentifiable, isFalse);
        expect(firstHeight.isMissing, isFalse);
        expect(firstHeight.revise, Revise.addition);

        final maxHeight = offshore.maxHeight.single.value;
        expect(maxHeight, isNotNull);
        expect(maxHeight!.dateTime, maxObservedAt);
        expect(maxHeight.value, 1.5);
        expect(maxHeight.isOver, isFalse);
        expect(maxHeight.isRising, isTrue);
        expect(maxHeight.condition, ObservationMaxHeightCondition.observing);
        expect(maxHeight.isMissing, isFalse);
        expect(maxHeight.revise, Revise.update);
      },
    );

    test('forecast なし・estimation なしの地域が正しく変換される', () {
      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15)),
            state: stateWith(
              regions: [
                const api.TsunamiRegion(
                  code: '100',
                  name: '宮城県',
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
      final region = timeline.regions.single;

      expect(region.forecastFirstHeight.single.value, isNull);
      expect(region.forecastMaxHeight.single.value, isNull);
      expect(region.estimationFirstHeight.single.value, isNull);
      expect(region.estimationMaxHeight.single.value, isNull);
    });

    test('観測点に forecast のみ・observation のみのパターン', () {
      final highTideAt = DateTime(2026, 1, 15, 18);
      final response = api.TsunamiTelegramsResponse(
        telegrams: [
          api.TsunamiTelegramWithState(
            telegram: tg('t1', DateTime(2026, 1, 15)),
            state: stateWith(
              regions: [
                api.TsunamiRegion(
                  code: '100',
                  name: '宮城県',
                  kind: api.TsunamiWarningKind.warning,
                  lastKind: api.TsunamiWarningKind.warning,
                  stations: [
                    api.TsunamiRegionStation(
                      code: 'S1',
                      name: '石巻港',
                      forecast: api.TsunamiStationForecast(
                        highTideAt: highTideAt,
                      ),
                    ),
                    const api.TsunamiRegionStation(
                      code: 'S2',
                      name: '仙台港',
                      observation: api.TsunamiStationObservation(
                        firstHeight: api.TsunamiStationObservationFirstHeight(
                          initial: api.WaveInitial.pull,
                        ),
                      ),
                    ),
                    const api.TsunamiRegionStation(
                      code: 'S3',
                      name: '気仙沼港',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

      final timeline = response.toTrackedTimeline();
      final stations = timeline.regions.single.stations;

      expect(stations, hasLength(3));

      expect(stations[0].code, 'S1');
      expect(stations[0].forecast.single.value, isNotNull);
      expect(stations[0].forecast.single.value!.highTideAt, highTideAt);
      expect(stations[0].observation.single.value, isNull);

      expect(stations[1].code, 'S2');
      expect(stations[1].forecast.single.value, isNull);
      expect(stations[1].observation.single.value, isNotNull);
      expect(
        stations[1].observation.single.value!.firstHeight.initial,
        WaveInitial.pull,
      );

      expect(stations[2].code, 'S3');
      expect(stations[2].forecast.single.value, isNull);
      expect(stations[2].observation.single.value, isNull);
    });

    test(
      '地域・観測点・沖合の全データを含む電文が正しく変換される',
      () {
        final arrivalTime = DateTime(2026, 1, 15, 14, 30);
        final highTideAt = DateTime(2026, 1, 15, 18);
        final maxObservedAt = DateTime(2026, 1, 15, 15);

        final response = api.TsunamiTelegramsResponse(
          telegrams: [
            api.TsunamiTelegramWithState(
              telegram: tg('t1', DateTime(2026, 1, 15)),
              state: stateWith(
                regions: [
                  api.TsunamiRegion(
                    code: '100',
                    name: '宮城県',
                    kind: api.TsunamiWarningKind.majorWarning,
                    lastKind: api.TsunamiWarningKind.warning,
                    stations: [
                      api.TsunamiRegionStation(
                        code: 'S1',
                        name: '石巻港',
                        forecast: api.TsunamiStationForecast(
                          highTideAt: highTideAt,
                          firstHeight: api.FirstHeight2(
                            arrivalTime: arrivalTime,
                            condition: api.FirstHeightCondition.imminent,
                          ),
                        ),
                        observation: api.TsunamiStationObservation(
                          firstHeight: api.TsunamiStationObservationFirstHeight(
                            arrivalTime: arrivalTime,
                            initial: api.WaveInitial.push,
                          ),
                          maxHeight: api.TsunamiStationObservationMaxHeight(
                            observedAt: maxObservedAt,
                            value: 3,
                            isRising: true,
                          ),
                        ),
                      ),
                    ],
                    forecast: api.TsunamiRegionForecast(
                      firstHeight: api.TsunamiRegionForecastFirstHeight(
                        arrivalTime: arrivalTime,
                        condition: api.FirstHeightCondition.arriving,
                      ),
                      maxHeight: const api.TsunamiRegionForecastMaxHeight(
                        value: 10,
                        isOver: true,
                        qualitative: api.QualitativeHeight.enormous,
                        isImportant: true,
                      ),
                    ),
                    estimation: api.TsunamiRegionEstimation(
                      firstHeight: const api.FirstHeight(
                        isAlreadyArrived: true,
                      ),
                      maxHeight: api.MaxHeight(
                        observedAt: maxObservedAt,
                        value: 8,
                        qualitative: api.QualitativeHeight.enormous,
                      ),
                    ),
                  ),
                  const api.TsunamiRegion(
                    code: '200',
                    name: '岩手県',
                    kind: api.TsunamiWarningKind.advisory,
                    lastKind: api.TsunamiWarningKind.none,
                    stations: [],
                  ),
                ],
                offshoreStations: [
                  api.TsunamiOffshoreStation(
                    code: 'O1',
                    name: '金華山沖',
                    firstHeight: api.TsunamiStationObservationFirstHeight(
                      arrivalTime: arrivalTime,
                      initial: api.WaveInitial.push,
                    ),
                    maxHeight: api.TsunamiStationObservationMaxHeight(
                      observedAt: maxObservedAt,
                      value: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final timeline = response.toTrackedTimeline();

        expect(timeline.telegrams, hasLength(1));
        expect(timeline.telegrams.single.telegramId, 't1');
        expect(timeline.telegrams.single.headline, '大津波警報発表');

        expect(timeline.regions, hasLength(2));

        final miyagi = timeline.regions[0];
        expect(miyagi.code, '100');
        expect(miyagi.kind.single.value, TsunamiWarningKind.majorWarning);
        expect(miyagi.lastKind.single.value, TsunamiWarningKind.warning);
        expect(
          miyagi.forecastFirstHeight.single.value!.arrivalTime,
          arrivalTime,
        );
        expect(
          miyagi.forecastFirstHeight.single.value!.condition,
          FirstHeightCondition.arriving,
        );
        expect(miyagi.forecastMaxHeight.single.value!.value, 10.0);
        expect(miyagi.forecastMaxHeight.single.value!.isOver, isTrue);
        expect(
          miyagi.forecastMaxHeight.single.value!.qualitative,
          QualitativeHeight.enormous,
        );
        expect(miyagi.forecastMaxHeight.single.value!.isImportant, isTrue);
        expect(
          miyagi.estimationFirstHeight.single.value!.isAlreadyArrived,
          isTrue,
        );
        expect(miyagi.estimationMaxHeight.single.value!.value, 8.0);
        expect(
          miyagi.estimationMaxHeight.single.value!.qualitative,
          QualitativeHeight.enormous,
        );

        final station = miyagi.stations.single;
        expect(station.code, 'S1');
        expect(station.forecast.single.value!.highTideAt, highTideAt);
        expect(
          station.forecast.single.value!.firstHeight!.condition,
          FirstHeightCondition.imminent,
        );
        expect(
          station.observation.single.value!.firstHeight.initial,
          WaveInitial.push,
        );
        expect(station.observation.single.value!.maxHeight!.value, 3.0);
        expect(station.observation.single.value!.maxHeight!.isRising, isTrue);

        final iwate = timeline.regions[1];
        expect(iwate.code, '200');
        expect(iwate.kind.single.value, TsunamiWarningKind.advisory);

        final offshore = timeline.offshoreStations.single;
        expect(offshore.code, 'O1');
        expect(offshore.firstHeight.single.value.arrivalTime, arrivalTime);
        expect(offshore.firstHeight.single.value.initial, WaveInitial.push);
        expect(offshore.maxHeight.single.value!.value, 1.5);
      },
    );
  });
}
