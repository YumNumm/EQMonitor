import 'package:eqmonitor_map/src/foundation/map_node.dart';

final class MapScene {
  new({required List<MapNode> children})
    : children = List<MapNode>.unmodifiable(children);

  final List<MapNode> children;
}
