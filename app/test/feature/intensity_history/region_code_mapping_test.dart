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

EarthquakeParameterRegionItem _region(
  String code,
  List<String> cityCodes,
) =>
    EarthquakeParameterRegionItem(
      code: code,
      name: _name('region-$code'),
      kana: null,
      cities: cityCodes.map(_city).toList(),
    );

EarthquakeParameterPrefectureItem _pref(
  String code,
  List<EarthquakeParameterRegionItem> regions,
) =>
    EarthquakeParameterPrefectureItem(
      code: code,
      name: _name('pref-$code'),
      regions: regions,
    );

// サンプルデータ:
//   都道府県 '0100': 細分区域 '0110100', '0110200'
//                   市区町村 '0110101', '0110102' (prefix 01)
//   都道府県 '0200': 細分区域 '0210100'
//                   市区町村 '0210101' (prefix 02)
final _testPrefectures = [
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
      final result = prefectureCodeOfCity('0110101', _testPrefectures);
      expect(result, '0100');
    });

    test('別の都道府県の市区町村コードも正しく解決できる', () {
      final result = prefectureCodeOfCity('0210101', _testPrefectures);
      expect(result, '0200');
    });

    test('一致する都道府県が存在しない場合は null を返す', () {
      final result = prefectureCodeOfCity('9999999', _testPrefectures);
      expect(result, isNull);
    });
  });

  group('regionCodesOfPrefecture', () {
    test('都道府県配下の全細分区域 code を返す', () {
      final result = regionCodesOfPrefecture('0100', _testPrefectures);
      expect(result, containsAll(['0110100', '0110200']));
      expect(result.length, 2);
    });

    test('存在しない都道府県 code の場合は空リストを返す', () {
      final result = regionCodesOfPrefecture('9999', _testPrefectures);
      expect(result, isEmpty);
    });
  });

  group('prefectureOfRegionCode', () {
    test('細分区域コードから正しく都道府県コードと名前を返す', () {
      final result = prefectureOfRegionCode('0110100', _testPrefectures);
      expect(result?.code, '0100');
      expect(result?.name, 'pref-0100');
    });

    test('別の都道府県の細分区域コードも正しく解決できる', () {
      final result = prefectureOfRegionCode('0210100', _testPrefectures);
      expect(result?.code, '0200');
      expect(result?.name, 'pref-0200');
    });

    test('存在しない細分区域 code の場合は null を返す', () {
      final result = prefectureOfRegionCode('9999999', _testPrefectures);
      expect(result, isNull);
    });
  });

  group('cityCodesOfPrefecture', () {
    test('都道府県配下の全市区町村 code を返す', () {
      final result = cityCodesOfPrefecture('0100', _testPrefectures);
      expect(result, containsAll(['0110101', '0110102', '0110201']));
      expect(result.length, 3);
    });

    test('別の都道府県でも正しく返す', () {
      final result = cityCodesOfPrefecture('0200', _testPrefectures);
      expect(result, ['0210101']);
    });

    test('存在しない都道府県 code の場合は空リストを返す', () {
      final result = cityCodesOfPrefecture('9999', _testPrefectures);
      expect(result, isEmpty);
    });
  });
}
