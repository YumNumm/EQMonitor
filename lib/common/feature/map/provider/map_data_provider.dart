import 'dart:developer';

import 'package:eqmonitor/common/feature/map/data/map_data_source.dart';
import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/projected/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/state/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/model/world_map_property.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_data_provider.g.dart';

@Riverpod(keepAlive: true)
class MapData extends _$MapData {
  @override
  MapDataState build() => const MapDataState(
        isReady: false,
      );

  MapDataFromSource? _mapDataFromSource;
  MapProjectedData? _mapProjectedData;
  Future<void> initialize() async {
    _mapDataFromSource ??= await _mapData();
    _mapProjectedData ??= await _projectMap();
    state = state.copyWith(
      isReady: true,
    );
  }

  Future<MapDataFromSource> _mapData() async {
    final jmaMapData =
        <MapDataType, List<MultiPolygonMapData<JmaMapProperty>>>{};
    late final List<MultiPolygonMapData<WorldMapProperty>> worldMapData;
    late final List<MultiLineMapData<JmaMapProperty>> tsunamiData;
    final futures = <Future<dynamic>>[];
    for (final e in MapDataType.values) {
      if (e == MapDataType.worldMap) {
        futures.add(
          ref
              .read(mapLocalDataSourceProvider)
              .loadWorldMap(e.path)
              .then((data) => worldMapData = data),
        );
      } else {
        futures.add(
          ref
              .read(mapLocalDataSourceProvider)
              .loadJmaMap(
                e.path,
              )
              .then((data) => jmaMapData[e] = data),
        );
      }
    }
    for (final e in LineDataType.values) {
      futures.add(
        ref
            .read(mapLocalDataSourceProvider)
            .loadTsunamiMapData(e.path)
            .then((value) => tsunamiData = value),
      );
    }
    await Future.wait(futures);
    log(
      'jmaMapData: ${jmaMapData.length}, worldMapData: ${worldMapData.length}, tsunamiData: ${tsunamiData.length}',
    );
    return MapDataFromSource(
      jmaMap: jmaMapData,
      worldMap: worldMapData,
      tsunamiLine: tsunamiData,
    );
  }

  Future<MapProjectedData> _projectMap() async {
    if (_mapDataFromSource == null) {
      throw Error();
    }
    final jmaProjectedMap =
        <MapDataType, List<MultiPolygonProjectedMapData<JmaMapProperty>>>{};
    final projection = WebMercatorProjection();
    for (final type in MapDataType.values) {
      if (type == MapDataType.worldMap) {
        continue;
      }
      final map = _mapDataFromSource!.jmaMap[type]!;
      final projectedMap = <MultiPolygonProjectedMapData<JmaMapProperty>>[];
      for (final e in map) {
        projectedMap.add(
          MultiPolygonProjectedMapData.fromMapData(
            e,
            projection,
          ),
        );
      }
      jmaProjectedMap[type] = projectedMap;
    }

    final worldProjectedMap =
        <MultiPolygonProjectedMapData<WorldMapProperty>>[];
    for (final e in _mapDataFromSource!.worldMap) {
      worldProjectedMap.add(
        MultiPolygonProjectedMapData.fromMapData(
          e,
          projection,
        ),
      );
    }

    final tsunamiProjectedLine = <MultiLineProjectedMapData<JmaMapProperty>>[];
    for (final e in _mapDataFromSource!.tsunamiLine) {
      tsunamiProjectedLine.add(
        MultiLineProjectedMapData.fromLineData(
          e,
          projection,
        ),
      );
    }

    return MapProjectedData(
      jmaMap: jmaProjectedMap,
      worldMap: worldProjectedMap,
      tsunamiLine: tsunamiProjectedLine,
    );
  }

  MapProjectedData get mapProjectedData {
    if (_mapProjectedData == null) {
      throw Error();
    }
    return _mapProjectedData!;
  }
}
