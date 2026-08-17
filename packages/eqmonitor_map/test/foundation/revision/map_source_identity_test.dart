import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapSourceInstanceId', () {
    test('normalizes surrounding whitespace and supports value equality', () {
      final source = createMapSourceInstanceId(value: '  jma-tiles  ');
      final sameSource = createMapSourceInstanceId(value: 'jma-tiles');

      expect(source.value, 'jma-tiles');
      expect(source, sameSource);
      expect(source.hashCode, sameSource.hashCode);
    });

    test('rejects blank values', () {
      expect(
        () => createMapSourceInstanceId(value: ' \n\t '),
        throwsArgumentError,
      );
    });
  });

  group('MapContentDigest', () {
    test('normalizes surrounding whitespace and supports value equality', () {
      final digest = createMapContentDigest(value: '  sha256:abc  ');
      final sameDigest = createMapContentDigest(value: 'sha256:abc');

      expect(digest.value, 'sha256:abc');
      expect(digest, sameDigest);
      expect(digest.hashCode, sameDigest.hashCode);
    });

    test('rejects blank values and remains a distinct static type', () {
      final source = createMapSourceInstanceId(value: 'sha256:abc');
      final digest = createMapContentDigest(value: 'sha256:abc');

      expect(source.value, digest.value);
      expect(
        () => createMapContentDigest(value: ' \n\t '),
        throwsArgumentError,
      );
    });
  });
}
