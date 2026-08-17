import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_map_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const filter = NotificationRegionMapFilter();

  test('未選択regionは一致しないfilterを返す', () {
    expect(filter.buildRegion(null), [
      '==',
      ['get', 'code'],
      '__eqmonitor_no_match__',
    ]);
  });

  test('フォーカスregion配下の市区町村だけに一致する', () {
    expect(filter.buildRegionCities(['0110100', '0120200']), [
      'in',
      ['get', 'regioncode'],
      [
        'literal',
        ['0110100', '0120200'],
      ],
    ]);
  });

  test('市区町村がないregionはどの境界にも一致しない', () {
    expect(filter.buildRegionCities(const []), [
      '==',
      ['get', 'regioncode'],
      '__eqmonitor_no_match__',
    ]);
  });

  test('選択中の市区町村だけに一致する', () {
    expect(filter.buildSelectedCity('0110100'), [
      '==',
      ['get', 'regioncode'],
      '0110100',
    ]);
  });
}
