import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_frame_revision.freezed.dart';

enum MapFrameRevisionScope { source, layer }

@Freezed(copyWith: false)
sealed class MapFrameRevisionStamp with _$MapFrameRevisionStamp {
  const factory MapFrameRevisionStamp._({
    required MapFrameRevisionScope scope,
    required MapSourceInstanceId sourceInstanceId,
    required int revision,
    MapContentDigest? contentDigest,
    MapNodeKey? ownerKey,
  }) = _MapFrameRevisionStamp;
}

MapFrameRevisionStamp createMapFrameSourceRevisionStamp({
  required MapSourceInstanceId sourceInstanceId,
  required int revision,
  required MapContentDigest contentDigest,
}) {
  if (revision.isNegative) {
    throw ArgumentError.value(revision, 'revision', 'must not be negative');
  }

  return MapFrameRevisionStamp._(
    scope: MapFrameRevisionScope.source,
    sourceInstanceId: sourceInstanceId,
    revision: revision,
    contentDigest: contentDigest,
  );
}

MapFrameRevisionStamp createMapFrameLayerRevisionStamp({
  required MapSourceInstanceId sourceInstanceId,
  required MapNodeKey ownerKey,
  required int revision,
}) {
  if (revision.isNegative) {
    throw ArgumentError.value(revision, 'revision', 'must not be negative');
  }

  return MapFrameRevisionStamp._(
    scope: MapFrameRevisionScope.layer,
    sourceInstanceId: sourceInstanceId,
    revision: revision,
    ownerKey: ownerKey,
  );
}

List<MapFrameRevisionStamp> canonicalizeMapFrameRevisions({
  required List<MapFrameRevisionStamp> revisions,
}) {
  final canonical = List<MapFrameRevisionStamp>.of(revisions)
    ..sort((left, right) {
      final scopeComparison = left.scope.index.compareTo(right.scope.index);
      if (scopeComparison != 0) {
        return scopeComparison;
      }

      final sourceComparison = left.sourceInstanceId.value.compareTo(
        right.sourceInstanceId.value,
      );
      if (sourceComparison != 0) {
        return sourceComparison;
      }

      final leftOwnerKey = left.ownerKey;
      final rightOwnerKey = right.ownerKey;
      return switch ((leftOwnerKey, rightOwnerKey)) {
        (null, null) => 0,
        (null, _) => -1,
        (_, null) => 1,
        (final MapNodeKey leftOwnerKey, final MapNodeKey rightOwnerKey) =>
          leftOwnerKey.value.compareTo(rightOwnerKey.value),
      };
    });

  MapFrameRevisionStamp? previous;
  for (final revision in canonical) {
    final duplicate =
        previous != null &&
        previous.scope == revision.scope &&
        previous.sourceInstanceId == revision.sourceInstanceId &&
        previous.ownerKey == revision.ownerKey;
    if (duplicate) {
      throw ArgumentError.value(
        revisions,
        'revisions',
        'contains duplicate identity',
      );
    }
    previous = revision;
  }

  return List<MapFrameRevisionStamp>.unmodifiable(canonical);
}
