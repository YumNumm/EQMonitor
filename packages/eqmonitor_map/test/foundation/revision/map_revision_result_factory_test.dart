import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');
  final current = createMapCommittedRevision(
    source: source,
    revision: 8,
    digest: createMapContentDigest(value: 'sha256:committed'),
    state: 'complete-feature-set',
  );

  group('revision result factories', () {
    test('committed exposes only the committed current state', () {
      final result = MapRevisionApplyResult.committed(current: current);

      expect(result.current, current);
      expect(result.reason, isNull);
      expect(result.fullResyncRequest, isNull);
      expect(result.requiresFullResync, isFalse);
    });

    test('idempotent no-op retains an existing resync request', () {
      final request = createMapFullResyncRequest(
        source: source,
        afterRevision: 8,
      );
      final result = MapRevisionApplyResult.idempotentNoOp(
        current: current,
        fullResyncRequest: request,
      );
      final committed = MapRevisionApplyResult.committed(current: current);

      expect(result.current, current);
      expect(result.reason, isNull);
      expect(result.fullResyncRequest, request);
      expect(result.requiresFullResync, isTrue);
      expect(result, isNot(equals(committed)));
    });

    test('idempotent no-op rejects a request for another source', () {
      final otherSourceRequest = createMapFullResyncRequest(
        source: createMapSourceInstanceId(value: 'other-source'),
        afterRevision: 8,
      );

      expect(
        () => MapRevisionApplyResult.idempotentNoOp(
          current: current,
          fullResyncRequest: otherSourceRequest,
        ),
        throwsArgumentError,
      );
    });

    test('idempotent no-op rejects a request after another revision', () {
      final staleRequest = createMapFullResyncRequest(
        source: source,
        afterRevision: 7,
      );

      expect(
        () => MapRevisionApplyResult.idempotentNoOp(
          current: current,
          fullResyncRequest: staleRequest,
        ),
        throwsArgumentError,
      );
    });

    test('rejected retains nullable current and required typed reason', () {
      final result = MapRevisionApplyResult<String>.rejected(
        current: null,
        reason: MapRevisionRejectReason.noCurrentRevision,
      );

      expect(result.current, isNull);
      expect(result.reason, MapRevisionRejectReason.noCurrentRevision);
      expect(result.fullResyncRequest, isNull);
      expect(result.requiresFullResync, isFalse);
    });

    test('rejected derives full resync from the exact request', () {
      final request = createMapFullResyncRequest(
        source: source,
        afterRevision: 8,
      );
      final result = MapRevisionApplyResult.rejected(
        current: current,
        reason: MapRevisionRejectReason.revisionGap,
        fullResyncRequest: request,
      );

      expect(result.current, current);
      expect(result.reason, MapRevisionRejectReason.revisionGap);
      expect(result.fullResyncRequest, request);
      expect(result.requiresFullResync, isTrue);
    });

    test('rejected does not attach another source request to current', () {
      final otherSourceRequest = createMapFullResyncRequest(
        source: createMapSourceInstanceId(value: 'other-source'),
        afterRevision: 8,
      );

      expect(
        () => MapRevisionApplyResult.rejected(
          current: current,
          reason: MapRevisionRejectReason.sourceMismatch,
          fullResyncRequest: otherSourceRequest,
        ),
        throwsArgumentError,
      );
    });

    test('rejected without current accepts only a no-current request', () {
      final staleRequest = createMapFullResyncRequest(
        source: source,
        afterRevision: 8,
      );

      expect(
        () => MapRevisionApplyResult<String>.rejected(
          current: null,
          reason: MapRevisionRejectReason.noCurrentRevision,
          fullResyncRequest: staleRequest,
        ),
        throwsArgumentError,
      );
    });

    test('factory signatures exclude impossible field combinations', () {
      // The explicit function types are the compile-time API assertions.
      // ignore: omit_local_variable_types
      const MapRevisionApplyResult<String> Function({
        required MapCommittedRevision<String> current,
      })
      committedFactory = MapRevisionApplyResult<String>.committed;
      // The explicit type rejects extra idempotent factory parameters.
      // ignore: omit_local_variable_types
      const MapRevisionApplyResult<String> Function({
        required MapCommittedRevision<String> current,
        MapFullResyncRequest? fullResyncRequest,
      })
      idempotentFactory = MapRevisionApplyResult<String>.idempotentNoOp;
      // The explicit type requires a non-null reject reason.
      // ignore: omit_local_variable_types
      const MapRevisionApplyResult<String> Function({
        required MapCommittedRevision<String>? current,
        required MapRevisionRejectReason reason,
        MapFullResyncRequest? fullResyncRequest,
      })
      rejectedFactory = MapRevisionApplyResult<String>.rejected;

      expect(committedFactory(current: current).reason, isNull);
      expect(
        idempotentFactory(
          current: current,
        ).reason,
        isNull,
      );
      expect(
        rejectedFactory(
          current: null,
          reason: MapRevisionRejectReason.noCurrentRevision,
        ).reason,
        MapRevisionRejectReason.noCurrentRevision,
      );
    });

    test('exposes every result variant through an exhaustive public kind', () {
      final results = <MapRevisionApplyResult<String>>[
        MapRevisionApplyResult.committed(current: current),
        MapRevisionApplyResult.idempotentNoOp(current: current),
        MapRevisionApplyResult.rejected(
          current: current,
          reason: MapRevisionRejectReason.staleRevision,
        ),
      ];

      expect(MapRevisionApplyResultKind.values, [
        MapRevisionApplyResultKind.committed,
        MapRevisionApplyResultKind.idempotentNoOp,
        MapRevisionApplyResultKind.rejected,
      ]);
      expect(
        results.map((result) => result.kind),
        MapRevisionApplyResultKind.values,
      );
      expect(
        results.map(
          (result) => switch (result.kind) {
            MapRevisionApplyResultKind.committed => 'committed',
            MapRevisionApplyResultKind.idempotentNoOp => 'idempotentNoOp',
            MapRevisionApplyResultKind.rejected => 'rejected',
          },
        ),
        ['committed', 'idempotentNoOp', 'rejected'],
      );
    });
  });
}
