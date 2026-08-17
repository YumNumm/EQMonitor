import 'package:eqmonitor_map/src/foundation/revision/map_revision.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_revision_state_owner.dart';

final class MapRevisionCommitStore<TState> {
  new(this._owner);

  final MapRevisionStateOwner<TState> _owner;
  MapCommittedRevision<TState>? _current;
  MapFullResyncRequest? _fullResyncRequest;

  MapCommittedRevision<TState>? get current => _current;
  MapFullResyncRequest? get fullResyncRequest => _fullResyncRequest;
  bool get needsFullResync => _fullResyncRequest != null;
  int? get resyncAfterRevision => _fullResyncRequest?.afterRevision;

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
        fullResyncRequest: _fullResyncRequest,
      );
    }

    if (currentValue != null && currentValue.source == metadata.source) {
      if (metadata.revision < currentValue.revision) {
        return MapRevisionApplyResult.rejected(
          current: currentValue,
          reason: MapRevisionRejectReason.staleRevision,
          fullResyncRequest: _fullResyncRequest,
        );
      }
      if (metadata.revision == currentValue.revision) {
        if (metadata.digest == currentValue.digest) {
          return MapRevisionApplyResult.idempotentNoOp(
            current: currentValue,
            fullResyncRequest: _fullResyncRequest,
          );
        }
        return MapRevisionApplyResult.rejected(
          current: currentValue,
          reason: MapRevisionRejectReason.conflictingRevision,
          fullResyncRequest: _fullResyncRequest,
        );
      }
    }

    final owned = _owner.own(candidate: candidate);
    if (owned.digest != candidate.digest || owned.digest != metadata.digest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    if (!identical(_current, currentValue)) {
      return _rejectChangedFullRevision(
        metadata: metadata,
        current: _current,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    final committed = createMapCommittedRevision(
      source: metadata.source,
      revision: metadata.revision,
      digest: owned.digest,
      state: owned.state,
    );
    _current = committed;
    _fullResyncRequest = null;
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
    final latchValue = _fullResyncRequest;
    if (currentValue == null) {
      final request =
          latchValue ??
          createMapFullResyncRequest(
            source: metadata.source,
            afterRevision: null,
          );
      _fullResyncRequest ??= request;
      return MapRevisionApplyResult.rejected(
        current: null,
        reason: MapRevisionRejectReason.noCurrentRevision,
        fullResyncRequest: request,
      );
    }
    if (currentValue.source != metadata.source) {
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: MapRevisionRejectReason.sourceMismatch,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    if (latchValue != null) {
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: MapRevisionRejectReason.revisionGap,
        fullResyncRequest: latchValue,
      );
    }
    final revisionReason = _deltaRevisionRejectReason(
      metadata: metadata,
      current: currentValue,
    );
    if (revisionReason != null) {
      final request = switch (revisionReason) {
        MapRevisionRejectReason.revisionGap ||
        MapRevisionRejectReason.revisionBranch => createMapFullResyncRequest(
          source: currentValue.source,
          afterRevision: currentValue.revision,
        ),
        _ => _fullResyncRequest,
      };
      _fullResyncRequest = request;
      return MapRevisionApplyResult.rejected(
        current: currentValue,
        reason: revisionReason,
        fullResyncRequest: request,
      );
    }
    final candidate = validateAndBuild(currentState: currentValue.state);
    if (candidate.digest != metadata.targetDigest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    if (!identical(_current, currentValue) ||
        !identical(_fullResyncRequest, latchValue)) {
      return _rejectChangedDeltaRevision(
        metadata: metadata,
        current: _current,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    final owned = _owner.own(candidate: candidate);
    if (owned.digest != candidate.digest ||
        owned.digest != metadata.targetDigest) {
      return MapRevisionApplyResult.rejected(
        current: _current,
        reason: MapRevisionRejectReason.contentDigestMismatch,
        fullResyncRequest: _fullResyncRequest,
      );
    }
    if (!identical(_current, currentValue) ||
        !identical(_fullResyncRequest, latchValue)) {
      return _rejectChangedDeltaRevision(
        metadata: metadata,
        current: _current,
        fullResyncRequest: _fullResyncRequest,
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
  required MapFullResyncRequest? fullResyncRequest,
}) {
  final reason = current == null
      ? MapRevisionRejectReason.noCurrentRevision
      : current.source != metadata.source
      ? MapRevisionRejectReason.sourceMismatch
      : fullResyncRequest != null
      ? MapRevisionRejectReason.revisionGap
      : _deltaRevisionRejectReason(metadata: metadata, current: current) ??
            MapRevisionRejectReason.revisionBranch;
  return MapRevisionApplyResult.rejected(
    current: current,
    reason: reason,
    fullResyncRequest: fullResyncRequest,
  );
}

MapRevisionApplyResult<TState> _rejectChangedFullRevision<TState>({
  required MapFullRevision metadata,
  required MapCommittedRevision<TState>? current,
  required MapFullResyncRequest? fullResyncRequest,
}) {
  if (current == null) {
    return MapRevisionApplyResult.rejected(
      current: null,
      reason: MapRevisionRejectReason.noCurrentRevision,
      fullResyncRequest: fullResyncRequest,
    );
  }
  if (current.source != metadata.source) {
    return MapRevisionApplyResult.rejected(
      current: current,
      reason: MapRevisionRejectReason.sourceMismatch,
      fullResyncRequest: fullResyncRequest,
    );
  }
  if (metadata.revision < current.revision) {
    return MapRevisionApplyResult.rejected(
      current: current,
      reason: MapRevisionRejectReason.staleRevision,
      fullResyncRequest: fullResyncRequest,
    );
  }
  if (metadata.revision == current.revision) {
    return metadata.digest == current.digest
        ? MapRevisionApplyResult.idempotentNoOp(
            current: current,
            fullResyncRequest: fullResyncRequest,
          )
        : MapRevisionApplyResult.rejected(
            current: current,
            reason: MapRevisionRejectReason.conflictingRevision,
            fullResyncRequest: fullResyncRequest,
          );
  }
  return MapRevisionApplyResult.rejected(
    current: current,
    reason: MapRevisionRejectReason.revisionBranch,
    fullResyncRequest: fullResyncRequest,
  );
}
