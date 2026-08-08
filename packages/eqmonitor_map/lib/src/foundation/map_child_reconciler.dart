import 'package:eqmonitor_map/src/foundation/map_element.dart';
import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';

final class MapChildReconciler {
  final List<MapElement> _elements = [];

  List<MapElement> get elements => List<MapElement>.unmodifiable(_elements);

  void reconcile({
    required List<MapNode> nodes,
    required MapElementFactory factory,
  }) {
    final elementsByIdentity = <MapNodeIdentity, MapElement>{
      for (final element in _elements) element.identity: element,
    };
    final nextElements = <MapElement>[];

    for (final node in nodes) {
      final currentElement = elementsByIdentity[node.identity];
      if (currentElement == null) {
        final newElement = factory.create(node: node);
        newElement.mount();
        nextElements.add(newElement);
      } else {
        currentElement.update(node: node);
        nextElements.add(currentElement);
      }
    }

    _elements
      ..clear()
      ..addAll(nextElements);
  }
}
