import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_commit_store.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

typedef _NestedState = Map<String, List<int>>;

void main() {
  final source = createMapSourceInstanceId(value: 'jma-tiles');

  group('MapRevisionCommitStore.commitFull', () {
    test('commits the first revision only after builder and owner succeed', () {
      final calls = <String>[];
      late final MapRevisionCommitStore<_NestedState> store;
      final owner = _NestedStateOwner(
        onOwn: () {
          calls.add('owner');
          expect(store.current, isNull);
        },
      );
      store = MapRevisionCommitStore(owner);

      final result = store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 4,
          digest: createMapContentDigest(value: 'sha256:four'),
        ),
        validateAndBuild: () {
          calls.add('builder');
          return _candidate(digest: 'sha256:four', values: <int>[4]);
        },
      );

      expect(calls, <String>['builder', 'owner']);
      expect(result.kind, MapRevisionApplyResultKind.committed);
      expect(result.current, same(store.current));
      expect(result.current?.revision, 4);
      expect(result.current?.state['values'], <int>[4]);
    });

    test('commits a newer full revision for the active source', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');

      final result = _commit(
        store: store,
        source: source,
        revision: 5,
        digest: 'five',
      );

      expect(result.kind, MapRevisionApplyResultKind.committed);
      expect(store.current?.revision, 5);
      expect(store.current?.digest.value, 'five');
      expect(owner.callCount, 2);
    });

    test('rejects stale metadata after running only the builder', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;
      var builderCalls = 0;

      final result = store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 3,
          digest: createMapContentDigest(value: 'three'),
        ),
        validateAndBuild: () {
          builderCalls++;
          return _candidate(digest: 'three', values: <int>[3]);
        },
      );

      expect(builderCalls, 1);
      expect(owner.callCount, 1);
      expect(result.reason, MapRevisionRejectReason.staleRevision);
      expect(store.current, same(before));
    });

    test('treats an equal revision with the same digest as idempotent', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;
      var builderCalls = 0;

      final result = store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 4,
          digest: createMapContentDigest(value: 'four'),
        ),
        validateAndBuild: () {
          builderCalls++;
          return _candidate(digest: 'four', values: <int>[99]);
        },
      );

      expect(builderCalls, 1);
      expect(owner.callCount, 1);
      expect(result.kind, MapRevisionApplyResultKind.idempotentNoOp);
      expect(store.current, same(before));
    });

    test('rejects an equal revision carrying a conflicting digest', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;

      final result = _commit(
        store: store,
        source: source,
        revision: 4,
        digest: 'conflict',
      );

      expect(owner.callCount, 1);
      expect(result.reason, MapRevisionRejectReason.conflictingRevision);
      expect(store.current, same(before));
    });

    test('checks the candidate digest before stale revision rejection', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;

      final result = store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 3,
          digest: createMapContentDigest(value: 'three'),
        ),
        validateAndBuild: () => _candidate(digest: 'wrong', values: <int>[3]),
      );

      expect(owner.callCount, 1);
      expect(result.reason, MapRevisionRejectReason.contentDigestMismatch);
      expect(store.current, same(before));
    });

    test('rejects a digest changed by the state owner', () {
      var changeOwnedDigest = false;
      final owner = _NestedStateOwner(
        rewriteDigest: (digest) => changeOwnedDigest
            ? createMapContentDigest(value: 'changed-by-owner')
            : digest,
      );
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;
      changeOwnedDigest = true;

      final result = _commit(
        store: store,
        source: source,
        revision: 5,
        digest: 'five',
      );

      expect(result.reason, MapRevisionRejectReason.contentDigestMismatch);
      expect(result.current, same(before));
      expect(store.current, same(before));
    });

    test('preserves current when the builder throws', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;

      expect(
        () => store.commitFull(
          metadata: createMapFullRevision(
            source: source,
            revision: 5,
            digest: createMapContentDigest(value: 'five'),
          ),
          validateAndBuild: () => throw StateError('builder failed'),
        ),
        throwsStateError,
      );
      expect(owner.callCount, 1);
      expect(store.current, same(before));
    });

    test('preserves current when ownership throws', () {
      var failOwner = false;
      final owner = _NestedStateOwner(failWhen: () => failOwner);
      final store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      final before = store.current;
      failOwner = true;

      expect(
        () => _commit(
          store: store,
          source: source,
          revision: 5,
          digest: 'five',
        ),
        throwsStateError,
      );
      expect(owner.callCount, 2);
      expect(store.current, same(before));
    });

    test('does not overwrite a newer revision committed during ownership', () {
      var commitNestedRevision = false;
      var isNestedCommit = false;
      late final MapRevisionCommitStore<_NestedState> store;
      final owner = _NestedStateOwner(
        onOwn: () {
          if (!commitNestedRevision || isNestedCommit) {
            return;
          }
          isNestedCommit = true;
          final nestedResult = _commit(
            store: store,
            source: source,
            revision: 6,
            digest: 'six',
          );
          expect(nestedResult.kind, MapRevisionApplyResultKind.committed);
          isNestedCommit = false;
        },
      );
      store = MapRevisionCommitStore(owner);
      _commit(store: store, source: source, revision: 4, digest: 'four');
      commitNestedRevision = true;

      final result = _commit(
        store: store,
        source: source,
        revision: 5,
        digest: 'five',
      );

      expect(result.reason, MapRevisionRejectReason.staleRevision);
      expect(result.current, same(store.current));
      expect(store.current?.revision, 6);
      expect(store.current?.digest.value, 'six');
      expect(store.current?.state['values'], <int>[6]);
    });

    test('stores the deep-owned candidate without mutable aliases', () {
      final owner = _NestedStateOwner();
      final store = MapRevisionCommitStore(owner);
      final nestedValues = <int>[4];
      final mutableState = <String, List<int>>{'values': nestedValues};

      store.commitFull(
        metadata: createMapFullRevision(
          source: source,
          revision: 4,
          digest: createMapContentDigest(value: 'four'),
        ),
        validateAndBuild: () => MapRevisionCandidate(
          state: mutableState,
          digest: createMapContentDigest(value: 'four'),
        ),
      );
      mutableState['other'] = <int>[5];
      nestedValues.add(6);

      expect(store.current?.state, <String, List<int>>{
        'values': <int>[4],
      });
      expect(
        () => store.current?.state['other'] = <int>[5],
        throwsUnsupportedError,
      );
      expect(
        () => store.current?.state['values']?.add(6),
        throwsUnsupportedError,
      );
    });
  });
}

MapRevisionApplyResult<_NestedState> _commit({
  required MapRevisionCommitStore<_NestedState> store,
  required MapSourceInstanceId source,
  required int revision,
  required String digest,
}) => store.commitFull(
  metadata: createMapFullRevision(
    source: source,
    revision: revision,
    digest: createMapContentDigest(value: digest),
  ),
  validateAndBuild: () => _candidate(digest: digest, values: <int>[revision]),
);

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
