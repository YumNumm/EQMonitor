import 'package:eqmonitor/core/provider/topology_map/data/topology_map_data_source.dart';
import 'package:eqmonitor/core/provider/topology_map/model/topology_maps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topology_maps.g.dart';

@Riverpod(keepAlive: true)
Future<TopologyMaps> topologyMaps(TopologyMapsRef ref) {
  final dataSource = ref.watch(topologyMapsDataSourceProvider);
  return dataSource.loadTopologyMaps('assets/maps/topology_maps.json');
}

@Riverpod(keepAlive: true)
Future<MapData> mapData(MapDataRef ref) async {
  final topologyMaps = ref.watch(topologyMapsProvider);
  final value = topologyMaps.valueOrNull;
  if (value != null) {
    return MapData.fromTopologyMaps(value);
  } else {
    return const MapData(maps: null);
  }
}
