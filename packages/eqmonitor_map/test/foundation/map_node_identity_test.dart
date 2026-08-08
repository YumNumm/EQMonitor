import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapNodeIdentity', () {
    test('has value equality for a matching key and type', () {
      final identity = createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'vector-tile'),
      );
      final sameIdentity = createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'vector-tile'),
      );

      expect(identity, sameIdentity);
      expect(identity.hashCode, sameIdentity.hashCode);
    });
  });

  group('classifyMapNodeIdentity', () {
    test('retains only a matching key and type', () {
      final current = createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'vector-tile'),
      );
      final same = createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'vector-tile'),
      );
      final changedKey = createMapNodeIdentity(
        key: createMapNodeKey(value: 'labels'),
        type: createMapNodeTypeId(value: 'vector-tile'),
      );
      final changedType = createMapNodeIdentity(
        key: createMapNodeKey(value: 'base-map'),
        type: createMapNodeTypeId(value: 'raster-tile'),
      );

      expect(
        classifyMapNodeIdentity(current: current, next: same),
        MapNodeIdentityChange.retained,
      );
      expect(
        classifyMapNodeIdentity(current: current, next: changedKey),
        MapNodeIdentityChange.replaced,
      );
      expect(
        classifyMapNodeIdentity(current: current, next: changedType),
        MapNodeIdentityChange.replaced,
      );
    });
  });
}
