import 'package:eqmonitor/feature/region_selection/data/logic/region_map_layers.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  const builder = RegionMapLayers();
  // iOS の NSPredicate → native filter 変換で受理される空集合への所属判定。
  // ['==', 1, 0] は属性名が数値の旧形式 filter として解釈されクラッシュする。
  const hiddenFilter = [
    'in',
    ['get', 'code'],
    ['literal', <String>[]],
  ];

  test('震央のヒット領域を隠すフィルターも空集合を使う', () {
    expect(RegionMapLayers.hiddenFilter, hiddenFilter);
  });

  for (final hasEpicenter in [false, true]) {
    test('初期化時の全ハイライトを空集合で隠す (hasEpicenter: $hasEpicenter)', () {
      final layers = builder
          .build(color: const Color(0xFF4D8DFF), hasEpicenter: hasEpicenter)
          .cast<StyleLayerWithSource>();
      final highlights = layers.where(
        (layer) => layer.id != RegionMapLayers.epicenterHit,
      );
      expect(highlights, hasLength(hasEpicenter ? 10 : 8));
      for (final layer in highlights) {
        expect(layer.filter?.toJson(), hiddenFilter, reason: layer.id);
        expect(
          (layer.toJson()['paint']!
              as Map<String, Object?>)['${layer.type}-color'],
          '#4d8dff',
          reason: layer.id,
        );
      }
      if (hasEpicenter) {
        expect(
          layers
              .singleWhere((layer) => layer.id == RegionMapLayers.epicenterHit)
              .filter,
          isNull,
        );
      }
    });
  }

  test('都道府県選択は市区町村ポリゴンを強調しない', () {
    const prefecture = RegionOption(kind: .prefecture, code: '01', name: '北海道');
    final layer = builder.selectionLayer(
      kind: .city,
      selected: [prefecture],
    );
    expect(layer.filter?.toJson(), hiddenFilter);
  });

  test('都道府県は専用ポリゴンのコードに一致する', () {
    final layer = builder.selectionLayer(
      kind: .prefecture,
      selected: const [
        RegionOption(kind: .prefecture, code: '01', name: '北海道'),
      ],
    );
    expect(layer.sourceId, RegionMapLayers.prefectureSource);
    expect(layer.sourceLayerId, isNull);
    expect(layer.filter?.toJson(), [
      'in',
      ['get', 'code'],
      [
        'literal',
        ['01'],
      ],
    ]);
  });

  for (final kind in RegionMapLayers.layers.keys) {
    test('${kind.name}: 選択後の全解除で空集合のフィルターに戻す', () {
      final option = RegionOption(kind: kind, code: '350', name: 'テスト地域');
      final selected = builder.selectionLayer(
        kind: kind,
        selected: [option],
      );
      expect(selected.filter?.toJson(), isNot(hiddenFilter));
      final cleared = builder.selectionLayer(
        kind: kind,
        selected: const [],
      );
      expect(cleared.id, selected.id);
      expect(cleared.filter?.toJson(), hiddenFilter);
    });
  }
}
