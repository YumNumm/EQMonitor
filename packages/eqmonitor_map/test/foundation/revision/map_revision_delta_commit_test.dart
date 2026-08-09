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
  });
}

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
  var _callCount = 0;

  int get callCount => _callCount;

  @override
  MapRevisionCandidate<_NestedState> own({
    required MapRevisionCandidate<_NestedState> candidate,
  }) {
    _callCount++;
    return MapRevisionCandidate(
      state: Map<String, List<int>>.unmodifiable({
        for (final entry in candidate.state.entries)
          entry.key: List<int>.unmodifiable(entry.value),
      }),
      digest: candidate.digest,
    );
  }
}
