import 'package:eqmonitor_map/src/foundation/map_node.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/map_scene.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('owns outer and nested child lists', () {
    final nestedChildren = <MapNode>[];
    final parent = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'source'),
      ),
      children: nestedChildren,
    );
    final sceneChildren = <MapNode>[parent];
    final scene = MapScene(children: sceneChildren);

    nestedChildren.add(
      MapDeclarationNode(
        identity: createMapNodeIdentity(
          key: createMapNodeKey(value: 'late-child'),
          type: createMapNodeTypeId(value: 'layer'),
        ),
        children: const [],
      ),
    );
    sceneChildren.clear();

    expect(scene.children, hasLength(1));
    expect(parent.children, isEmpty);
  });

  test('exposes unmodifiable scene and declaration children', () {
    final node = MapDeclarationNode(
      identity: createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'source'),
      ),
      children: const [],
    );
    final scene = MapScene(children: [node]);

    expect(scene.children.clear, throwsUnsupportedError);
    expect(() => node.children.add(node), throwsUnsupportedError);
  });
}
