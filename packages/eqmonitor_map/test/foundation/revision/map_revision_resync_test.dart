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

    test('latches current-scoped requests for gaps and branches', () {
      const cases = <({int base, MapRevisionRejectReason reason})>[
        (base: 5, reason: MapRevisionRejectReason.revisionGap),
        (base: 3, reason: MapRevisionRejectReason.revisionBranch),
      ];

      for (final testCase in cases) {
        final store = MapRevisionCommitStore<int>(_IntStateOwner());
        _commitFull(store: store, source: source, revision: 4);
        final before = store.current;
        final result = _commitDelta(
          store: store,
          source: source,
          baseRevision: testCase.base,
          targetRevision: 6,
        );

        expect(result.reason, testCase.reason);
        expect(result.current, same(before));
        expect(result.fullResyncRequest, same(store.fullResyncRequest));
        expect(store.fullResyncRequest?.source, source);
        expect(store.resyncAfterRevision, 4);
      }
    });

    test('isolates another source with and without an existing latch', () {
      final otherSource = createMapSourceInstanceId(value: 'source-b');
      final store = MapRevisionCommitStore<int>(_IntStateOwner());
      _commitFull(store: store, source: source, revision: 4);
      final current = store.current;
      var builderCalls = 0;

      final withoutLatch = _commitDelta(
        store: store,
        source: otherSource,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          builderCalls++;
          return _candidate(revision: 5);
        },
      );
      expect(withoutLatch.reason, MapRevisionRejectReason.sourceMismatch);
      expect(withoutLatch.fullResyncRequest, isNull);
      expect(store.current, same(current));

      _commitDelta(
        store: store,
        source: source,
        baseRevision: 5,
        targetRevision: 6,
      );
      final latch = store.fullResyncRequest;
      final withLatch = _commitDelta(
        store: store,
        source: otherSource,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          builderCalls++;
          return _candidate(revision: 5);
        },
      );

      expect(builderCalls, 0);
      expect(withLatch.reason, MapRevisionRejectReason.sourceMismatch);
      expect(withLatch.fullResyncRequest, same(latch));
      expect(store.fullResyncRequest, same(latch));
      expect(store.current, same(current));
    });

    test('only a newer valid full clears the latch before later deltas', () {
      final store = MapRevisionCommitStore<int>(_IntStateOwner());
      _commitFull(store: store, source: source, revision: 4);
      _commitDelta(
        store: store,
        source: source,
        baseRevision: 5,
        targetRevision: 6,
      );
      final latch = store.fullResyncRequest;
      final current = store.current;

      final failed = store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 6,
          digest: createMapContentDigest(value: '6'),
        ),
        validateAndBuild: () => _candidate(revision: 5),
      );
      expect(failed.reason, MapRevisionRejectReason.contentDigestMismatch);
      expect(failed.fullResyncRequest, same(latch));
      expect(store.fullResyncRequest, same(latch));
      expect(store.current, same(current));

      final equal = _commitFull(
        store: store,
        source: source,
        revision: 4,
      );
      expect(equal.kind, MapRevisionApplyResultKind.idempotentNoOp);
      expect(equal.fullResyncRequest, same(latch));
      expect(store.fullResyncRequest, same(latch));

      final newer = _commitFull(
        store: store,
        source: source,
        revision: 6,
      );
      expect(newer.kind, MapRevisionApplyResultKind.committed);
      expect(store.needsFullResync, isFalse);
      expect(store.fullResyncRequest, isNull);

      final delta = _commitDelta(
        store: store,
        source: source,
        baseRevision: 6,
        targetRevision: 7,
      );
      expect(delta.kind, MapRevisionApplyResultKind.committed);
      expect(store.current?.revision, 7);
      expect(store.fullResyncRequest, isNull);
    });

    test('stops active-source deltas after direct or reentrant latching', () {
      final store = MapRevisionCommitStore<int>(_IntStateOwner());
      _commitFull(store: store, source: source, revision: 4);
      _commitDelta(
        store: store,
        source: source,
        baseRevision: 5,
        targetRevision: 6,
      );
      final latch = store.fullResyncRequest;
      var builderCalled = false;

      final stopped = _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          builderCalled = true;
          return _candidate(revision: 5);
        },
      );
      expect(builderCalled, isFalse);
      expect(stopped.reason, MapRevisionRejectReason.revisionGap);
      expect(stopped.fullResyncRequest, same(latch));
      expect(store.current?.revision, 4);

      final reentrantStore = MapRevisionCommitStore<int>(_IntStateOwner());
      _commitFull(store: reentrantStore, source: source, revision: 4);
      final reentrant = _commitDelta(
        store: reentrantStore,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          _commitDelta(
            store: reentrantStore,
            source: source,
            baseRevision: 6,
            targetRevision: 7,
          );
          return _candidate(revision: 5);
        },
      );
      expect(reentrant.reason, MapRevisionRejectReason.revisionGap);
      expect(
        reentrant.fullResyncRequest,
        same(reentrantStore.fullResyncRequest),
      );
      expect(reentrantStore.current?.revision, 4);
      expect(reentrantStore.resyncAfterRevision, 4);
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
