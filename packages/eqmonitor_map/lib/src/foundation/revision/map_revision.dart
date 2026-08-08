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

@Freezed(copyWith: false)
sealed class MapRevisionApplyResult<TState>
    with _$MapRevisionApplyResult<TState> {
  // Task 14 exposes this only through the validated public factory.
  // ignore: unused_element
  const factory MapRevisionApplyResult._committed({
    required MapCommittedRevision<TState> current,
    MapRevisionRejectReason? reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultCommitted<TState>;

  // Task 14 exposes this only through the validated public factory.
  // ignore: unused_element
  const factory MapRevisionApplyResult._idempotentNoOp({
    required MapCommittedRevision<TState> current,
    MapRevisionRejectReason? reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultIdempotentNoOp<TState>;

  // Task 14 exposes this only through the validated public factory.
  // ignore: unused_element
  const factory MapRevisionApplyResult._rejected({
    required MapCommittedRevision<TState>? current,
    required MapRevisionRejectReason reason,
    MapFullResyncRequest? fullResyncRequest,
  }) = _MapRevisionApplyResultRejected<TState>;
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
