import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

LocalizedName _name(String ja) => LocalizedName(ja: ja, en: ja);

EarthquakeParameterCityItem _city(String code) => EarthquakeParameterCityItem(
  code: code,
  name: _name('city-$code'),
  kana: null,
  stations: const [],
);

EarthquakeParameterRegionItem _region(String code, List<String> cityCodes) =>
    EarthquakeParameterRegionItem(
      code: code,
      name: _name('region-$code'),
      kana: null,
      cities: cityCodes.map(_city).toList(),
    );

EarthquakeParameterPrefectureItem _pref(
  String code,
  List<EarthquakeParameterRegionItem> regions,
) => EarthquakeParameterPrefectureItem(
  code: code,
  name: _name('pref-$code'),
  regions: regions,
);

// サンプルデータ:
//   都道府県 '0100': 細分区域 '0110100', '0110200'
//                   市区町村 '0110101', '0110102' (prefix 01)
//   都道府県 '0200': 細分区域 '0210100'
//                   市区町村 '0210101' (prefix 02)
final List<EarthquakeParameterPrefectureItem> _testPrefectures = [
  _pref('0100', [
    _region('0110100', ['0110101', '0110102']),
    _region('0110200', ['0110201']),
  ]),
  _pref('0200', [
    _region('0210100', ['0210101']),
  ]),
];

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('prefectureCodeOfCity', () {
    test('市区町村 code の前 2 桁が都道府県 code の前 2 桁と一致する場合に都道府県 code を返す', () {
      final result = RegionCodeMapping.prefectureCodeOfCity(
        '0110101',
        _testPrefectures,
      );
      expect(result, '0100');
    });

    test('別の都道府県の市区町村コードも正しく解決できる', () {
      final result = RegionCodeMapping.prefectureCodeOfCity(
        '0210101',
        _testPrefectures,
      );
      expect(result, '0200');
    });

    test('一致する都道府県が存在しない場合は null を返す', () {
      final result = RegionCodeMapping.prefectureCodeOfCity(
        '9999999',
        _testPrefectures,
      );
      expect(result, isNull);
    });
  });
}
