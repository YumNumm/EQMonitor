import 'package:eqmonitor/common/feature/map/data/map_data_source.dart';
import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/world_map_property.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_provider.g.dart';

@Riverpod(keepAlive: true)
Future<MapDataState> mapData(MapDataRef ref) async {
  final jmaMapData = <MapDataType, List<MultiPolygonMapData<JmaMapProperty>>>{};
  late final List<MultiPolygonMapData<WorldMapProperty>> worldMapData;
  final futures = <Future<void>>[];
  for (final e in MapDataType.values) {
    futures.add(
      () async {
        final data = await ref.read(mapLocalDataSourceProvider).loadJmaMap(
              e.type,
            );
        jmaMapData[e] = data;
      }(),
    );
  }
  return const MapDataState(
    jmaMapData: {},
    worldMapData: [],
  );
}
