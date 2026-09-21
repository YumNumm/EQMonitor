import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_region_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_layers.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_matcher.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_search.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_selection_reducer.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_map_metadata.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_selection_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('署名確認済みAsset Pack v0.1の数値IDを地名へ照合する', () {
    final fixture = jsonDecode(
      File('test/fixtures/region_selection/asset_pack_v0_1_epicenters.json')
          .readAsStringSync(),
    ) as Map<String, dynamic>;
    final metadata = RegionMapMetadata.fromJson(
      fixture['metadata'] as Map<String, dynamic>,
    );
    expect(metadata.layers.map((layer) => layer.id), contains('areaEpicenter'));
    final catalog = (fixture['epicenters'] as Map<String, dynamic>).entries
        .map(
          (item) => RegionOption(
            kind: .epicenter,
            code: item.key,
            name: item.value as String,
          ),
        )
        .toList();
    expect(
      const RegionMapMatcher()
          .epicenters(catalog: catalog, ids: [100, 350.0, 350, -1])
          .map((item) => item.name),
      ['石狩地方北部', '東京都２３区'],
    );
    expect(catalog.last.name, '遠地');
  });
  const reducer = RegionSelectionReducer();
  const tokyo = RegionOption(
    kind: .prefecture,
    code: '13',
    name: '東京都',
    englishName: 'Tokyo',
  );
  const city = RegionOption(
    kind: .city,
    code: '1320600',
    name: '府中市',
    kana: 'ふちゅうし',
    parentKind: .region,
    parentCode: '350',
    parentName: '東京都・東京都多摩東部',
    prefectureCode: '13',
  );
  const otherCity = RegionOption(
    kind: .city,
    code: '3420800',
    name: '府中市',
    kana: 'ふちゅうし',
    parentKind: .region,
    parentCode: '671',
    parentName: '広島県・広島県南東部',
    prefectureCode: '34',
  );
  const epicenter = RegionOption(
    kind: .epicenter,
    code: '350',
    name: '東京都多摩東部',
  );

  for (final kind in RegionKind.values) {
    test('${kind.name}: 単一は置換し、複数は追加・解除する', () {
      final a = RegionOption(kind: kind, code: '1', name: 'A');
      final b = RegionOption(kind: kind, code: '2', name: 'B');
      expect(reducer.select(selected: [a], option: b, mode: .single), [b]);
      final both = reducer.select(selected: [a], option: b, mode: .multiple);
      expect(both, [a, b]);
      expect(reducer.select(selected: both, option: a, mode: .multiple), [b]);
    });
  }

  test('種別が違う同一コードを混同せず複数選択する', () {
    const region = RegionOption(kind: .region, code: '350', name: '東京都多摩東部');
    expect(
      reducer.select(selected: [region], option: epicenter, mode: .multiple),
      [region, epicenter],
    );
  });

  test('同一市区町村の異なる通知親を選択結果まで維持する', () {
    final first = city.copyWith(
      parentKind: .eewRegion,
      parentCode: '9011',
      parentName: '地域A',
    );
    final second = first.copyWith(parentCode: '9012', parentName: '地域B');
    final selected = reducer.select(
      selected: [first],
      option: second,
      mode: .multiple,
    );
    expect(selected, hasLength(2));
    final converted = selected
        .map(const NotificationRegionSelectionConverter().convert)
        .toList();
    expect(converted.map((item) => item.regionCode), ['9011', '9012']);
    expect(converted.map((item) => item.cityCode), [city.code, city.code]);
    expect(
      () => const NotificationRegionSelectionConverter().convert(city),
      throwsArgumentError,
    );
  });

  test('復元時に名称を最新カタログへ揃え重複を除去する', () {
    final old = city.copyWith(name: city.code);
    expect(
      reducer.restore(
        selected: [old, old, otherCity],
        catalog: [city, otherCity],
        mode: .multiple,
      ),
      [city, otherCity],
    );
    expect(
      reducer.restore(
        selected: [old, otherCity],
        catalog: [city],
        mode: .single,
      ),
      [city],
    );
  });

  test('同名候補を区別し、英名と半角カナ・空白を正規化する', () {
    const search = RegionSearch();
    const items = [tokyo, city, otherCity, epicenter];
    expect(search.filter(items: items, query: '  ＴＯＫＹＯ　').single, tokyo);
    expect(search.filter(items: items, query: 'ﾌﾁｭｳｼ'), [city, otherCity]);
    expect(search.filter(items: items, query: 'ふちゅうし', parent: tokyo), [city]);
    expect(search.filter(items: items, query: '昨日の東京の震度3以上'), isEmpty);
    expect(search.filter(items: items, query: '', kind: .epicenter), [
      epicenter,
    ]);
  });

  test('地図の震央IDはコード表と照合し未知・重複・非整数を除外する', () {
    const matcher = RegionMapMatcher();
    expect(
      matcher.epicenters(
        catalog: [city, epicenter],
        ids: [350, 350.0, 350.5, 123456, double.nan],
      ),
      [epicenter],
    );
    expect(
      matcher.administrative(
        catalog: [tokyo, city, otherCity],
        kind: .prefecture,
        code: city.code,
      ),
      [tokyo],
    );
    expect(
      matcher.administrative(
        catalog: [city, otherCity],
        kind: .city,
        code: otherCity.code,
        parent: tokyo,
      ),
      isEmpty,
    );
  });

  test('通知の地図で複数の親候補を自動選択せず提示する', () {
    final first = city.copyWith(
      parentKind: .eewRegion,
      parentCode: '9011',
      parentName: '地域A',
    );
    final second = first.copyWith(parentCode: '9012', parentName: '地域B');
    expect(
      const RegionMapMatcher().administrative(
        catalog: [first, second],
        kind: .city,
        code: city.code,
      ),
      [first, second],
    );
  });

  test('地図の震央filterは数値id、都道府県は所属市区町村を使う', () {
    const layers = RegionMapLayers();
    expect(
      layers
          .selectionLayer(
            kind: .epicenter,
            selected: [epicenter],
            catalog: [epicenter],
          )
          .filter,
      [
        'in',
        ['get', 'id'],
        [
          'literal',
          [350],
        ],
      ],
    );
    expect(
      layers
          .selectionLayer(
            kind: .city,
            selected: [tokyo],
            catalog: [city, otherCity],
          )
          .filter,
      [
        'in',
        ['get', 'regioncode'],
        [
          'literal',
          [city.code],
        ],
      ],
    );
    expect(
      layers
          .build(color: '#123456', hasEpicenter: false)
          .any((layer) => layer.id.contains('epicenter')),
      isFalse,
    );
  });

  test('地域と震央の変更・個別解除が他の履歴条件を保持する', () {
    const base = EarthquakeHistoryParameter.all(
      sortBy: .magnitude,
      sortOrder: .asc,
      epicenterCodes: [350, 671],
      magnitudeGte: 4,
      depthLte: 100,
    );
    final regional = base.withRegion(
      const EarthquakeRegionSelection().result(option: city),
    );
    expect(regional.epicenterCodes, [350, 671]);
    expect(regional.toAll().epicenterCodes, [350, 671]);
    final cleared = regional.copyWith(epicenterCodes: null);
    expect(cleared, isA<EarthquakeHistoryParameterCity>());
    expect(cleared.magnitudeGte, 4);
    expect(cleared.depthLte, 100);
    expect(cleared.sortBy, base.sortBy);
    expect(cleared.sortOrder, base.sortOrder);
    expect(
      const EarthquakeRegionSelection().parameter(epicenter).epicenterCodes,
      [350],
    );
  });
}
