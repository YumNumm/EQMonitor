import 'dart:math' as math;

import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:jma_map/jma_map.dart';

typedef RegionBounds = ({
  double south,
  double west,
  double north,
  double east,
});

final class const RegionBoundsResolver() {
  RegionBounds? resolve({
    required Map<JmaMapType, JmaMap_JmaMapData> maps,
    required List<RegionOption> catalog,
    required List<RegionOption> targets,
  }) {
    final regionCodes = <String>{};
    final cityCodes = <String>{};
    for (final target in targets) {
      switch (target.kind) {
        case .prefecture:
          regionCodes.addAll(
            catalog
                .where(
                  (item) =>
                      item.kind == .region &&
                      item.prefectureCode == target.code,
                )
                .map((item) => item.code),
          );
        case .region:
          regionCodes.add(target.code);
        case .city:
          cityCodes.add(target.code);
        case .eewRegion || .epicenter || .station:
          break;
      }
    }
    final items = [
      ...?maps[JmaMapType.areaForecastLocalE]?.data.where(
        (item) => regionCodes.contains(item.property.code),
      ),
      ...?maps[JmaMapType.areaInformationCity]?.data.where(
        (item) => cityCodes.contains(item.property.code),
      ),
    ].where((item) => item.hasBounds());
    RegionBounds? result;
    for (final item in items) {
      final bounds = item.bounds;
      final current = result;
      result = current == null
          ? (
              south: bounds.southWest.lat,
              west: bounds.southWest.lng,
              north: bounds.northEast.lat,
              east: bounds.northEast.lng,
            )
          : (
              south: math.min(current.south, bounds.southWest.lat),
              west: math.min(current.west, bounds.southWest.lng),
              north: math.max(current.north, bounds.northEast.lat),
              east: math.max(current.east, bounds.northEast.lng),
            );
    }
    return result;
  }
}
