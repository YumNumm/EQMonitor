import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_revision.freezed.dart';

@Freezed(copyWith: false)
sealed class MapFullRevision with _$MapFullRevision {
  const factory MapFullRevision._({
    required MapSourceInstanceId source,
    required int revision,
    required MapContentDigest digest,
  }) = _MapFullRevision;
}

@Freezed(copyWith: false)
sealed class MapDeltaRevision with _$MapDeltaRevision {
  const factory MapDeltaRevision._({
    required MapSourceInstanceId source,
    required int baseRevision,
    required int targetRevision,
    required MapContentDigest targetDigest,
  }) = _MapDeltaRevision;
}

MapFullRevision createMapFullRevision({
  required MapSourceInstanceId source,
  required int revision,
  required MapContentDigest digest,
}) {
  if (revision.isNegative) {
    throw ArgumentError.value(revision, 'revision', 'must not be negative');
  }

  return MapFullRevision._(
    source: source,
    revision: revision,
    digest: digest,
  );
}

MapDeltaRevision createMapDeltaRevision({
  required MapSourceInstanceId source,
  required int baseRevision,
  required int targetRevision,
  required MapContentDigest targetDigest,
}) {
  if (baseRevision.isNegative) {
    throw ArgumentError.value(
      baseRevision,
      'baseRevision',
      'must not be negative',
    );
  }
  if (targetRevision.isNegative) {
    throw ArgumentError.value(
      targetRevision,
      'targetRevision',
      'must not be negative',
    );
  }
  if (targetRevision <= baseRevision) {
    throw ArgumentError.value(
      targetRevision,
      'targetRevision',
      'must be greater than baseRevision',
    );
  }

  return MapDeltaRevision._(
    source: source,
    baseRevision: baseRevision,
    targetRevision: targetRevision,
    targetDigest: targetDigest,
  );
}

@Freezed(copyWith: false)
sealed class MapCommittedRevision<TState> with _$MapCommittedRevision<TState> {
  const factory MapCommittedRevision._({
    required MapSourceInstanceId source,
    required int revision,
    required MapContentDigest digest,
    required TState state,
  }) = _MapCommittedRevision<TState>;
}

@Freezed(copyWith: false)
sealed class MapFullResyncRequest with _$MapFullResyncRequest {
  const factory MapFullResyncRequest._({
    required MapSourceInstanceId source,
    required int? afterRevision,
  }) = _MapFullResyncRequest;
}

enum MapRevisionRejectReason {
  noCurrentRevision,
  sourceMismatch,
  staleRevision,
  conflictingRevision,
  contentDigestMismatch,
  revisionGap,
  revisionBranch,
}

@Freezed(
  copyWith: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
)
sealed class MapRevisionApplyResult<TState>
    with _$MapRevisionApplyResult<TState> {
  factory MapRevisionApplyResult.committed({
    required MapCommittedRevision<TState> current,
  }) => MapRevisionApplyResult._committed(current: current);

  factory MapRevisionApplyResult.idempotentNoOp({
    required MapCommittedRevision<TState> current,
    MapFullResyncRequest? fullResyncRequest,
  }) {
    if (fullResyncRequest != null &&
        (fullResyncRequest.source != current.source ||
            fullResyncRequest.afterRevision != current.revision)) {
      throw ArgumentError.value(
        fullResyncRequest,
        'fullResyncRequest',
        'must match the current source and revision',
      );
    }

    return MapRevisionApplyResult._idempotentNoOp(
      current: current,
      fullResyncRequest: fullResyncRequest,
    );
  }

  factory MapRevisionApplyResult.rejected({
    required MapCommittedRevision<TState>? current,
    required MapRevisionRejectReason reason,
    MapFullResyncRequest? fullResyncRequest,
  }) {
    final requestDoesNotMatchCurrent =
        fullResyncRequest != null &&
        ((current == null && fullResyncRequest.afterRevision != null) ||
            (current != null &&
                (fullResyncRequest.source != current.source ||
                    fullResyncRequest.afterRevision != current.revision)));
    if (requestDoesNotMatchCurrent) {
      throw ArgumentError.value(
        fullResyncRequest,
        'fullResyncRequest',
        'must match the current source and revision',
      );
    }

    return MapRevisionApplyResult._rejected(
      current: current,
      reason: reason,
      fullResyncRequest: fullResyncRequest,
    );
  }

  const factory MapRevisionApplyResult._committed({
    required MapCommittedRevision<TState> current,
    MapRevisionRejectReason? reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultCommitted<TState>;

  const factory MapRevisionApplyResult._idempotentNoOp({
    required MapCommittedRevision<TState> current,
    MapRevisionRejectReason? reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultIdempotentNoOp<TState>;

  const factory MapRevisionApplyResult._rejected({
    required MapCommittedRevision<TState>? current,
    required MapRevisionRejectReason reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultRejected<TState>;
}

extension MapRevisionApplyResultResync<TState>
    on MapRevisionApplyResult<TState> {
  bool get requiresFullResync => fullResyncRequest != null;
}

MapCommittedRevision<TState> createMapCommittedRevision<TState>({
  required MapSourceInstanceId source,
  required int revision,
  required MapContentDigest digest,
  required TState state,
}) {
  if (revision.isNegative) {
    throw ArgumentError.value(revision, 'revision', 'must not be negative');
  }

  return MapCommittedRevision._(
    source: source,
    revision: revision,
    digest: digest,
    state: state,
  );
}

MapFullResyncRequest createMapFullResyncRequest({
  required MapSourceInstanceId source,
  required int? afterRevision,
}) {
  if (afterRevision?.isNegative ?? false) {
    throw ArgumentError.value(
      afterRevision,
      'afterRevision',
      'must not be negative when present',
    );
  }

  return MapFullResyncRequest._(
    source: source,
    afterRevision: afterRevision,
  );
}
