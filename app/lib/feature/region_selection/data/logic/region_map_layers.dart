import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:maplibre/maplibre.dart';

final class const RegionMapLayers() {
  static const epicenterHit = 'region-selection-epicenter-hit';
  static const source = 'eqmonitor_map';
  // 数値同士の比較は iOS で旧形式の属性フィルターと解釈されるため、空集合を使う。
  static const hiddenFilter = [
    'in',
    ['get', 'code'],
    ['literal', <String>[]],
  ];
  static const layers = {
    RegionKind.region: ('areaForecastLocalE', 'code'),
    RegionKind.eewRegion: ('areaForecastLocalEew', 'code'),
    RegionKind.city: ('areaInformationCityQuake', 'regioncode'),
    RegionKind.epicenter: ('areaEpicenter', 'id'),
  };

  List<StyleLayer> build({
    required String color,
    required bool hasEpicenter,
  }) => [
    if (hasEpicenter)
      const FillStyleLayer(
        id: epicenterHit,
        sourceId: source,
        sourceLayerId: 'areaEpicenter',
        paint: {'fill-color': '#808080', 'fill-opacity': 0.04},
      ),
    for (final entry in layers.entries)
      if (entry.key != .epicenter || hasEpicenter) ...[
        FillStyleLayer(
          id: 'region-selection-${entry.key.name}-fill',
          sourceId: source,
          sourceLayerId: entry.value.$1,
          filter: hiddenFilter,
          paint: {'fill-color': color, 'fill-opacity': 0.25},
        ),
        LineStyleLayer(
          id: 'region-selection-${entry.key.name}-line',
          sourceId: source,
          sourceLayerId: entry.value.$1,
          filter: hiddenFilter,
          paint: {'line-color': color, 'line-width': 2.5},
        ),
      ],
  ];

  FillStyleLayer selectionLayer({
    required RegionKind kind,
    required List<RegionOption> selected,
    required List<RegionOption> catalog,
  }) {
    final prefectures = selected
        .where((item) => item.kind == .prefecture)
        .map((item) => item.code)
        .toSet();
    final codes = {
      ...selected.where((item) => item.kind == kind).map((item) => item.code),
      if (kind == .city)
        ...catalog
            .where(
              (item) =>
                  item.kind == .city &&
                  prefectures.contains(item.prefectureCode),
            )
            .map((item) => item.code),
    };
    final (sourceLayer, property) =
        layers[kind] ?? (throw ArgumentError.value(kind));
    return FillStyleLayer(
      id: 'region-selection-${kind.name}-fill',
      sourceId: source,
      sourceLayerId: sourceLayer,
      filter: codes.isEmpty
          ? hiddenFilter
          : [
              'in',
              ['get', property],
              [
                'literal',
                kind == .epicenter
                    ? codes.map(int.parse).toList()
                    : codes.toList(),
              ],
            ],
    );
  }
}
