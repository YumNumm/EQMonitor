import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geobase/geobase.dart';
import 'package:jma_map/jma_map.dart';

EarthquakeParameter _buildParameter() {
  const fukushimaNakadori = EarthquakeParameterRegionItem(
    code: '250',
    name: LocalizedName(ja: '福島県中通り'),
    kana: null,
    cities: [
      EarthquakeParameterCityItem(
        code: '0720100',
        name: LocalizedName(ja: '福島市'),
        kana: null,
        stations: [],
      ),
      EarthquakeParameterCityItem(
        code: '0720500',
        name: LocalizedName(ja: '伊達市'),
        kana: null,
        stations: [],
      ),
    ],
  );
  const fukushimaHamadori = EarthquakeParameterRegionItem(
    code: '251',
    name: LocalizedName(ja: '福島県浜通り'),
    kana: null,
    cities: [
      EarthquakeParameterCityItem(
        code: '0720300',
        name: LocalizedName(ja: 'いわき市'),
        kana: null,
        stations: [],
      ),
    ],
  );
  const fukushima = EarthquakeParameterPrefectureItem(
    code: '07',
    name: LocalizedName(ja: '福島県'),
    regions: [fukushimaNakadori, fukushimaHamadori],
  );

  // 不正な region.code (パース失敗) はスキップされることを検証するためのデータ
  const invalid = EarthquakeParameterPrefectureItem(
    code: '99',
    name: LocalizedName(ja: 'INVALID'),
    regions: [
      EarthquakeParameterRegionItem(
        code: 'NaN',
        name: LocalizedName(ja: 'INVALID-REGION'),
        kana: null,
        cities: [
          EarthquakeParameterCityItem(
            code: '9999999',
            name: LocalizedName(ja: '架空市'),
            kana: null,
            stations: [],
          ),
        ],
      ),
    ],
  );

  return const EarthquakeParameter(
    metadata: ParameterMetadata(
      type: ParameterType.earthquakeStations,
      schemaVersion: 1,
      sourceVersion: '1.0',
      sourceUpdatedAt: null,
      sourceUrls: [],
      sha256: '',
    ),
    prefectures: [fukushima, invalid],
  );
}

JmaMap_JmaMapData _tsunamiMapData() => JmaMap_JmaMapData(
  mapType: JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI,
  data: [
    JmaMap_JmaMapData_JmaMapDataItem(
      property: JmaMap_JmaMapData_JmaMapDataItem_Property(
        code: '201',
        name: '茨城県',
      ),
      bytes: LineString.from([
        Geographic(lon: 140.5, lat: 35.5),
        Geographic(lon: 140.5, lat: 36.5),
      ]).toBytes(),
      dataType: JmaMap_JmaMapData_DataType.LINE_STRING,
    ),
  ],
);

void main() {
  group('JmaRegionResolver.resolveTsunamiForecastRegionCode', () {
    test('現在地に最も近いAreaTsunamiの3桁コードを返す', () {
      final resolver = JmaRegionResolver(
        cityMapData: JmaMap_JmaMapData(),
        tsunamiMapData: _tsunamiMapData(),
        earthquakeParameter: _buildParameter(),
      );

      final result = resolver.resolveTsunamiForecastRegionCode(36, 140.4);

      expect(result, '201');
    });
  });

  group('CityToRegionLookupBuilder.build', () {
    test('cityCode を親 region コード・名にマップする', () {
      final lookup = CityToRegionLookupBuilder.build(_buildParameter());

      expect(lookup['0720100']?.code, 250);
      expect(lookup['0720100']?.name, '福島県中通り');
      expect(lookup['0720500']?.code, 250);
      expect(lookup['0720300']?.code, 251);
      expect(lookup['0720300']?.name, '福島県浜通り');
    });

    test('region.code がパースできない場合は city も含めてスキップされる', () {
      final lookup = CityToRegionLookupBuilder.build(_buildParameter());
      expect(lookup.containsKey('9999999'), isFalse);
    });

    test('未登録 cityCode は null を返す', () {
      final lookup = CityToRegionLookupBuilder.build(_buildParameter());
      expect(lookup['0000000'], isNull);
    });
  });
}
