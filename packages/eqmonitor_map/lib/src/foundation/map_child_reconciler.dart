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
    final nextNodeKeys = <MapNodeKey>{};
    for (final node in nodes) {
      if (!nextNodeKeys.add(node.identity.key)) {
        throw ArgumentError.value(
          node.identity.key,
          'nodes',
          'must not contain duplicate keys',
        );
      }
    }

    final elementsByKey = <MapNodeKey, MapElement>{
      for (final element in _elements) element.identity.key: element,
    };
    final nextElements = <MapElement>[];

    for (final node in nodes) {
      final currentElement = elementsByKey[node.identity.key];
      if (currentElement == null) {
        final newElement = factory.create(node: node);
        newElement.mount();
        nextElements.add(newElement);
      } else if (currentElement.identity == node.identity) {
        currentElement.update(node: node);
        nextElements.add(currentElement);
      } else {
        currentElement.unmount();
        final newElement = factory.create(node: node);
        newElement.mount();
        nextElements.add(newElement);
      }
    }

    for (final element in _elements.reversed) {
      if (!nextNodeKeys.contains(element.identity.key)) {
        element.unmount();
      }
    }

    _elements
      ..clear()
      ..addAll(nextElements);
  }

  void unmountAll() {
    for (final element in _elements.reversed) {
      element.unmount();
    }
    _elements.clear();
  }
}
