import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';

final class MapRenderSubmission {
  const MapRenderSubmission._({
    required this.frame,
    required this.batches,
  });

  final MapFrameSnapshot frame;
  final List<MapRenderBatch> batches;
}

MapRenderSubmission createMapRenderSubmission({
  required MapFrameSnapshot frame,
  required List<MapRenderBatch> batches,
}) => MapRenderSubmission._(
  frame: frame,
  batches: List<MapRenderBatch>.unmodifiable(batches),
);

abstract interface class MapRenderBatchAdapter {
  void submit({required MapRenderSubmission submission});
}
