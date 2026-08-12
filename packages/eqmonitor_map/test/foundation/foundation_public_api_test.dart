import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void consume<T>(T value) {}

void main() {
  test('core frame revision public inventory', () {
    for (final action in nodeInventory()) {
      expect(action, returnsNormally);
    }
  });
}

List<void Function()> nodeInventory() {
  final key = createMapNodeKey(value: 'root');
  final type = createMapNodeTypeId(value: 'group');
  final identity = createMapNodeIdentity(key: key, type: type);
  final node = MapDeclarationNode(identity: identity, children: const []);
  final MapElementFactory factory = _ElementFactory();
  final MapElement element = factory.create(node: node);
  final reconciler = MapChildReconciler();
  return [
    () => consume(createMapNodeKey(value: 'key')),
    () => consume(createMapNodeTypeId(value: 'type')),
    () => consume(createMapNodeIdentity(key: key, type: type)),
    () => consume<MapNodeIdentity>(identity),
    () => consume(classifyMapNodeIdentity(current: identity, next: identity)),
    () => consume(MapNodeIdentityChange.values),
    () => consume<MapNode>(node),
    () => consume(MapDeclarationNode(identity: identity, children: const [])),
    () => consume(MapScene(children: [node])),
    () => consume(element.identity),
    () => element.mount(),
    () => element.update(node: node),
    () => element.unmount(),
    () => consume(factory.create(node: node)),
    () => consume(reconciler.elements),
    () => reconciler.reconcile(nodes: [node], factory: factory),
    () => reconciler.unmountAll(),
  ];
}

final class _ElementFactory implements MapElementFactory {
  @override
  MapElement create({required MapNode node}) => _Element(node.identity);
}

final class _Element implements MapElement {
  const _Element(this.identity);

  @override
  final MapNodeIdentity identity;

  @override
  void mount() {}

  @override
  void unmount() {}

  @override
  void update({required MapNode node}) {}
}
