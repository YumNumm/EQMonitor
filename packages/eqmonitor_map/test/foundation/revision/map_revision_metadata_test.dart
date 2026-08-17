import 'dart:io';

import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');
  final fullDigest = createMapContentDigest(value: 'sha256:full');
  final targetDigest = createMapContentDigest(value: 'sha256:target');

  group('revision metadata', () {
    test('creates full revision metadata with typed source and digest', () {
      final metadata = createMapFullRevision(
        source: source,
        revision: 4,
        digest: fullDigest,
      );

      expect(metadata.source, source);
      expect(metadata.revision, 4);
      expect(metadata.digest, fullDigest);
    });

    test('creates delta revision metadata with exact base and target', () {
      final metadata = createMapDeltaRevision(
        source: source,
        baseRevision: 4,
        targetRevision: 7,
        targetDigest: targetDigest,
      );

      expect(metadata.source, source);
      expect(metadata.baseRevision, 4);
      expect(metadata.targetRevision, 7);
      expect(metadata.targetDigest, targetDigest);
    });

    test('accepts zero as the initial full revision', () {
      final metadata = createMapFullRevision(
        source: source,
        revision: 0,
        digest: fullDigest,
      );

      expect(metadata.source, source);
      expect(metadata.revision, 0);
      expect(metadata.digest, fullDigest);
    });

    test('accepts the first delta from zero and preserves its fields', () {
      final metadata = createMapDeltaRevision(
        source: source,
        baseRevision: 0,
        targetRevision: 1,
        targetDigest: targetDigest,
      );

      expect(metadata.source, source);
      expect(metadata.baseRevision, 0);
      expect(metadata.targetRevision, 1);
      expect(metadata.targetDigest, targetDigest);
    });

    test('rejects negative full and delta revisions', () {
      expect(
        () => createMapFullRevision(
          source: source,
          revision: -1,
          digest: fullDigest,
        ),
        throwsArgumentError,
      );
      expect(
        () => createMapDeltaRevision(
          source: source,
          baseRevision: -1,
          targetRevision: 1,
          targetDigest: targetDigest,
        ),
        throwsArgumentError,
      );
      expect(
        () => createMapDeltaRevision(
          source: source,
          baseRevision: 0,
          targetRevision: -1,
          targetDigest: targetDigest,
        ),
        throwsArgumentError,
      );
    });

    test('rejects delta target revision equal to or below its base', () {
      expect(
        () => createMapDeltaRevision(
          source: source,
          baseRevision: 4,
          targetRevision: 4,
          targetDigest: targetDigest,
        ),
        throwsArgumentError,
      );
      expect(
        () => createMapDeltaRevision(
          source: source,
          baseRevision: 4,
          targetRevision: 3,
          targetDigest: targetDigest,
        ),
        throwsArgumentError,
      );
    });

    test('does not generate an unchecked copyWith API', () {
      final generatedSource = File(
        'lib/src/foundation/revision/map_revision.freezed.dart',
      ).readAsStringSync();

      expect(
        RegExp(r'\b(?:copyWith|CopyWith)\b').hasMatch(generatedSource),
        isFalse,
      );
    });
  });
}
