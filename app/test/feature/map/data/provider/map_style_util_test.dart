import 'package:eqmonitor/core/theme/model/map_colors.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapStyleUtil.buildStyleJson', () {
    late List<Map<String, dynamic>> layers;

    setUp(() {
      final json = MapStyleUtil.buildStyleJson(
        mapColors: const MapColors(
          background: Color(0xFF000001),
          worldLand: Color(0xFF000002),
          worldLine: Color(0xFF000003),
          japanLand: Color(0xFF000004),
          japanLine: Color(0xFF000005),
        ),
        mapSourceUrl: 'pmtiles://file:///map.pmtiles',
      );
      layers = (json['layers'] as List).cast<Map<String, dynamic>>();
    });

    test('レイヤーは BaseLayer の宣言順で、すべて style に含まれる', () {
      expect(
        layers.map((layer) => layer['id']).toList(),
        BaseLayer.values.map((layer) => layer.name).toList(),
      );
    });

    test('アンカーは描画されない background レイヤーである', () {
      final anchors = layers.where(
        (layer) => (layer['id'] as String).endsWith('Anchor'),
      );

      expect(anchors, hasLength(7));
      for (final anchor in anchors) {
        expect(anchor['type'], 'background');
        expect(anchor['paint'], {'background-opacity': 0});
      }
    });

    test('マーカー用アンカーは 背面 → P/S波 → 下側 → 上側 の順に重なる', () {
      final ids = layers.map((layer) => layer['id']).toList();
      int indexOf(BaseLayer layer) => ids.indexOf(layer.name);

      expect(
        [
          BaseLayer.regionFillAnchor,
          BaseLayer.areaForecastLocalEewLine,
          BaseLayer.regionOverlayAnchor,
          BaseLayer.foregroundOverlayAnchor,
          BaseLayer.markerBackgroundAnchor,
          BaseLayer.waveLineAnchor,
          BaseLayer.markerLowerAnchor,
          BaseLayer.markerUpperAnchor,
        ].map(indexOf).toList(),
        isSortedAscending,
      );
    });
  });
}

const isSortedAscending = _IsSortedAscending();

class _IsSortedAscending extends Matcher {
  const new();

  @override
  bool matches(Object? item, Map<dynamic, dynamic> matchState) {
    if (item is! List<int>) {
      return false;
    }
    for (var i = 1; i < item.length; i++) {
      if (item[i - 1] >= item[i]) {
        return false;
      }
    }
    return !item.contains(-1);
  }

  @override
  Description describe(Description description) =>
      description.add('strictly ascending layer indexes');
}
