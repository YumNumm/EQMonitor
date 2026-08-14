import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

// 手組みの EarthquakeParameter (1都道府県→1地域→1市→1観測点)
const _testParameter = EarthquakeParameter(
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
      code: '010',
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
              stations: [
                EarthquakeParameterStationItem(
                  code: '0110100',
                  noCode: 'S01100',
                  name: LocalizedName(ja: '札幌'),
                  kana: null,
                  status: EarthquakeStationStatus.operating,
                  sourceStatus: 'operating',
                  owner: 'JMA',
                  location: LatLng(43.06, 141.35),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() {
  group('resolveRegionName', () {
    test('1. prefecture コードで都道府県名が引ける', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.prefecture,
        code: '010',
      );
      expect(result, '北海道');
    });

    test('2. region コードで細分化地域名が引ける', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.region,
        code: '010100',
      );
      expect(result, '道央');
    });

    test('3. city コードで市区町村名が引ける', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.city,
        code: '01100',
      );
      expect(result, '札幌市');
    });

    test('4. station コードで観測点名が引ける', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.station,
        code: '0110100',
      );
      expect(result, '札幌');
    });

    test('5. 存在しないコードで null', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.prefecture,
        code: '999',
      );
      expect(result, isNull);
    });

    test('5b. 存在しないコード (region) で null', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.region,
        code: '999999',
      );
      expect(result, isNull);
    });

    test('5c. 存在しないコード (city) で null', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.city,
        code: '99999',
      );
      expect(result, isNull);
    });

    test('5d. 存在しないコード (station) で null', () {
      final result = const RegionNameResolver().resolve(
        parameter: _testParameter,
        searchType: RegionSearchType.station,
        code: '9999999',
      );
      expect(result, isNull);
    });
  });
}
