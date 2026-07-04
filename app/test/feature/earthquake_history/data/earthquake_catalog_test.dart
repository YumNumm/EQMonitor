import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeCatalogApiExtension', () {
    test('震度データベース catalog の詳細情報を表示行へ変換する', () {
      final catalog = api.Catalog(
        hypocenters: [
          api.CatalogHypocenter(
            seq: 0,
            recordType: api.CatalogHypocenterRecordType.a,
            magnitudes: [
              const api.CatalogHypocenterMagnitude(
                type: api.CatalogMagnitudeType.upperD,
                value: 6.7,
              ),
            ],
            epicenterName: '日向灘',
            stationCount: 12,
            originTime: DateTime.utc(2026, 7, 5, 1, 2, 3),
            originTimeStderrSeconds: 1.5,
            coordinates: const api.Coordinate(latitude: 32.1, longitude: 132.2),
            depth: const api.CatalogHypocenterDepth(
              value: 24,
              isFree: true,
              stderr: 0.8,
            ),
            maxIntensity: api.CatalogIntensityClass.b,
            largeAreaCode: 9,
            smallAreaCode: 901,
            determinationFlag: api.CatalogDeterminationFlag.upperK,
            evaluation: api.CatalogHypocenterEvaluation.value2,
            auxiliaryInfo: api.CatalogHypocenterAuxiliaryInfo.value1,
            travelTimeTable: api.CatalogTravelTimeTable.value5,
          ),
        ],
        stationRecords: [
          api.CatalogStationRecord(
            stationCode: '93041',
            intensity: const api.CatalogStationIntensity(
              classValue: api.CatalogIntensityClass.b,
              instrumental: 5.6,
            ),
            observedAt: DateTime.utc(2026, 7, 5, 1, 2, 10),
            maxAcceleration: const api.CatalogStationMaxAcceleration(
              synthesizedGal: 123.4,
              nsGal: 100.1,
              ewGal: 90.2,
              udGal: 30.3,
            ),
            maxAccelTime: DateTime.utc(2026, 7, 5, 1, 2, 11),
            periods: const api.CatalogStationPeriods(
              ns: api.CatalogStationPeriodComponent(
                maxAccelPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.period,
                  value: 0.3,
                ),
                predominantPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.frequency,
                  value: 4.5,
                ),
              ),
            ),
            observationCount: 3,
          ),
        ],
        damageScale: api.CatalogDamageScale.value2,
        tsunamiScale: api.CatalogTsunamiScale.value3,
        link: const api.CatalogLink(
          matchConfidence: 0.95,
          matchMethod: api.CatalogLinkMatchMethod.auto,
          timeDiffSeconds: 2.5,
          distanceKm: 12.3,
        ),
      );

      final display = catalog.toEarthquakeCatalog;
      final rows = display.sections.expand((section) => section.rows).toList();

      expect(display.sections.map((section) => section.title), [
        '震度データベース概要',
        '震源 1',
        '観測点 93041',
        '観測点 93041 最大加速度',
        '観測点 93041 周期 NS',
        '震度データベース照合',
      ]);
      expect(
        rows.map((row) => '${row.label}: ${row.value}'),
        containsAll([
          '被害規模: 2',
          '津波規模: 3',
          '震源地名: 日向灘',
          '観測点数: 12',
          '発震時刻: 2026/07/05 01:02:03',
          '発震時刻 標準誤差: 1.5秒',
          '緯度: 32.1',
          '経度: 132.2',
          '深さ: 24km',
          '深さフリー条件: はい',
          '深さ 標準誤差: 0.8km',
          '最大震度階級: B',
          '大区域コード: 9',
          '小区域コード: 901',
          '震源決定フラグ: K',
          '震源評価: 2',
          '震源補助情報: 1',
          '走時表: 5',
          'マグニチュード1: D 6.7',
          '震度階級: B',
          '計測震度: 5.6',
          '観測時刻: 2026/07/05 01:02:10',
          '最大加速度時刻: 2026/07/05 01:02:11',
          '観測回数: 3',
          '合成: 123.4gal',
          '南北: 100.1gal',
          '東西: 90.2gal',
          '上下: 30.3gal',
          '最大加速度周期: PERIOD 0.3',
          '卓越周期: FREQUENCY 4.5',
          '照合信頼度: 0.95',
          '照合方法: auto',
          '時刻差: 2.5秒',
          '距離: 12.3km',
        ]),
      );
    });

    test('地震詳細レスポンス変換で catalog を保持する', () {
      const parameter = EarthquakeParameter(
        metadata: ParameterMetadata(
          type: ParameterType.earthquakeStations,
          schemaVersion: 1,
          sourceVersion: 'test',
          sourceUpdatedAt: null,
          sourceUrls: [],
          sha256: 'test',
        ),
        prefectures: [],
      );
      final apiEarthquake = api.Earthquake(
        eventId: '20260705010203',
        status: api.TelegramStatus.normal,
        originTimePrecision: api.OriginTimePrecision.second,
        datasources: const [api.EarthquakeDatasource.jmaIntensityDatabase],
        telegrams: const [],
        catalog: const api.Catalog(
          hypocenters: [
            api.CatalogHypocenter(
              seq: 0,
              recordType: api.CatalogHypocenterRecordType.a,
              magnitudes: [],
              epicenterName: '日向灘',
              stationCount: 0,
            ),
          ],
          stationRecords: [],
        ),
      );

      final earthquake = apiEarthquake.toEarthquake(parameter: parameter);

      expect(earthquake.catalog, isNotNull);
      expect(earthquake.catalog!.sections[1].rows, [
        const EarthquakeCatalogRow(label: 'レコード種別', value: 'A'),
        const EarthquakeCatalogRow(label: '震源地名', value: '日向灘'),
        const EarthquakeCatalogRow(label: '観測点数', value: '0'),
      ]);
    });
  });
}
