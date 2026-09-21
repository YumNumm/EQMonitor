import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_catalog_builder.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_search.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:flutter_test/flutter_test.dart';

const codeTable = JmaCodeTableParameter(
  metadata: ParameterMetadata(
    type: ParameterType.jmaCodeTable,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  codeTables: JmaCodeTableCodeTables(
    areaForecastLocalEew: [
      JmaCodeTableItem(
        code: '9011',
        name: LocalizedName(ja: '地域A'),
        kana: null,
        description: null,
      ),
      JmaCodeTableItem(
        code: '9012',
        name: LocalizedName(ja: '地域B'),
        kana: null,
        description: null,
      ),
    ],
    areaInformationPrefectureEarthquake: [
      JmaCodeTableItem(
        code: '13',
        name: LocalizedName(ja: '東京都'),
        kana: 'とうきょうと',
        description: null,
      ),
    ],
    areaInformationCity: [
      JmaCodeTableCityItem(
        code: '1320600',
        name: LocalizedName(ja: '府中市'),
        parentAreaForecastLocalEewCode: '9011',
        parentAreaInformationPrefectureEarthquakeCode: '13',
      ),
    ],
    areaEpicenter: [
      JmaCodeTableItem(
        code: '100',
        name: LocalizedName(ja: '石狩地方北部'),
        kana: null,
        description: null,
      ),
      JmaCodeTableItem(
        code: '999',
        name: LocalizedName(ja: '遠地'),
        kana: null,
        description: null,
      ),
    ],
    areaEpicenterAbbreviation: [],
    areaEpicenterDetail: [],
  ),
);

void main() {
  const builder = RegionCatalogBuilder();
  final catalog = builder.build(
    earthquake: EarthquakeSearchFixture.parameter,
    codeTable: codeTable,
    notification: false,
  );
  test('都道府県・細分区域・市区町村と親情報を保持する', () {
    final cities = catalog.where((item) => item.kind == .city).toList();
    expect(cities.map((item) => item.name), ['府中市', '府中市']);
    expect(cities.map((item) => item.parentName), [
      '東京都・東京都多摩東部',
      '広島県・広島県南東部',
    ]);
    expect(cities.map((item) => item.prefectureCode), ['13', '34']);
    expect(
      const RegionSearch()
          .filter(items: catalog, query: 'とうきょうとたまとうぶ')
          .first
          .code,
      '350',
    );
  });
  test('地図に範囲のない震央地名も一覧に残す', () {
    expect(
      catalog.where((item) => item.kind == .epicenter).map((item) => item.code),
      ['100', '999'],
    );
  });
  test('都道府県をひらがなと半角カタカナで検索できる', () {
    for (final query in ['とうきょう', 'ﾄｳｷｮｳ']) {
      expect(
        const RegionSearch()
            .filter(items: catalog, query: query, kind: .prefecture)
            .map((item) => item.name),
        ['東京都'],
      );
    }
  });
  test('通知はEEW親を使い、結合不能な市を候補にしない', () {
    final items = builder.build(
      earthquake: EarthquakeSearchFixture.parameter,
      codeTable: codeTable,
      notification: true,
    );
    expect(
      items.where((item) => item.kind == .eewRegion).map((item) => item.code),
      ['9011', '9012'],
    );
    final city = items.where((item) => item.kind == .city).single;
    expect(city.code, '1320600');
    expect(city.parentKind, RegionKind.eewRegion);
    expect(city.parentCode, '9011');
    expect(city.parentName, '地域A');
  });
}

class EarthquakeSearchFixture {
  static const parameter = EarthquakeParameter(
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
        code: '13',
        name: LocalizedName(ja: '東京都', en: 'Tokyo'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '350',
            name: LocalizedName(ja: '東京都多摩東部'),
            kana: 'とうきょうとたまとうぶ',
            cities: [
              EarthquakeParameterCityItem(
                code: '1320600',
                name: LocalizedName(ja: '府中市'),
                kana: 'ふちゅうし',
                stations: [],
              ),
            ],
          ),
        ],
      ),
      EarthquakeParameterPrefectureItem(
        code: '34',
        name: LocalizedName(ja: '広島県'),
        regions: [
          EarthquakeParameterRegionItem(
            code: '671',
            name: LocalizedName(ja: '広島県南東部'),
            kana: null,
            cities: [
              EarthquakeParameterCityItem(
                code: '3420800',
                name: LocalizedName(ja: '府中市'),
                kana: 'ふちゅうし',
                stations: [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
