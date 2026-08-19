import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';

final class MapRenderSubmission {
  const new _({
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

void validateMapRenderSubmission({required MapRenderSubmission submission}) {
  for (final (index, batch) in submission.batches.indexed) {
    if (index == 0) {
      continue;
    }
    final previous = submission.batches[index - 1];
    if (batch.version != previous.version) {
      throw ArgumentError.value(batch, 'submission', 'batch version mismatch');
    }
    if (batch.compatibility.phasePolicyVersion !=
        previous.compatibility.phasePolicyVersion) {
      throw ArgumentError.value(batch, 'submission', 'phase policy mismatch');
    }
    if (compareMapRenderSortKeys(
          previous.packets.last.sortKey,
          batch.packets.first.sortKey,
        ) >
        0) {
      throw ArgumentError.value(batch, 'submission', 'batch order mismatch');
    }
  }
}

abstract interface class MapRenderBatchAdapter {
  void submit({required MapRenderSubmission submission});
}
