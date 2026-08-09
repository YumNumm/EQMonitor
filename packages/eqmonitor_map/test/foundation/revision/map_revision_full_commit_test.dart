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
  _NestedStateOwner({this.onOwn, this.failWhen, this.rewriteDigest});

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
