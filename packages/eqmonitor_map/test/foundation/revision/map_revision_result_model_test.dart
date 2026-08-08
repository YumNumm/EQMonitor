import 'dart:io';

import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');
  final digest = createMapContentDigest(value: 'sha256:committed');

  group('revision result models', () {
    test('creates a committed revision with its complete typed state', () {
      final committed = createMapCommittedRevision(
        source: source,
        revision: 8,
        digest: digest,
        state: 'complete-feature-set',
      );

      expect(committed.source, source);
      expect(committed.revision, 8);
      expect(committed.digest, digest);
      expect(committed.state, 'complete-feature-set');
    });

    test('creates a source-scoped full resync request after a revision', () {
      final request = createMapFullResyncRequest(
        source: source,
        afterRevision: 8,
      );

      expect(request.source, source);
      expect(request.afterRevision, 8);
    });

    test('represents a full resync request without a current revision', () {
      final request = createMapFullResyncRequest(
        source: source,
        afterRevision: null,
      );

      expect(request.source, source);
      expect(request.afterRevision, isNull);
    });

    test('declares the fail-closed rejection reasons', () {
      expect(MapRevisionRejectReason.values, [
        MapRevisionRejectReason.noCurrentRevision,
        MapRevisionRejectReason.sourceMismatch,
        MapRevisionRejectReason.staleRevision,
        MapRevisionRejectReason.conflictingRevision,
        MapRevisionRejectReason.contentDigestMismatch,
        MapRevisionRejectReason.revisionGap,
        MapRevisionRejectReason.revisionBranch,
      ]);
    });

    test(
      'keeps the generic apply result sealed behind its later factories',
      () {
        const MapRevisionApplyResult<String>? result = null;

        expect(result, isNull);
      },
    );

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
