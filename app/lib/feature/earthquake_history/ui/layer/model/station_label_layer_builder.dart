import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const StationLabelLayerBuilder() {
  static const double iconLogicalRadius = 25;
  static const double textSize = 11;
  static const double gap = 3;

  SymbolStyleLayer build({
    required String id,
    required String sourceId,
    required EarthquakeHistoryMapLayerParameter parameter,
    required double iconPixelRatio,
  }) {
    // アイコン画像は論理 50px を端末のピクセル比で拡大した実寸で登録される。
    double radialOffset(double iconSize) =>
        (iconLogicalRadius * iconPixelRatio * iconSize + gap) / textSize;
    return SymbolStyleLayer(
      id: id,
      sourceId: sourceId,
      minZoom: parameter.stationLabelMinZoom,
      textField: const .raw(['get', 'name']),
      textFont: const .literal(['Noto Sans CJK JP Bold']),
      textSize: const .literal(textSize),
      textVariableAnchor: const .literal([.left, .right, .top, .bottom]),
      textRadialOffset: .raw([
        'interpolate',
        ['linear'],
        ['zoom'],
        7,
        radialOffset(parameter.stationIconSizeMid),
        20,
        radialOffset(parameter.stationIconSizeMax),
      ]),
      textJustify: const .literal(.auto),
      textMaxWidth: const .literal(30),
      textAllowOverlap: const .literal(false),
      textIgnorePlacement: const .literal(false),
      // 値が小さいほど先に配置されるため、震度の大きい観測点を優先する。
      sortKey: const .raw([
        '-',
        0,
        ['get', 'sortKey'],
      ]),
      textColor: const .literal(Color(0xFFFFFFFF)),
      textHaloColor: const .literal(Color(0xFF000000)),
      textHaloWidth: const .literal(1),
    );
  }
}
