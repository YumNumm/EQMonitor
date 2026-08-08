import 'package:eqmonitor_map/src/foundation/map_element.dart';
import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('records mount update and unmount lifecycle calls', () {
    final initialNode = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'source'),
      ),
      children: const [],
    );
    final updatedNode = MapDeclarationNode(
      identity: initialNode.identity,
      children: const [],
    );
    final factory = MapElementLifecycleFactory();

    final element = factory.create(node: initialNode);
    element.mount();
    element.update(node: updatedNode);
    element.unmount();

    expect(element.identity, initialNode.identity);
    expect(element.calls, ['mount', 'update', 'unmount']);
    expect(factory.createdNodes, [initialNode]);
  });
}

final class MapElementLifecycleFake implements MapElement {
  MapElementLifecycleFake({required MapNode node}) : identity = node.identity;

  final List<String> calls = [];

  @override
  final MapNodeIdentity identity;

  @override
  void mount() {
    calls.add('mount');
  }

  @override
  void unmount() {
    calls.add('unmount');
  }

  @override
  void update({required MapNode node}) {
    calls.add('update');
  }
}

final class MapElementLifecycleFactory implements MapElementFactory {
  final List<MapNode> createdNodes = [];

  @override
  MapElementLifecycleFake create({required MapNode node}) {
    createdNodes.add(node);
    return MapElementLifecycleFake(node: node);
  }
}
