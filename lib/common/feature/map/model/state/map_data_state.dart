import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/projected/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/world_map_property.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class MapDataState {
  const MapDataState({
    this.data,
    this.projectedData,
  });

  final MapDataFromSource? data;
  final MapProjectedData? projectedData;

  // copywith
  MapDataState copyWith({
    bool? isReady,
    MapDataFromSource? data,
    MapProjectedData? projectedData,
  }) {
    return MapDataState(
      data: data ?? this.data,
      projectedData: projectedData ?? this.projectedData,
    );
  }
}

@immutable
class MapDataFromSource {
  const MapDataFromSource({
    required this.jmaMap,
    required this.tsunamiLine,
    required this.worldMap,
  });

  final Map<MapDataType, List<MultiPolygonMapData<JmaMapProperty>>> jmaMap;
  final List<MultiLineMapData<JmaMapProperty>> tsunamiLine;
  final List<MultiPolygonMapData<WorldMapProperty>> worldMap;
}

@immutable
class MapProjectedData {
  const MapProjectedData({
    required this.jmaMap,
    required this.worldMap,
    required this.tsunamiLine,
  });

  final Map<MapDataType, List<MultiPolygonProjectedMapData<JmaMapProperty>>>
      jmaMap;
  final List<MultiPolygonProjectedMapData<WorldMapProperty>> worldMap;
  final List<MultiLineProjectedMapData<JmaMapProperty>> tsunamiLine;
}
