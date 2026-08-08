import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_frame_revision.freezed.dart';

enum MapFrameRevisionScope { source, layer }

@freezed
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
