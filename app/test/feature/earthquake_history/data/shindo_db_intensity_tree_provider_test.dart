import 'package:dio/dio.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

const _testEventId = 'test-event-001';

class _StubDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _StubDetailsNotifier(this._earthquake);
  final Earthquake _earthquake;

  @override
  Future<Earthquake> build(String eventId) async => _earthquake;
}

Earthquake _makeEarthquake({EarthquakeCatalog? catalog}) => Earthquake(
  eventId: _testEventId,
  status: TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: null,
  dataSources: const [],
  telegramTypes: const [],
  hypocenter: null,
  intensity: null,
  estimatedIntensityTileUrl: null,
  catalog: catalog,
);

EarthquakeCatalog _makeCatalog(List<EarthquakeCatalogStationRecord> records) =>
    EarthquakeCatalog(
      hypocenters: [],
      stationRecords: records,
      damageScaleLabel: null,
      tsunamiScaleLabel: null,
      linkMatchConfidence: null,
    );

EarthquakeCatalogStationRecord _makeRecord(
  String stationCode,
  ShindoDbIntensityClass intensityClass,
) => EarthquakeCatalogStationRecord(
  stationCode: stationCode,
  intensityClass: intensityClass,
  instrumentalIntensity: null,
  observedAt: null,
  maxAcceleration: null,
  maxAccelTime: null,
  periods: null,
  observationCount: null,
);

EarthquakeHistoryRepository _makeRepository() => EarthquakeHistoryRepository(
  earthquake: api.ApiClient(Dio()).earthquake,
  earthquakeParameter: const EarthquakeParameter(
    metadata: ParameterMetadata(
      type: ParameterType.earthquakeStations,
      schemaVersion: 1,
      sourceVersion: 'test',
      sourceUpdatedAt: null,
      sourceUrls: [],
      sha256: 'test',
    ),
    prefectures: [
      EarthquakeParameterPrefectureItem(
        code: '01',
        name: LocalizedName(ja: '北海道'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '010100',
            name: LocalizedName(ja: '道央'),
            kana: null,
            cities: [
              EarthquakeParameterCityItem(
                code: '01100',
                name: LocalizedName(ja: '札幌市'),
                kana: null,
                stations: [],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  shindoDbStations: ShindoDbStationsParameter(
    metadata: const ParameterMetadata(
      type: ParameterType.shindoDbStations,
      schemaVersion: 1,
      sourceVersion: 'test',
      sourceUpdatedAt: null,
      sourceUrls: [],
      sha256: 'test',
    ),
    stations: [
      ShindoDbStationItem(
        code: 'ST001',
        name: '札幌観測点',
        location: const LatLng(43.06, 141.35),
        cityCode: '01100',
      ),
    ],
  ),
);

void main() {
  group('shindoDbIntensityTreeProvider', () {
    test('catalog あり → ShindoDbIntensityTree が返ること', () async {
      final catalog = _makeCatalog([
        _makeRecord('ST001', ShindoDbIntensityClass.four),
      ]);
      final earthquake = _makeEarthquake(catalog: catalog);
      final repository = _makeRepository();

      final container = ProviderContainer(
        overrides: [
          earthquakeHistoryDetailsProvider(
            _testEventId,
          ).overrideWith(() => _StubDetailsNotifier(earthquake)),
          earthquakeHistoryRepositoryProvider.overrideWith(
            (ref) async => repository,
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(
        shindoDbIntensityTreeProvider(_testEventId).future,
      );

      expect(result, isNotNull);
      expect(result!.tree.keys, contains(ShindoDbIntensityClass.four));
      expect(result.totalStationCount, 1);
    });

    test('catalog なし → null が返ること', () async {
      final earthquake = _makeEarthquake();

      final container = ProviderContainer(
        overrides: [
          earthquakeHistoryDetailsProvider(
            _testEventId,
          ).overrideWith(() => _StubDetailsNotifier(earthquake)),
        ],
      );
      addTearDown(container.dispose);

      final result = await container.read(
        shindoDbIntensityTreeProvider(_testEventId).future,
      );

      expect(result, isNull);
    });
  });
}
