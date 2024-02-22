import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history_old/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_telegram.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  final createdAt = DateTime(2000);
  final baseBody = TelegramVxse45Body(
    magnitude: 2,
    depth: 100,
    originTime: createdAt,
    arrivalTime: createdAt,
    hypocenter: const EewHypocenter(
      code: '000',
      coordinate: LatLng(35, 135),
      name: 'test',
    ),
    forecastMaxInt: const ForecastMaxInt(
      from: JmaForecastIntensity.four,
      to: JmaForecastIntensityOver.four,
    ),
    forecastMaxLgInt: null,
    isLastInfo: false,
    isPlum: false,
    accuracy: const EewAccuracy(
      depth: '3',
      epicenters: ['3', '3'],
      magnitudeCalculation: '3',
      numberOfMagnitudeCalculation: '3',
    ),
    regions: [],
  );
  final baseEew = TelegramV3(
    eventId: 20000000000000,
    infoType: TelegramInfoType.issue,
    pressTime: createdAt,
    type: TelegramType.vxse45,
    schemaType: SchemaType.eewInformation,
    headline: '',
    status: TelegramStatus.normal,
    hash: '',
    body: baseBody,
  );

  const baseEewHistoryItem = EarthquakeHistoryItem(
    earthquake: EarthquakeData(
      earthquake: null,
      intensity: null,
      lgIntensity: null,
      comment: null,
      isVolcano: false,
    ),
    tsunami: null,
    telegrams: [],
    eventId: 20000000000000,
    latestEew: null,
    latestEewTelegram: null,
  );

  group(
    'EewAliveChecker',
    () {
      final checker = EewAliveChecker();
      test(
        '発表から1時間経過したEEWは、イベント終了と判定する',
        () {
          // Arrange
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [baseEew],
            latestEew: baseBody,
            latestEewTelegram: baseEew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(hours: 1, seconds: 1),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        'EEWを持たない地震履歴は、イベント終了として判定する',
        () {
          // Arrange
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [baseEew],
            latestEew: baseBody,
            latestEewTelegram: baseEew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt,
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '既にVXSE53発表済みの地震履歴は、イベント終了として判定する',
        () {
          // Arrange
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [
              baseEew,
              TelegramV3(
                eventId: 0,
                type: TelegramType.vxse53,
                schemaType: SchemaType.earthquakeInformation,
                infoType: TelegramInfoType.issue,
                status: TelegramStatus.normal,
                pressTime: createdAt,
                body: TelegramVxse53Body(
                  earthquake: Earthquake(
                    originTime: createdAt,
                    arrivalTime: createdAt,
                    hypocenter: const EarthquakeHypocenter(
                      code: '000',
                      coordinate: LatLng(35, 135),
                      depth: 100,
                      name: 'test',
                      detailed: EarthquakeHypocenterDetailed(
                        code: '000',
                        name: 'test',
                      ),
                    ),
                    magnitude: const EarthquakeMagnitude(
                      value: 3,
                      condition: null,
                    ),
                  ),
                  intensity: null,
                  comment: const CommentsOmitVar(
                    forecast: null,
                    free: null,
                  ),
                  text: null,
                ),
              ),
            ],
            latestEew: baseBody,
            latestEewTelegram: baseEew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt,
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '最新のEEWが取消報 で 発表から180秒経過している地震履歴は、イベント終了として判定する',
        () {
          // Arrange
          const body = TelegramVxse45Cancel(
            isCanceled: true,
            isLastInfo: true,
            text: '',
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            latestEew: body,
            latestEewTelegram: TelegramV3(
              eventId: 0,
              type: TelegramType.vxse45,
              schemaType: SchemaType.eewInformation,
              infoType: TelegramInfoType.cancel,
              status: TelegramStatus.normal,
              pressTime: createdAt,
              reportTime: createdAt,
              body: body,
            ),
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 181),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '最新のEEWが取消報 で 発表から180秒経過していない地震履歴は、イベント継続として判定する',
        () {
          // Arrange
          const body = TelegramVxse45Cancel(
            isCanceled: true,
            isLastInfo: true,
            text: '',
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            latestEew: body,
            latestEewTelegram: TelegramV3(
              eventId: 0,
              type: TelegramType.vxse45,
              schemaType: SchemaType.eewInformation,
              infoType: TelegramInfoType.cancel,
              status: TelegramStatus.normal,
              pressTime: createdAt,
              reportTime: createdAt,
              body: body,
            ),
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 180),
            ),
          );

          // Assert
          expect(result, false);
        },
      );

      test(
        '深さ150km未満の場合 地震発生から251秒以降で、イベント終了と判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 140,
            originTime: createdAt,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 251),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '深さ150km未満の場合 地震発生から250秒以内で、イベント継続として判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 140,
            originTime: createdAt,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 250),
            ),
          );

          // Assert
          expect(result, false);
        },
      );

      test(
        '深さ150km未満の場合 地震検知から251秒以降で、イベント終了と判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 140,
            originTime: null,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 251),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '深さ150km未満の場合 地震検知から250秒以内で、イベント継続として判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 140,
            originTime: null,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 250),
            ),
          );

          // Assert
          expect(result, false);
        },
      );

      test(
        '深さ150km以深の場合 地震発生から401秒以降で、イベント終了と判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 150,
            originTime: createdAt,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 401),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '深さ150km以深の場合 地震発生から400秒以内で、イベント継続として判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 150,
            originTime: createdAt,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 400),
            ),
          );

          // Assert
          expect(result, false);
        },
      );

      test(
        '深さ150km以深の場合 地震検知から401秒以降で、イベント終了と判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 150,
            originTime: null,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 401),
            ),
          );

          // Assert
          expect(result, true);
        },
      );

      test(
        '深さ150km以深の場合 地震検知から400秒以内で、イベント継続として判定する',
        () {
          // Arrange
          final body = baseBody.copyWith(
            depth: 150,
            originTime: null,
            arrivalTime: createdAt,
          );
          final eew = TelegramV3(
            eventId: 0,
            type: TelegramType.vxse45,
            schemaType: SchemaType.eewInformation,
            infoType: TelegramInfoType.issue,
            status: TelegramStatus.normal,
            pressTime: createdAt,
            reportTime: createdAt,
            body: body,
          );
          final earthquakeHistoryItem = baseEewHistoryItem.copyWith(
            telegrams: [eew],
            latestEew: body,
            latestEewTelegram: eew,
          );

          // Act
          final result = checker.checkMarkAsEventEnded(
            item: earthquakeHistoryItem,
            now: createdAt.add(
              const Duration(seconds: 400),
            ),
          );

          // Assert
          expect(result, false);
        },
      );
    },
  );

  group('EewAliveTelegramProvider', () {
    late final EewAliveChecker checker;

    setUpAll(() {
      registerFallbackValue(
        baseEewHistoryItem,
      );

      checker = _MockEewAliveChecker();
    });

    test(
      'EewAliveChecker#checkMarkAsEndedを1回呼び出していること',
      () {
        // Arrange
        when(
          () => checker.checkMarkAsEventEnded(
            item: any(named: 'item'),
            now: any(named: 'now'),
          ),
        ).thenReturn(true);

        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue.data([baseEewHistoryItem]),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        container.read(eewAliveTelegramProvider);

        // Assert
        verify(
          () => checker.checkMarkAsEventEnded(
            item: baseEewHistoryItem,
            now: any(named: 'now'),
          ),
        ).called(1);
      },
    );

    test(
      'EewAliveChecker#checkMarkAsEnded() => true の結果を利用していること',
      () {
        // Arrange
        when(
          () => checker.checkMarkAsEventEnded(
            item: any(named: 'item'),
            now: any(named: 'now'),
          ),
        ).thenReturn(true);

        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue.data([baseEewHistoryItem]),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result,
          isEmpty,
        );
      },
    );

    test(
      'EewAliveChecker#checkMarkAsEnded() => false の結果を利用していること',
      () {
        // Arrange
        when(
          () => checker.checkMarkAsEventEnded(
            item: any(named: 'item'),
            now: any(named: 'now'),
          ),
        ).thenReturn(false);

        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue.data([baseEewHistoryItem]),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result?.length,
          1,
        );
      },
    );
    test(
      'EewTelegramProvider が読み込み中の場合、 null になること',
      () {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue.loading(),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result,
          isNull,
        );
      },
    );

    test(
      'EewTelegramProvider がエラーの場合、 null になること',
      () {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue.error('', StackTrace.empty),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result,
          isNull,
        );
      },
    );

    test(
      'EewTelegramProvider が読み込み中で、previousデータを持っている場合、そのデータを利用していること',
      () {
        // Arrange
        when(
          () => checker.checkMarkAsEventEnded(
            item: any(named: 'item'),
            now: any(named: 'now'),
          ),
        ).thenReturn(false);
        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue<List<EarthquakeHistoryItem>>.loading()
                  .copyWithPrevious(
                const AsyncValue.data([baseEewHistoryItem]),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result,
          isNotEmpty,
        );
      },
    );

    test(
      'EewTelegramProvider がエラーで、previousデータを持っている場合、そのデータを利用していること',
      () {
        // Arrange
        when(
          () => checker.checkMarkAsEventEnded(
            item: any(named: 'item'),
            now: any(named: 'now'),
          ),
        ).thenReturn(false);
        final container = ProviderContainer(
          overrides: [
            eewAliveCheckerProvider.overrideWithValue(checker),
            eewTelegramProvider.overrideWithValue(
              const AsyncValue<List<EarthquakeHistoryItem>>.error(
                '',
                StackTrace.empty,
              ).copyWithPrevious(
                const AsyncValue.data([baseEewHistoryItem]),
              ),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = container.read(eewAliveTelegramProvider);

        // Assert
        expect(
          result,
          isNotEmpty,
        );
      },
    );
  });
}

class _MockEewAliveChecker extends Mock implements EewAliveChecker {}
