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

    test('rejects a digest changed by the state owner', () {
      var changeDigest = false;
      final owner = _NestedStateOwner(
        rewriteDigest: (digest) => changeDigest
            ? createMapContentDigest(value: 'owner-rewrite')
            : digest,
      );
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final before = store.current;
      changeDigest = true;

      final result = _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
      );

      expect(result.reason, MapRevisionRejectReason.contentDigestMismatch);
      expect(store.current, same(before));
    });

    test('does not overwrite a newer commit made during ownership', () {
      var commitNestedRevision = false;
      var isNestedCommit = false;
      late final MapRevisionCommitStore<_NestedState> store;
      final owner = _NestedStateOwner(
        onOwn: () {
          if (!commitNestedRevision || isNestedCommit) {
            return;
          }
          isNestedCommit = true;
          _commitFull(store: store, source: source, revision: 6);
          isNestedCommit = false;
        },
      );
      store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      commitNestedRevision = true;

      final result = _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
      );

      expect(result.reason, MapRevisionRejectReason.staleRevision);
      expect(store.current?.revision, 6);
      expect(store.current?.state['values'], <int>[6]);
    });

    test('does not call the owner after a newer commit during the builder', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      MapCommittedRevision<_NestedState>? nestedCurrent;

      final result = _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) {
          _commitFull(store: store, source: source, revision: 6);
          nestedCurrent = store.current;
          return _candidate(digest: 'five', values: <int>[4, 5]);
        },
      );

      expect(result.reason, MapRevisionRejectReason.staleRevision);
      expect(result.current, same(nestedCurrent));
      expect(store.current, same(nestedCurrent));
      expect(nestedCurrent?.revision, 6);
      expect(nestedCurrent?.digest.value, 'six');
      expect(result.current?.state, same(nestedCurrent?.state));
      expect(result.current?.state['values'], <int>[6]);
      expect(store.current?.revision, 6);
      expect(store.current?.state['values'], <int>[6]);
      expect(owner.callCount, 2);
    });

    test('stores the returned candidate without nested mutable aliases', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commitFull(store: store, source: source, revision: 4);
      final nestedValues = <int>[4, 5];
      final mutableState = <String, List<int>>{'values': nestedValues};

      _commitDelta(
        store: store,
        source: source,
        baseRevision: 4,
        targetRevision: 5,
        build: ({required currentState}) => MapRevisionCandidate(
          state: mutableState,
          digest: createMapContentDigest(value: 'five'),
        ),
      );
      mutableState['other'] = <int>[6];
      nestedValues.add(7);

      expect(store.current?.state, <String, List<int>>{
        'values': <int>[4, 5],
      });
      expect(
        () => store.current?.state['values']?.add(7),
        throwsUnsupportedError,
      );
      expect(
        () => store.current?.state['other'] = <int>[6],
        throwsUnsupportedError,
      );
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
  new({this.onOwn, this.failWhen, this.rewriteDigest});

  final void Function()? onOwn;
  final bool Function()? failWhen;
  final MapContentDigest Function(MapContentDigest)? rewriteDigest;
  var _callCount = 0;

  int get callCount => _callCount;

  @override
  MapRevisionCandidate<_NestedState> own({
    required MapRevisionCandidate<_NestedState> candidate,
  }) {
    _callCount++;
    onOwn?.call();
    if (failWhen?.call() ?? false) {
      throw StateError('owner failed');
    }
    return MapRevisionCandidate(
      state: Map<String, List<int>>.unmodifiable({
        for (final entry in candidate.state.entries)
          entry.key: List<int>.unmodifiable(entry.value),
      }),
      digest: rewriteDigest?.call(candidate.digest) ?? candidate.digest,
    );
  }
}
