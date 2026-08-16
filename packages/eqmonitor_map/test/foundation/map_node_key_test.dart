import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapNodeKey', () {
    test('normalizes surrounding whitespace and supports value equality', () {
      final key = createMapNodeKey(value: '  base-map  ');
      final sameKey = createMapNodeKey(value: 'base-map');

      expect(key.value, 'base-map');
      expect(key, sameKey);
      expect(key.hashCode, sameKey.hashCode);
    });

    test('rejects blank values', () {
      expect(
        () => createMapNodeKey(value: ' \n\t '),
        throwsArgumentError,
      );
    });
  });

  group('MapNodeTypeId', () {
    test('normalizes surrounding whitespace and supports value equality', () {
      final type = createMapNodeTypeId(value: '  vector-tile  ');
      final sameType = createMapNodeTypeId(value: 'vector-tile');

      expect(type.value, 'vector-tile');
      expect(type, sameType);
      expect(type.hashCode, sameType.hashCode);
    });

    test('rejects blank values', () {
      expect(
        () => createMapNodeTypeId(value: ' \n\t '),
        throwsArgumentError,
      );
    });

    test('remains a distinct static type from MapNodeKey', () {
      final key = createMapNodeKey(value: 'base-map');
      final type = createMapNodeTypeId(value: 'base-map');

      expect(key.value, type.value);
    });
  });
}
