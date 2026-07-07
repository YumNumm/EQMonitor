import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

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

EarthquakeCatalog _makeCatalog(List<EarthquakeCatalogStationRecord> records) =>
    EarthquakeCatalog(
      hypocenters: [],
      stationRecords: records,
      damageScaleLabel: null,
      tsunamiScaleLabel: null,
      linkMatchConfidence: null,
    );

EarthquakeParameter _makeEarthquakeParameter(
  List<EarthquakeParameterPrefectureItem> prefectures,
) => EarthquakeParameter(
  metadata: const ParameterMetadata(
    type: ParameterType.earthquakeStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  prefectures: prefectures,
);

ShindoDbStationsParameter _makeShindoDbStations(
  List<ShindoDbStationItem> stations,
) => ShindoDbStationsParameter(
  metadata: const ParameterMetadata(
    type: ParameterType.shindoDbStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  stations: stations,
);

EarthquakeHistoryRepository _makeRepository({
  required EarthquakeParameter earthquakeParameter,
  required ShindoDbStationsParameter shindoDbStations,
}) => EarthquakeHistoryRepository(
  earthquake: api.ApiClient(Dio()).earthquake,
  earthquakeParameter: earthquakeParameter,
  shindoDbStations: shindoDbStations,
);

void main() {
  group('buildShindoDbIntensityTree', () {
    test('階級→都道府県→市区町村→観測点に集約されること', () {
      // 観測点2つ (別市区町村・同一階級 six) + 1つ (階級 unknownFelt)
      // → tree[six] に都道府県1件・市区町村2件、tree[unknownFelt] に1件
      final prefecture1 = EarthquakeParameterPrefectureItem(
        code: '01',
        name: const LocalizedName(ja: '北海道'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '010100',
            name: const LocalizedName(ja: '道央'),
            kana: null,
            cities: [
              EarthquakeParameterCityItem(
                code: '01100',
                name: const LocalizedName(ja: '札幌市'),
                kana: null,
                stations: [],
              ),
              EarthquakeParameterCityItem(
                code: '01200',
                name: const LocalizedName(ja: '函館市'),
                kana: null,
                stations: [],
              ),
            ],
          ),
        ],
      );

      final repo = _makeRepository(
        earthquakeParameter: _makeEarthquakeParameter([prefecture1]),
        shindoDbStations: _makeShindoDbStations([
          ShindoDbStationItem(
            code: 'ST001',
            name: '札幌観測点',
            location: const LatLng(43.06, 141.35),
            cityCode: '01100',
          ),
          ShindoDbStationItem(
            code: 'ST002',
            name: '函館観測点',
            location: const LatLng(41.77, 140.73),
            cityCode: '01200',
          ),
          ShindoDbStationItem(
            code: 'ST003',
            name: '不明域観測点',
            location: const LatLng(42.0, 141.0),
            cityCode: '01100',
          ),
        ]),
      );

      final result = repo.buildShindoDbIntensityTree(
        catalog: _makeCatalog([
          _makeRecord('ST001', ShindoDbIntensityClass.six),
          _makeRecord('ST002', ShindoDbIntensityClass.six),
          _makeRecord('ST003', ShindoDbIntensityClass.unknownFelt),
        ]),
      );

      // tree[six]: 1 prefecture, 2 cities
      expect(result.tree.keys, contains(ShindoDbIntensityClass.six));
      final sixNodes = result.tree[ShindoDbIntensityClass.six]!;
      expect(sixNodes, hasLength(1));
      expect(sixNodes.first.prefecture.code, '01');
      expect(sixNodes.first.cities, hasLength(2));
      final cityCodes = sixNodes.first.cities.map((c) => c.city.code).toList();
      expect(cityCodes, containsAll(['01100', '01200']));

      // tree[unknownFelt]: 1 prefecture, 1 city (01100)
      expect(result.tree.keys, contains(ShindoDbIntensityClass.unknownFelt));
      final unknownNodes = result.tree[ShindoDbIntensityClass.unknownFelt]!;
      expect(unknownNodes, hasLength(1));
      expect(
        unknownNodes.first.cities.single.stations.single.record.stationCode,
        'ST003',
      );

      expect(result.totalStationCount, 3);
    });

    test('cityCode が null の観測点は unresolvedStations に入ること', () {
      // 53999 相当 (cityCode: null) → unresolvedStations[class] に入り name が解決される
      final repo = _makeRepository(
        earthquakeParameter: _makeEarthquakeParameter([]),
        shindoDbStations: _makeShindoDbStations([
          ShindoDbStationItem(
            code: '5399900',
            name: '神戸市等阪神淡路地域',
            location: const LatLng(34.7, 135.2),
            cityCode: null,
          ),
        ]),
      );

      final result = repo.buildShindoDbIntensityTree(
        catalog: _makeCatalog([
          _makeRecord('5399900', ShindoDbIntensityClass.four),
        ]),
      );

      expect(result.tree, isEmpty);
      expect(
        result.unresolvedStations.keys,
        contains(ShindoDbIntensityClass.four),
      );
      final nodes = result.unresolvedStations[ShindoDbIntensityClass.four]!;
      expect(nodes, hasLength(1));
      expect(nodes.first.name, '神戸市等阪神淡路地域');
      expect(nodes.first.record.stationCode, '5399900');
    });

    test('shindoDbStations に無い観測点コードは name がコードのまま unresolved になること', () {
      final repo = _makeRepository(
        earthquakeParameter: _makeEarthquakeParameter([]),
        shindoDbStations: _makeShindoDbStations([]),
      );

      final result = repo.buildShindoDbIntensityTree(
        catalog: _makeCatalog([
          _makeRecord('UNKNOWN_CODE', ShindoDbIntensityClass.three),
        ]),
      );

      expect(result.tree, isEmpty);
      expect(
        result.unresolvedStations.keys,
        contains(ShindoDbIntensityClass.three),
      );
      final nodes = result.unresolvedStations[ShindoDbIntensityClass.three]!;
      expect(nodes, hasLength(1));
      expect(nodes.first.name, 'UNKNOWN_CODE');
      expect(nodes.first.location, isNull);
    });

    test(
      'cityCode が非 null でも earthquakeParameter に存在しない場合は unresolvedStations に入ること',
      () {
        // cityCode は非 null ('01100') だが earthquakeParameter に該当市区町村なし
        // → cityEntry == null 分岐 → unresolvedStations に落ちる
        final repo = _makeRepository(
          earthquakeParameter: _makeEarthquakeParameter([]),
          shindoDbStations: _makeShindoDbStations([
            ShindoDbStationItem(
              code: 'ST_ORPHAN',
              name: '孤立観測点',
              location: const LatLng(43.0, 141.0),
              cityCode:
                  '01100', // non-null, but absent from earthquakeParameter
            ),
          ]),
        );

        final result = repo.buildShindoDbIntensityTree(
          catalog: _makeCatalog([
            _makeRecord('ST_ORPHAN', ShindoDbIntensityClass.five),
          ]),
        );

        expect(result.tree, isEmpty);
        expect(
          result.unresolvedStations.keys,
          contains(ShindoDbIntensityClass.five),
        );
        final nodes = result.unresolvedStations[ShindoDbIntensityClass.five]!;
        expect(nodes, hasLength(1));
        expect(nodes.first.name, '孤立観測点');
        expect(nodes.first.record.stationCode, 'ST_ORPHAN');
      },
    );

    test('tree のキーが orderIndex 降順で並ぶこと', () {
      final prefecture = EarthquakeParameterPrefectureItem(
        code: '01',
        name: const LocalizedName(ja: '北海道'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '010100',
            name: const LocalizedName(ja: '道央'),
            kana: null,
            cities: [
              EarthquakeParameterCityItem(
                code: '01100',
                name: const LocalizedName(ja: '札幌市'),
                kana: null,
                stations: [],
              ),
            ],
          ),
        ],
      );

      final repo = _makeRepository(
        earthquakeParameter: _makeEarthquakeParameter([prefecture]),
        shindoDbStations: _makeShindoDbStations([
          ShindoDbStationItem(
            code: 'ST_7',
            name: 'Station Seven',
            location: const LatLng(43.0, 141.0),
            cityCode: '01100',
          ),
          ShindoDbStationItem(
            code: 'ST_4',
            name: 'Station Four',
            location: const LatLng(43.1, 141.1),
            cityCode: '01100',
          ),
          ShindoDbStationItem(
            code: 'ST_2',
            name: 'Station Two',
            location: const LatLng(43.2, 141.2),
            cityCode: '01100',
          ),
        ]),
      );

      // Insert records in non-descending order to verify sort is applied
      final result = repo.buildShindoDbIntensityTree(
        catalog: _makeCatalog([
          _makeRecord('ST_2', ShindoDbIntensityClass.two),
          _makeRecord('ST_4', ShindoDbIntensityClass.four),
          _makeRecord('ST_7', ShindoDbIntensityClass.seven),
        ]),
      );

      final keys = result.tree.keys.toList();
      expect(keys, hasLength(3));
      // seven(17) > four(10) > two(8)
      expect(keys[0], ShindoDbIntensityClass.seven);
      expect(keys[1], ShindoDbIntensityClass.four);
      expect(keys[2], ShindoDbIntensityClass.two);
    });
  });
}
