import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';

sealed class const MapNode() {
  MapNodeIdentity get identity;
}

final class MapDeclarationNode extends MapNode {
  new({
    required this.identity,
    required List<MapNode> children,
  }) : children = List<MapNode>.unmodifiable(children);

  @override
  final MapNodeIdentity identity;

  final List<MapNode> children;
}
