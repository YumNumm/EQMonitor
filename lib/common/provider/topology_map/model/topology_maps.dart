import 'dart:convert';

import 'package:eq_map/eq_map.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:topo_map/topo_map.dart';

part 'topology_maps.freezed.dart';

@freezed
class TopologyMaps with _$TopologyMaps {
  const factory TopologyMaps({
    @Default({}) Map<LandLayerType, TopologyMap> maps,
  }) = _TopologyMaps;

  factory TopologyMaps.fromString(String data) {
    final json = jsonDecode(data) as Map<String, dynamic>;
    final maps = json.map((key, value) {
      final type = LandLayerType.values.firstWhere((e) => e.name == key);
      final map = TopologyMap.fromJson(value as Map<String, dynamic>);
      return MapEntry(type, map);
    });
    return TopologyMaps(maps: maps);
  }
}

@freezed
class MapData with _$MapData {
  const factory MapData({
    required Map<LandLayerType, FeatureLayer>? maps,
  }) = _MapData;

  static Future<MapData> fromTopologyMaps(TopologyMaps data) async {
    return compute(
      (maps) {
        final map = maps.maps.map((type, topoMap) {
          return MapEntry(
            type,
            FeatureLayer.fromTopologyMap(topoMap),
          );
        });
        return MapData(maps: map);
      },
      data,
    );
  }
}
