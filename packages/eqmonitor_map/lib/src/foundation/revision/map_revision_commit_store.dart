import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';

final class MapRevisionCommitStore<TState> {
  MapRevisionCommitStore(this._owner);

  final MapRevisionStateOwner<TState> _owner;
  MapCommittedRevision<TState>? _current;

  MapCommittedRevision<TState>? get current => _current;

  MapRevisionApplyResult<TState> commitFull({
    required MapFullRevision metadata,
    required MapRevisionCandidate<TState> Function() validateAndBuild,
  }) {
    final candidate = validateAndBuild();
    final currentValue = _current;

    if (candidate.digest != metadata.digest) {
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: MapRevisionRejectReason.contentDigestMismatch,
      );
    }

    if (currentValue != null && currentValue.source == metadata.source) {
      if (metadata.revision < currentValue.revision) {
        return MapRevisionApplyResult.rejected(
          current: currentValue,
          reason: MapRevisionRejectReason.staleRevision,
        );
      }
      if (metadata.revision == currentValue.revision) {
        if (metadata.digest == currentValue.digest) {
          return MapRevisionApplyResult.idempotentNoOp(
            current: currentValue,
          );
        }
        return MapRevisionApplyResult.rejected(
          current: currentValue,
          reason: MapRevisionRejectReason.conflictingRevision,
        );
      }
    }

    final owned = _owner.own(candidate: candidate);
    final committed = createMapCommittedRevision(
      source: metadata.source,
      revision: metadata.revision,
      digest: owned.digest,
      state: owned.state,
    );
    _current = committed;
    return MapRevisionApplyResult.committed(current: committed);
  }
}
