import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_area_filter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

EarthquakeCatalogStationRecord _makeRecord(
  String code,
  ShindoDbIntensityClass cls,
) => EarthquakeCatalogStationRecord(
  stationCode: code,
  intensityClass: cls,
  instrumentalIntensity: null,
  observedAt: null,
  maxAcceleration: null,
  maxAccelTime: null,
  periods: null,
  observationCount: null,
);

void main() {
  Earthquake itemWithIntensity(EarthquakeIntensity intensity) {
    return Earthquake(
      eventId: '20260101120000',
      status: TelegramStatus.normal,
      originTime: null,
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [],
      hypocenter: null,
      intensity: intensity,
      estimatedIntensityTileUrl: null,
    );
  }

  const miyagiRegion = EarthquakeParameterRegionItem(
    code: '040000',
    name: LocalizedName(ja: '宮城県'),
    kana: null,
    cities: [],
  );
  const miyagiPrefecture = EarthquakeParameterPrefectureItem(
    code: '04',
    name: LocalizedName(ja: '宮城県'),
    regions: [miyagiRegion],
  );

  final hokkaido = EarthquakeParameterPrefectureItem(
    code: '01',
    name: const LocalizedName(ja: '北海道'),
    regions: [],
  );

  final sapporoCity = EarthquakeParameterCityItem(
    code: '01100',
    name: const LocalizedName(ja: '札幌市'),
    kana: null,
    stations: [],
  );

  final sapporoRegion = EarthquakeParameterRegionItem(
    code: '010100',
    name: const LocalizedName(ja: '道央'),
    kana: null,
    cities: [sapporoCity],
  );

  final stationNode = ShindoDbStationNode(
    record: _makeRecord('ST001', ShindoDbIntensityClass.sixLower),
    name: '札幌観測点',
    location: const LatLng(43.06, 141.35),
  );

  final cityNode = ShindoDbCityNode(
    city: sapporoCity,
    region: sapporoRegion,
    stations: [stationNode],
  );

  final prefNode = ShindoDbPrefectureNode(
    prefecture: hokkaido,
    cities: [cityNode],
  );

  test('速報値を市区町村・細分区域・都道府県で絞る', () {
    const city = EarthquakeParameterCityItem(
      code: '0420100',
      name: LocalizedName(ja: '対象市'),
      kana: null,
      stations: [],
    );
    final region = miyagiRegion.copyWith(cities: [city]);
    final pref = PrefectureIntensityNode(
      prefecture: IntensityPrefecture(
        prefecture: miyagiPrefecture.copyWith(regions: [region]),
        maxIntensity: JmaIntensity.four,
      ),
      cities: [
        const CityIntensityNode(
          city: city,
          maxIntensity: JmaIntensity.four,
          stations: [],
        ),
        CityIntensityNode(
          city: city.copyWith(code: 'other'),
          maxIntensity: JmaIntensity.four,
          stations: [],
        ),
      ],
    );
    final item = itemWithIntensity(
      EarthquakeIntensity(
        maxIntensity: JmaIntensity.four,
        maxLpgmIntensity: null,
        regions: {},
        lpgmIntensityTree: {},
        intensityTree: {
          JmaIntensity.four: [pref],
          JmaIntensity.three: [pref],
        },
      ),
    );
    for (final selection in [
      (code: city.code, isCity: true, count: 1),
      (code: region.code, isCity: false, count: 1),
      (code: '04', isCity: false, count: 2),
      (code: 'missing', isCity: true, count: 0),
    ]) {
      final result = const EarthquakeIntensityAreaFilter().filterEarthquake(
        earthquake: item,
        code: selection.code,
        isCity: selection.isCity,
      );
      final tree = result.intensity?.intensityTree;
      expect(tree?.length, selection.count == 0 ? 0 : 2);
      for (final prefs in tree?.values ?? <List<PrefectureIntensityNode>>[]) {
        expect(prefs.single.cities.length, selection.count);
      }
    }
    expect(
      item.intensity?.intensityTree[JmaIntensity.four]?.single.cities.length,
      2,
    );
  });

  test('地域の絞り込みは全震度を保持し、区域外と所属不明の観測点を除く', () {
    final otherCity = cityNode.copyWith(
      city: sapporoCity.copyWith(code: '01200'),
      region: sapporoRegion.copyWith(code: '010200'),
    );
    final tree = ShindoDbIntensityTree(
      tree: {
        ShindoDbIntensityClass.sixLower: [
          prefNode.copyWith(cities: [cityNode, otherCity]),
        ],
        ShindoDbIntensityClass.fiveUpper: [prefNode],
      },
      unresolvedStations: {
        ShindoDbIntensityClass.seven: [stationNode],
      },
      totalStationCount: 4,
    );
    const filter = EarthquakeIntensityAreaFilter();
    for (final selection in [
      (code: '01100', isCity: true, count: 2),
      (code: '010100', isCity: false, count: 2),
      (code: '01', isCity: false, count: 3),
      (code: 'missing', isCity: true, count: 0),
    ]) {
      final result = filter.filterDatabase(
        tree: tree,
        code: selection.code,
        isCity: selection.isCity,
      );
      expect(result.totalStationCount, selection.count);
      expect(result.unresolvedStations, isEmpty);
      expect(result.tree.length, selection.count == 0 ? 0 : 2);
    }
    expect(tree.totalStationCount, 4);
  });
}
