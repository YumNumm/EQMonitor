import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'EarthquakeHistoryParameterMatch Extension',
    () {
      group(
        'isRealtimeDataMatch',
        () {
          test(
            'RealtimePostgresInsertPayload<EarthquakeV1> は、isEarthquakeV1Matchの結果を返すこと',
            () {
              // Arrange
              const parameter = EarthquakeHistoryParameter(
                intensityGte: JmaIntensity.fiveLower,
              );
              final data = EarthquakeV1(
                eventId: 20220101000000,
                status: '通常',
                arrivalTime: DateTime(2022),
                depth: 10,
                magnitude: 5.5,
                maxIntensity: JmaIntensity.fiveLower,
              );
              final payload = RealtimePostgresInsertPayload<EarthquakeV1>(
                newData: data,
                schema: 'public',
                table: 'earthquake',
                commitTimestamp: DateTime(2002),
                errors: null,
              );

              // Act
              final result = parameter.isRealtimeDataMatch(payload);

              // Assert
              expect(result, parameter.isEarthquakeV1Match(data));
            },
          );
          test(
            'RealtimePostgresUpdatePayload<EarthquakeV1> は、isEarthquakeV1Matchの結果を返すこと',
            () {
              // Arrange
              const parameter = EarthquakeHistoryParameter(
                intensityGte: JmaIntensity.fiveLower,
              );
              final data = EarthquakeV1(
                eventId: 20220101000000,
                status: '通常',
                arrivalTime: DateTime(2022),
                depth: 10,
                magnitude: 5.5,
                maxIntensity: JmaIntensity.fiveLower,
              );
              final payload = RealtimePostgresUpdatePayload<EarthquakeV1>(
                old: {
                  'eventId': 20220101000000,
                },
                newData: data,
                schema: 'public',
                table: 'earthquake',
                commitTimestamp: DateTime(2002),
                errors: null,
              );

              // Act
              final result = parameter.isRealtimeDataMatch(payload);

              // Assert
              expect(result, parameter.isEarthquakeV1Match(data));
            },
          );
          test(
            'RealtimePostgresDeletePayload<EarthquakeV1> は、falseを返すこと',
            () {
              // Arrange
              const parameter = EarthquakeHistoryParameter(
                intensityGte: JmaIntensity.fiveLower,
              );
              final payload = RealtimePostgresDeletePayload<EarthquakeV1>(
                old: {
                  'eventId': 20220101000000,
                },
                schema: 'public',
                table: 'earthquake',
                commitTimestamp: DateTime(2002),
                errors: null,
              );

              // Act
              final result = parameter.isRealtimeDataMatch(payload);

              // Assert
              expect(result, false);
            },
          );
        },
      );
      group(
        'isEarthquakeV1Match',
        () {
          final base = EarthquakeV1(
            eventId: 20220101000000,
            status: '通常',
            arrivalTime: DateTime(2022),
            depth: 10,
            magnitude: 5.5,
            maxIntensity: JmaIntensity.fiveLower,
          );
          group(
            'maxIntensity',
            () {
              test(
                '最大震度がnullの場合はfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    intensityGte: JmaIntensity.fiveLower,
                  );
                  final data = base.copyWith(
                    maxIntensity: null,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'maxIntensity < intensityGteはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    intensityGte: JmaIntensity.sixLower,
                  );
                  final data = base.copyWith(
                    maxIntensity: JmaIntensity.fiveLower,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'intesityLte < maxIntensityはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    intensityLte: JmaIntensity.fiveLower,
                  );
                  final data = base.copyWith(
                    maxIntensity: JmaIntensity.sixLower,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'intensityGte <= maxIntensity <= intensityLteの場合はtrueを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    intensityGte: JmaIntensity.fiveLower,
                    intensityLte: JmaIntensity.fiveLower,
                  );
                  final data = base.copyWith(
                    maxIntensity: JmaIntensity.fiveLower,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, true);
                },
              );
              test('intensityGteがnullでintensityLte < maxIntensityの場合はtrueを返す',
                  () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  intensityLte: JmaIntensity.fiveLower,
                );
                final data = base.copyWith(
                  maxIntensity: JmaIntensity.fiveLower,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
              test('intensityLteがnullでintensityGte < maxIntensityの場合はtrueを返す',
                  () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  intensityGte: JmaIntensity.fiveLower,
                );
                final data = base.copyWith(
                  maxIntensity: JmaIntensity.fiveLower,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
            },
          );
          group(
            'magnitude',
            () {
              test(
                'magnitudeがnullの場合はfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    magnitudeGte: 5.5,
                  );
                  final data = base.copyWith(
                    magnitude: null,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'magnitude < magnitudeGteはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    magnitudeGte: 6,
                  );
                  final data = base.copyWith(
                    magnitude: 5.5,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'magnitudeLte < magnitudeはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    magnitudeLte: 5,
                  );
                  final data = base.copyWith(
                    magnitude: 5.5,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'magnitudeGte <= magnitude <= magnitudeLteの場合はtrueを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    magnitudeGte: 5.5,
                    magnitudeLte: 5.5,
                  );
                  final data = base.copyWith(
                    magnitude: 5.5,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, true);
                },
              );
              test('magnitudeGteがnullでmagnitudeLte < magnitudeの場合はtrueを返す', () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  magnitudeLte: 5.5,
                );
                final data = base.copyWith(
                  magnitude: 5.5,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
              test('magnitudeLteがnullでmagnitudeGte < magnitudeの場合はtrueを返す', () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  magnitudeGte: 5.5,
                );
                final data = base.copyWith(
                  magnitude: 5.5,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
            },
          );
          group(
            'depth',
            () {
              test(
                'depthがnullの場合はfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    depthGte: 10,
                  );
                  final data = base.copyWith(
                    depth: null,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'depth < depthGteはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    depthGte: 11,
                  );
                  final data = base.copyWith(
                    depth: 10,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'depthLte < depthはfalseを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    depthLte: 9,
                  );
                  final data = base.copyWith(
                    depth: 10,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, false);
                },
              );
              test(
                'depthGte <= depth <= depthLteの場合はtrueを返す',
                () {
                  // Arrange
                  const parameter = EarthquakeHistoryParameter(
                    depthGte: 10,
                    depthLte: 10,
                  );
                  final data = base.copyWith(
                    depth: 10,
                  );

                  // Act
                  final result = parameter.isEarthquakeV1Match(data);

                  // Assert
                  expect(result, true);
                },
              );
              test('depthGteがnullでdepthLte < depthの場合はtrueを返す', () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  depthLte: 10,
                );
                final data = base.copyWith(
                  depth: 10,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
              test('depthLteがnullでdepthGte < depthの場合はtrueを返す', () {
                // Arrange
                const parameter = EarthquakeHistoryParameter(
                  depthGte: 10,
                );
                final data = base.copyWith(
                  depth: 10,
                );

                // Act
                final result = parameter.isEarthquakeV1Match(data);

                // Assert
                expect(result, true);
              });
            },
          );
        },
      );
    },
  );
}
