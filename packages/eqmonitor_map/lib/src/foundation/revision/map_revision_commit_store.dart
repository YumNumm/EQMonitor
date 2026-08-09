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
    if (owned.digest != candidate.digest || owned.digest != metadata.digest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
      );
    }
    if (!identical(_current, currentValue)) {
      return _rejectChangedFullRevision(
        metadata: metadata,
        current: _current,
      );
    }
    final committed = createMapCommittedRevision(
      source: metadata.source,
      revision: metadata.revision,
      digest: owned.digest,
      state: owned.state,
    );
    _current = committed;
    return MapRevisionApplyResult.committed(current: committed);
  }

  MapRevisionApplyResult<TState> commitDelta({
    required MapDeltaRevision metadata,
    required MapRevisionCandidate<TState> Function({
      required TState currentState,
    })
    validateAndBuild,
  }) {
    final currentValue = _current;
    if (currentValue == null) {
      return MapRevisionApplyResult.rejected(
        current: null,
        reason: MapRevisionRejectReason.noCurrentRevision,
      );
    }
    if (currentValue.source != metadata.source) {
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: MapRevisionRejectReason.sourceMismatch,
      );
    }
    final revisionReason = _deltaRevisionRejectReason(
      metadata: metadata,
      current: currentValue,
    );
    if (revisionReason != null) {
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: revisionReason,
      );
    }
    final candidate = validateAndBuild(currentState: currentValue.state);
    if (candidate.digest != metadata.targetDigest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
      );
    }
    if (!identical(_current, currentValue)) {
      return _rejectChangedDeltaRevision(
        metadata: metadata,
        current: _current,
      );
    }
    final owned = _owner.own(candidate: candidate);
    if (owned.digest != candidate.digest ||
        owned.digest != metadata.targetDigest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
      );
    }
    if (!identical(_current, currentValue)) {
      return _rejectChangedDeltaRevision(
        metadata: metadata,
        current: _current,
      );
    }
    final committed = createMapCommittedRevision(
      source: metadata.source,
      revision: metadata.targetRevision,
      digest: owned.digest,
      state: owned.state,
    );
    _current = committed;
    return MapRevisionApplyResult.committed(current: committed);
  }
}

MapRevisionRejectReason? _deltaRevisionRejectReason<TState>({
  required MapDeltaRevision metadata,
  required MapCommittedRevision<TState> current,
}) {
  if (metadata.targetRevision <= current.revision) {
    return MapRevisionRejectReason.staleRevision;
  }
  if (metadata.baseRevision > current.revision) {
    return MapRevisionRejectReason.revisionGap;
  }
  if (metadata.baseRevision < current.revision) {
    return MapRevisionRejectReason.revisionBranch;
  }
  return null;
}

MapRevisionApplyResult<TState> _rejectChangedDeltaRevision<TState>({
  required MapDeltaRevision metadata,
  required MapCommittedRevision<TState>? current,
}) {
  final reason = current == null
      ? MapRevisionRejectReason.noCurrentRevision
      : current.source != metadata.source
      ? MapRevisionRejectReason.sourceMismatch
      : _deltaRevisionRejectReason(metadata: metadata, current: current) ??
            MapRevisionRejectReason.revisionBranch;
  return MapRevisionApplyResult.rejected(
    current: current,
    reason: reason,
  );
}

MapRevisionApplyResult<TState> _rejectChangedFullRevision<TState>({
  required MapFullRevision metadata,
  required MapCommittedRevision<TState>? current,
}) {
  if (current == null) {
    return MapRevisionApplyResult.rejected(
      current: null,
      reason: MapRevisionRejectReason.noCurrentRevision,
    );
  }
  if (current.source != metadata.source) {
    return MapRevisionApplyResult.rejected(
      current: current,
      reason: MapRevisionRejectReason.sourceMismatch,
    );
  }
  if (metadata.revision < current.revision) {
    return MapRevisionApplyResult.rejected(
      current: current,
      reason: MapRevisionRejectReason.staleRevision,
    );
  }
  if (metadata.revision == current.revision) {
    return metadata.digest == current.digest
        ? MapRevisionApplyResult.idempotentNoOp(current: current)
        : MapRevisionApplyResult.rejected(
            current: current,
            reason: MapRevisionRejectReason.conflictingRevision,
          );
  }
  return MapRevisionApplyResult.rejected(
    current: current,
    reason: MapRevisionRejectReason.revisionBranch,
  );
}
