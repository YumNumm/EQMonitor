import 'package:eqmonitor_map/src/foundation/map_child_reconciler.dart';
import 'package:eqmonitor_map/src/foundation/map_element.dart';
import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unmounts an element before mounting a replacement with its key', () {
    final calls = <String>[];
    final reconciler = MapChildReconciler();
    final factory = ReplaceTrackingElementFactory(calls: calls);
    final original = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'vector'),
      ),
      children: const [],
    );
    final replacement = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'raster'),
      ),
      children: const [],
    );

    reconciler.reconcile(nodes: [original], factory: factory);
    reconciler.reconcile(nodes: [replacement], factory: factory);

    expect(calls, ['vector:mount', 'vector:unmount', 'raster:mount']);
    expect(reconciler.elements.single.identity, replacement.identity);
  });

  test('unmounts removed elements in their previous reverse order', () {
    final calls = <String>[];
    final reconciler = MapChildReconciler();
    final factory = ReplaceTrackingElementFactory(calls: calls);
    final first = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'first'),
        type: createMapNodeTypeId(value: 'first'),
      ),
      children: const [],
    );
    final second = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'second'),
        type: createMapNodeTypeId(value: 'second'),
      ),
      children: const [],
    );
    final third = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'third'),
        type: createMapNodeTypeId(value: 'third'),
      ),
      children: const [],
    );

    reconciler.reconcile(nodes: [first, second, third], factory: factory);
    reconciler.reconcile(nodes: [second], factory: factory);

    expect(
      calls,
      [
        'first:mount',
        'second:mount',
        'third:mount',
        'second:update',
        'third:unmount',
        'first:unmount',
      ],
    );
    expect(reconciler.elements.single.identity, second.identity);
  });

  test('rejects duplicate next keys without any lifecycle side effects', () {
    final calls = <String>[];
    final reconciler = MapChildReconciler();
    final factory = ReplaceTrackingElementFactory(calls: calls);
    final current = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'current'),
        type: createMapNodeTypeId(value: 'current'),
      ),
      children: const [],
    );
    final newNode = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'new'),
        type: createMapNodeTypeId(value: 'new'),
      ),
      children: const [],
    );
    final duplicateCurrent = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'current'),
        type: createMapNodeTypeId(value: 'replacement'),
      ),
      children: const [],
    );

    reconciler.reconcile(nodes: [current], factory: factory);

    expect(
      () => reconciler.reconcile(
        nodes: [newNode, current, duplicateCurrent],
        factory: factory,
      ),
      throwsArgumentError,
    );
    expect(calls, ['current:mount']);
    expect(factory.createdNodes, [current]);
    expect(reconciler.elements.single.identity, current.identity);
  });

  test('unmountAll is idempotent and unmounts in reverse order', () {
    final calls = <String>[];
    final reconciler = MapChildReconciler();
    final factory = ReplaceTrackingElementFactory(calls: calls);
    final first = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'first'),
        type: createMapNodeTypeId(value: 'first'),
      ),
      children: const [],
    );
    final second = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'second'),
        type: createMapNodeTypeId(value: 'second'),
      ),
      children: const [],
    );

    reconciler.reconcile(nodes: [first, second], factory: factory);
    reconciler.unmountAll();
    reconciler.unmountAll();

    expect(
      calls,
      ['first:mount', 'second:mount', 'second:unmount', 'first:unmount'],
    );
    expect(reconciler.elements, isEmpty);
  });
}

final class ReplaceTrackingElement implements MapElement {
  ReplaceTrackingElement({required MapNode node, required this.calls})
    : identity = node.identity;

  final List<String> calls;

  @override
  final MapNodeIdentity identity;

  @override
  void mount() {
    calls.add('${identity.type.value}:mount');
  }

  @override
  void unmount() {
    calls.add('${identity.type.value}:unmount');
  }

  @override
  void update({required MapNode node}) {
    calls.add('${identity.type.value}:update');
  }
}

final class ReplaceTrackingElementFactory implements MapElementFactory {
  ReplaceTrackingElementFactory({required this.calls});

  final List<String> calls;
  final List<MapNode> createdNodes = [];

  @override
  ReplaceTrackingElement create({required MapNode node}) {
    createdNodes.add(node);
    return ReplaceTrackingElement(node: node, calls: calls);
  }
}
