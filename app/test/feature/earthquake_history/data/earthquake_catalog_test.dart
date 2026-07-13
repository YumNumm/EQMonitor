import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeCatalogApiExtension', () {
    test('震源レコード・観測点レコード・規模が変換されること', () {
      final catalog = api.Catalog(
        hypocenters: [
          api.CatalogHypocenter(
            seq: 0,
            recordType: api.CatalogHypocenterRecordType.a,
            magnitudes: const [
              api.CatalogHypocenterMagnitude(
                type: api.CatalogMagnitudeType.upperD,
                value: 6.5,
              ),
            ],
            epicenterName: '兵庫県南部',
            stationCount: 100,
            originTime: DateTime(1995, 1, 17, 5, 46),
            originTimeStderrSeconds: 0.2,
            depth: const api.CatalogHypocenterDepth(value: 16, isFree: false),
            maxIntensity: api.CatalogIntensityClass.value7,
            determinationFlag: api.CatalogDeterminationFlag.upperK,
            evaluation: api.CatalogHypocenterEvaluation.value3,
          ),
        ],
        stationRecords: [
          api.CatalogStationRecord(
            stationCode: '6310000',
            intensity: const api.CatalogStationIntensity(
              classValue: api.CatalogIntensityClass.value6,
              instrumental: 6.4,
            ),
            observedAt: DateTime(1995, 1, 17, 5, 46, 30),
            maxAcceleration: const api.CatalogStationMaxAcceleration(
              synthesizedGal: 891,
              nsGal: 818,
            ),
            periods: const api.CatalogStationPeriods(
              ns: api.CatalogStationPeriodComponent(
                maxAccelPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.period,
                  value: 0.4,
                ),
                predominantPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.frequency,
                ),
              ),
            ),
          ),
        ],
        damageScale: api.CatalogDamageScale.value7,
        tsunamiScale: api.CatalogTsunamiScale.value1,
        link: const api.CatalogLink(
          matchConfidence: 0.98,
          matchMethod: api.CatalogLinkMatchMethod.auto,
          timeDiffSeconds: 1.2,
          distanceKm: 3.4,
        ),
      );

      final result = catalog.toEarthquakeCatalog;

      final hypocenter = result.hypocenters.single;
      expect(hypocenter.epicenterName, '兵庫県南部');
      expect(hypocenter.recordTypeLabel, '震源');
      expect(hypocenter.originTimeStderrSeconds, 0.2);
      expect(hypocenter.depthKm, 16);
      expect(hypocenter.depthIsFree, isFalse);
      expect(hypocenter.maxIntensity, ShindoDbIntensityClass.seven);
      expect(hypocenter.determinationFlagLabel, '気象庁震源');
      expect(hypocenter.magnitudes.single.typeLabel, '変位M');
      expect(hypocenter.magnitudes.single.value, 6.5);

      final station = result.stationRecords.single;
      expect(station.stationCode, '6310000');
      expect(station.intensityClass, ShindoDbIntensityClass.six);
      expect(station.instrumentalIntensity, 6.4);
      expect(station.maxAcceleration?.synthesizedGal, 891);
      expect(station.periods?.ns?.maxAccelPeriodText, '0.4秒');
      expect(station.periods?.ns?.predominantPeriodText, '欠測');
      expect(station.periods?.ew, isNull);

      expect(result.damageScaleLabel, startsWith('7:'));
      expect(result.tsunamiScaleLabel, startsWith('1:'));
      expect(result.linkMatchConfidence, 0.98);
    });

    test('過大なカタログ配列と文字列は表示用モデル化時に制限されること', () {
      final longText = List.filled(
        earthquakeCatalogMaxTextLength + 1,
        'A',
      ).join();
      final catalog = api.Catalog(
        hypocenters: List.generate(
          earthquakeCatalogMaxHypocenterCount + 1,
          (index) => api.CatalogHypocenter(
            seq: index,
            recordType: api.CatalogHypocenterRecordType.a,
            magnitudes: List.generate(
              earthquakeCatalogMaxMagnitudeCount + 1,
              (magnitudeIndex) => api.CatalogHypocenterMagnitude(
                type: api.CatalogMagnitudeType.upperD,
                value: magnitudeIndex,
              ),
            ),
            epicenterName: longText,
            stationCount: 1,
          ),
        ),
        stationRecords: List.generate(
          earthquakeCatalogMaxStationRecordCount + 1,
          (index) => api.CatalogStationRecord(
            stationCode: longText,
            intensity: const api.CatalogStationIntensity(
              classValue: api.CatalogIntensityClass.value1,
            ),
          ),
        ),
      );

      final result = catalog.toEarthquakeCatalog;

      expect(
        result.hypocenters,
        hasLength(earthquakeCatalogMaxHypocenterCount),
      );
      expect(
        result.stationRecords,
        hasLength(earthquakeCatalogMaxStationRecordCount),
      );
      expect(
        result.hypocenters.first.magnitudes,
        hasLength(earthquakeCatalogMaxMagnitudeCount),
      );
      expect(
        result.hypocenters.first.epicenterName.length,
        earthquakeCatalogMaxTextLength,
      );
      expect(
        result.stationRecords.first.stationCode.length,
        earthquakeCatalogMaxTextLength,
      );
    });
  });
}
