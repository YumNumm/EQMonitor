import 'package:eqmonitor_map/src/foundation/map_child_reconciler.dart';
import 'package:eqmonitor_map/src/foundation/map_element.dart';
import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('retains elements and reorders them to match the declaration order', () {
    final firstIdentity = createMapNodeIdentity(
      key: createMapNodeKey(value: 'first'),
      type: createMapNodeTypeId(value: 'source'),
    );
    final secondIdentity = createMapNodeIdentity(
      key: createMapNodeKey(value: 'second'),
      type: createMapNodeTypeId(value: 'source'),
    );
    final firstNode = MapDeclarationNode(
      identity: firstIdentity,
      children: const [],
    );
    final secondNode = MapDeclarationNode(
      identity: secondIdentity,
      children: const [],
    );
    final reorderedSecondNode = MapDeclarationNode(
      identity: secondIdentity,
      children: [firstNode],
    );
    final reorderedFirstNode = MapDeclarationNode(
      identity: firstIdentity,
      children: [secondNode],
    );
    final factory = RetainTrackingElementFactory();
    final reconciler = MapChildReconciler();

    reconciler.reconcile(
      nodes: [firstNode, secondNode],
      factory: factory,
    );
    final firstElement = reconciler.elements.first as RetainTrackingElement;
    final secondElement = reconciler.elements.last as RetainTrackingElement;

    expect(firstElement.calls, ['mount']);
    expect(secondElement.calls, ['mount']);

    reconciler.reconcile(
      nodes: [reorderedSecondNode, reorderedFirstNode],
      factory: factory,
    );

    expect(reconciler.elements, [secondElement, firstElement]);
    expect(factory.createdNodes, [firstNode, secondNode]);
    expect(firstElement.updatedNodes, [reorderedFirstNode]);
    expect(secondElement.updatedNodes, [reorderedSecondNode]);
    expect(firstElement.calls, ['mount', 'update']);
    expect(secondElement.calls, ['mount', 'update']);
  });
}

final class RetainTrackingElement implements MapElement {
  new({required MapNode node}) : identity = node.identity;

  @override
  final MapNodeIdentity identity;

  final List<MapNode> updatedNodes = [];
  final List<String> calls = [];

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
    updatedNodes.add(node);
    calls.add('update');
  }
}

final class RetainTrackingElementFactory implements MapElementFactory {
  final List<MapNode> createdNodes = [];

  @override
  RetainTrackingElement create({required MapNode node}) {
    createdNodes.add(node);
    return RetainTrackingElement(node: node);
  }
}
