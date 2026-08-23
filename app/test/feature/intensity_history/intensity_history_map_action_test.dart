import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_history_map_action.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

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

final _prefectures = [
  EarthquakeParameterPrefectureItem(
    code: '0100',
    name: _name('北海道'),
    regions: [
      _region('100', ['0110000']),
    ],
  ),
];

void main() {
  const action = IntensityHistoryMapAction();

  group('cityTapTargetOf', () {
    test('市区町村と所属都道府県を組にして返す', () {
      final target = action.cityTapTargetOf(
        cityCode: '0110000',
        cityName: '札幌市',
        prefectures: _prefectures,
      );

      expect(target?.cityCode, '0110000');
      expect(target?.cityName, '札幌市');
      expect(target?.prefectureName, '北海道');
    });

    test('市区町村コードが無い場合は null', () {
      expect(
        action.cityTapTargetOf(
          cityCode: null,
          cityName: '札幌市',
          prefectures: _prefectures,
        ),
        isNull,
      );
    });

    test('所属都道府県を解決できない場合は null', () {
      expect(
        action.cityTapTargetOf(
          cityCode: '1310160',
          cityName: '千代田区',
          prefectures: _prefectures,
        ),
        isNull,
      );
    });
  });
}
