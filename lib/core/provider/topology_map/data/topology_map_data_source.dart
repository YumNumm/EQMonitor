import 'package:eqmonitor/core/provider/topology_map/model/topology_maps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'topology_map_data_source.g.dart';

@Riverpod(keepAlive: true)
TopologyMapsDataSource topologyMapsDataSource(TopologyMapsDataSourceRef ref) =>
    TopologyMapsDataSource();

class TopologyMapsDataSource {
  Future<TopologyMaps> loadTopologyMaps(String path) async => compute(
        (data) async {
          return TopologyMaps.fromString(data);
        },
        await rootBundle.loadString(path),
      );
}
