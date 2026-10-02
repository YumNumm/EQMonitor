import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

/// アイコンの非同期読み込みや再追加に左右されない、マーカーの挿入位置。
/// 同じ MapOperationQueueScope 内で、各マーカーより先に配置する。
class EarthquakeHistoryMarkerAnchorsLayer extends HookWidget {
  const new({super.key});

  static const sourceId = 'earthquake-history-marker-anchors';
  static const background = 'earthquake-history-marker-background-anchor';
  static const lower = 'earthquake-history-marker-lower-anchor';
  static const upper = 'earthquake-history-marker-upper-anchor';

  @override
  Widget build(BuildContext context) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      var disposed = false;
      unawaited(
        enqueue(() async {
          if (disposed) {
            return;
          }
          await styleController.addSource(
            const GeoJsonSource(
              id: sourceId,
              data: '{"type":"FeatureCollection","features":[]}',
            ),
          );
          for (final id in [background, lower, upper]) {
            if (disposed) {
              return;
            }
            await styleController.addLayer(
              CircleStyleLayer(
                id: id,
                sourceId: sourceId,
                layout: const {'visibility': 'none'},
              ),
            );
          }
        }),
      );
      return () {
        disposed = true;
        unawaited(
          enqueue(
            () => MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: const [upper, lower, background],
              sourceIds: const [sourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    return const SizedBox.shrink();
  }
}
