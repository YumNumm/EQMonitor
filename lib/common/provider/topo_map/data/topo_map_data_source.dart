import 'package:eqmonitor/common/provider/topo_map/model/topology_maps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TopoMapDataSource {
  Future<TopologyMaps> loadTopologyMaps(String path) async {
    Future<TopologyMaps> load(String path) async {
      final data = await rootBundle.loadString(path);
      return TopologyMaps.fromString(data);
    }

    return compute(
      load,
      path,
    );
  }
}
