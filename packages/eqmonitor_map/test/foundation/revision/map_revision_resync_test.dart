import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_commit_store.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final source = createMapSourceInstanceId(value: 'source-a');

  group('MapRevisionCommitStore resync latch', () {
    test('latches a source request when no current revision exists', () {
      final store = MapRevisionCommitStore<int>(_IntStateOwner());
      var builderCalled = false;

      final result = _commitDelta(
        store: store,
        source: source,
        baseRevision: 0,
        targetRevision: 1,
        build: ({required currentState}) {
          builderCalled = true;
          return _candidate(revision: 1);
        },
      );

      expect(builderCalled, isFalse);
      expect(result.reason, MapRevisionRejectReason.noCurrentRevision);
      expect(result.fullResyncRequest, same(store.fullResyncRequest));
      expect(store.fullResyncRequest?.source, source);
      expect(store.fullResyncRequest?.afterRevision, isNull);
      expect(store.needsFullResync, isTrue);
      expect(store.resyncAfterRevision, isNull);
    });
  });
}

MapRevisionApplyResult<int> _commitFull({
  required MapRevisionCommitStore<int> store,
  required MapSourceInstanceId source,
  required int revision,
}) => store.commitFull(
  metadata: createMapFullRevision(
    source: source,
    revision: revision,
    digest: createMapContentDigest(value: '$revision'),
  ),
  validateAndBuild: () => _candidate(revision: revision),
);

MapRevisionApplyResult<int> _commitDelta({
  required MapRevisionCommitStore<int> store,
  required MapSourceInstanceId source,
  required int baseRevision,
  required int targetRevision,
  MapRevisionCandidate<int> Function({required int currentState})? build,
}) => store.commitDelta(
  metadata: createMapDeltaRevision(
    source: source,
    baseRevision: baseRevision,
    targetRevision: targetRevision,
    targetDigest: createMapContentDigest(value: '$targetRevision'),
  ),
  validateAndBuild:
      build ??
      ({required currentState}) => _candidate(revision: targetRevision),
);

MapRevisionCandidate<int> _candidate({required int revision}) =>
    MapRevisionCandidate(
      state: revision,
      digest: createMapContentDigest(value: '$revision'),
    );

final class _IntStateOwner implements MapRevisionStateOwner<int> {
  @override
  MapRevisionCandidate<int> own({
    required MapRevisionCandidate<int> candidate,
  }) => candidate;
}
