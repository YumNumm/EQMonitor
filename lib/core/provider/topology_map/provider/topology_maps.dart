import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/model/mutable/projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/core/provider/topology_map/data/topology_map_data_source.dart';
import 'package:eqmonitor/core/provider/topology_map/model/topology_maps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:topo_map/topo_map.dart';

part 'topology_maps.g.dart';

@Riverpod(keepAlive: true)
Future<TopologyMaps> topologyMaps(TopologyMapsRef ref) {
  final dataSource = ref.watch(topologyMapsDataSourceProvider);
  return dataSource.loadTopologyMaps('assets/maps/topology_maps.json');
}

@Riverpod(keepAlive: true)
Future<MapData> mapData(MapDataRef ref) async {
  final topologyMaps = await ref.watch(topologyMapsProvider.future);
  return MapData.fromTopologyMaps(topologyMaps);
}

@Riverpod(keepAlive: true)
Future<Map<LandLayerType, ZoomCachedProjectedFeatureLayer>>
    zoomCachedProjectedFeatureLayer(
  ZoomCachedProjectedFeatureLayerRef ref,
) async {
  final mapData = await ref.watch(mapDataProvider.future);
  return mapData.maps!.map(
    (key, value) => MapEntry(
      key,
      ZoomCachedProjectedFeatureLayer.fromProjectedFeatureLayer(
        ProjectedFeatureLayer.fromFeatureLayer(
          layer: value,
          projection: WebMercatorProjection(),
        ),
      ),
    ),
  );
}
