import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';

abstract interface class MapElement {
  MapNodeIdentity get identity;

  void mount();

  void update({required MapNode node});

  void unmount();
}

abstract interface class MapElementFactory {
  MapElement create({required MapNode node});
}
