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
