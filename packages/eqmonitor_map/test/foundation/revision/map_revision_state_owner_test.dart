import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapRevisionStateOwner', () {
    test('deep-owns mutable outer maps and nested lists', () {
      final nestedValues = <int>[1, 2];
      final mutableState = <String, List<int>>{'values': nestedValues};
      final candidate = MapRevisionCandidate(
        state: mutableState,
        digest: createMapContentDigest(value: 'sha256:initial'),
      );
      const owner = _NestedCollectionStateOwner();

      final owned = owner.own(candidate: candidate);
      mutableState['other'] = <int>[3];
      nestedValues.add(4);

      expect(owned.digest, candidate.digest);
      expect(owned.state, <String, List<int>>{
        'values': <int>[1, 2],
      });
      expect(
        () => owned.state['other'] = <int>[3],
        throwsUnsupportedError,
      );
      expect(
        () => owned.state.entries.single.value.add(4),
        throwsUnsupportedError,
      );
    });
  });
}

final class _NestedCollectionStateOwner
    implements MapRevisionStateOwner<Map<String, List<int>>> {
  const _NestedCollectionStateOwner();

  @override
  MapRevisionCandidate<Map<String, List<int>>> own({
    required MapRevisionCandidate<Map<String, List<int>>> candidate,
  }) {
    final ownedState = Map<String, List<int>>.unmodifiable({
      for (final entry in candidate.state.entries)
        entry.key: List<int>.unmodifiable(entry.value),
    });
    return MapRevisionCandidate(state: ownedState, digest: candidate.digest);
  }
}
