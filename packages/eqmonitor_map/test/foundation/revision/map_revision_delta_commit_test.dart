import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_commit_store.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

typedef _NestedState = Map<String, List<int>>;

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');

  group('MapRevisionCommitStore.commitDelta', () {
    test('commits revision 4 to 5 from the exact owned current state', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;

      final result = store.commitDelta(
        metadata: createMapDeltaRevision(
          source: source,
          baseRevision: 4,
          targetRevision: 5,
          targetDigest: createMapContentDigest(value: 'five'),
        ),
        validateAndBuild: ({required currentState}) {
          expect(currentState, same(before?.state));
          return _candidate(digest: 'five', values: <int>[4, 5]);
        },
      );

      expect(result.kind, MapRevisionApplyResultKind.committed);
      expect(result.current, same(store.current));
      expect(result.current?.revision, 5);
      expect(result.current?.digest.value, 'five');
      expect(result.current?.state['values'], <int>[4, 5]);
      expect(owner.callCount, 2);
    });

    test('rejects a candidate carrying the wrong target digest', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;

      final result = _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
        digest: 'five',
        build: ({required currentState}) =>
            _candidate(digest: 'wrong', values: <int>[4, 5]),
      );

      expect(result.reason, MapRevisionRejectReason.contentDigestMismatch);
      expect(result.current, same(before));
      expect(store.current, same(before));
      expect(owner.callCount, 1);
    });

    test('rejects every non-exact base before running the builder', () {
      const cases = <({int base, int target, MapRevisionRejectReason reason})>[
        (base: 3, target: 4, reason: MapRevisionRejectReason.staleRevision),
        (base: 3, target: 5, reason: MapRevisionRejectReason.revisionBranch),
        (base: 5, target: 6, reason: MapRevisionRejectReason.revisionGap),
      ];

      for (final testCase in cases) {
        final owner = _NestedStateOwner();
        final store = MapRevisionCommitStore(owner);
        _commitFull(store: store, source: source, revision: 4);
        final before = store.current;
        var builderCalled = false;

        final result = _commitDelta(
          store: store,
          source: source,
          baseRevision: testCase.base,
          targetRevision: testCase.target,
          build: ({required currentState}) {
            builderCalled = true;
            return _candidate(digest: 'unused', values: <int>[]);
          },
        );

        expect(builderCalled, isFalse);
        expect(result.reason, testCase.reason);
        expect(store.current, same(before));
        expect(owner.callCount, 1);
      }
    });

    test('rejects another source before running the builder', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;
      var builderCalled = false;

      final result = _commitDelta(
        store: store,
        source: createMapSourceInstanceId(value: 'another-source'),
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          builderCalled = true;
          return _candidate(digest: 'five', values: <int>[4, 5]);
        },
      );

      expect(builderCalled, isFalse);
      expect(result.reason, MapRevisionRejectReason.sourceMismatch);
      expect(store.current, same(before));
      expect(owner.callCount, 1);
    });

    test('preserves current when the builder throws', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;

      expect(
        () => _commitDelta(
          store: store,
          source: source,
          baseRevision: 4,
          targetRevision: 5,
          build: ({required currentState}) =>
              throw StateError('builder failed'),
        ),
        throwsStateError,
      );
      expect(store.current, same(before));
      expect(owner.callCount, 1);
    });

    test('preserves current when the owner throws', () {
      var failOwner = false;
      final owner = _NestedStateOwner(failWhen: () => failOwner);
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;
      failOwner = true;

      expect(
        () => _commitDelta(
          store: store,
          source: source,
          baseRevision: 4,
          targetRevision: 5,
        ),
        throwsStateError,
      );
      expect(store.current, same(before));
      expect(owner.callCount, 2);
    });
  });
}

MapRevisionApplyResult<_NestedState> _commitDelta({
  required MapRevisionCommitStore<_NestedState> store,
  required MapSourceInstanceId source,
  required int baseRevision,
  required int targetRevision,
  String? digest,
  MapRevisionCandidate<_NestedState> Function({
    required _NestedState currentState,
  })?
  build,
}) => store.commitDelta(
  metadata: createMapDeltaRevision(
    source: source,
    baseRevision: baseRevision,
    targetRevision: targetRevision,
    targetDigest: createMapContentDigest(value: digest ?? 'five'),
  ),
  validateAndBuild:
      build ??
      ({required currentState}) =>
          _candidate(digest: digest ?? 'five', values: <int>[4, 5]),
);

void _commitFull({
  required MapRevisionCommitStore<_NestedState> store,
  required MapSourceInstanceId source,
  required int revision,
}) {
  final digest = switch (revision) {
    4 => 'four',
    6 => 'six',
    _ => '$revision',
  };
  store.commitFull(
    metadata: createMapFullRevision(
      source: source,
      revision: revision,
      digest: createMapContentDigest(value: digest),
    ),
    validateAndBuild: () => _candidate(digest: digest, values: <int>[revision]),
  );
}

MapRevisionCandidate<_NestedState> _candidate({
  required String digest,
  required List<int> values,
}) => MapRevisionCandidate(
  state: <String, List<int>>{'values': values},
  digest: createMapContentDigest(value: digest),
);

final class _NestedStateOwner implements MapRevisionStateOwner<_NestedState> {
  _NestedStateOwner({this.failWhen});

  final bool Function()? failWhen;
  var _callCount = 0;

  int get callCount => _callCount;

  @override
  MapRevisionCandidate<_NestedState> own({
    required MapRevisionCandidate<_NestedState> candidate,
  }) {
    _callCount++;
    if (failWhen?.call() ?? false) {
      throw StateError('owner failed');
    }
    return MapRevisionCandidate(
      state: Map<String, List<int>>.unmodifiable({
        for (final entry in candidate.state.entries)
          entry.key: List<int>.unmodifiable(entry.value),
      }),
      digest: candidate.digest,
    );
  }
}
