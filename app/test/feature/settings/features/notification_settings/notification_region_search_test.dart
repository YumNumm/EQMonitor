import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_search.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const search = NotificationRegionSearch();
  const items = [
    NotificationCityOption(code: '1', name: '札幌市', kana: 'さっぽろし'),
    NotificationCityOption(code: '2', name: 'Region 1', kana: null),
  ];

  List<NotificationCityOption> filter(String query) => search.filter(
    items: items,
    query: query,
    name: (item) => item.name,
    kana: (item) => item.kana,
  );

  test('漢字とふりがなのひらがな・カタカナ・半角カナで一致する', () {
    expect(filter('札幌').single.code, '1');
    expect(filter('サッポロ').single.code, '1');
    expect(filter('ｻｯﾎﾟﾛ').single.code, '1');
  });

  test('全角英数と空白を正規化して一致する', () {
    expect(filter('ＲＥＧＩＯＮ　１').single.code, '2');
  });

  test('空文字は元の順序を保つ', () {
    expect(filter('').map((item) => item.code), ['1', '2']);
  });
}
