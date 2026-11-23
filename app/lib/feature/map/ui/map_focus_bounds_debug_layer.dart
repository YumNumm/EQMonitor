import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const MapFocusBoundsDebugGeoJsonBuilder() {
  String build({required MapCameraBounds? bounds}) {
    if (bounds == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <Object>[]});
    }
    final east = bounds.east < bounds.west ? bounds.east + 360 : bounds.east;
    return jsonEncode({
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'properties': <String, Object>{},
          'geometry': {
            'type': 'LineString',
            'coordinates': [
              [bounds.west, bounds.south],
              [east, bounds.south],
              [east, bounds.north],
              [bounds.west, bounds.north],
              [bounds.west, bounds.south],
            ],
          },
        },
      ],
    });
  }
}

class const MapFocusBoundsDebugLayer({
  required final MapCameraBounds? bounds,
  super.key,
}) extends HookWidget {
  static const sourceId = 'map-focus-bounds-debug';
  static const layerId = 'map-focus-bounds-debug-line';

  @override
  Widget build(BuildContext context) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final boundsRef = useRef(bounds);
    boundsRef.value = bounds;

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await styleController.sources.add(
            GeoJsonSource.data(
              id: sourceId,
              data: .text(
                const MapFocusBoundsDebugGeoJsonBuilder().build(
                  bounds: boundsRef.value,
                ),
              ),
            ),
          );
          await styleController.layers.add(
            LineStyleLayer(
              id: layerId,
              sourceId: sourceId,
              color: const .literal(Color(0xFFFF0000)),
              width: const .literal(2),
              dasharray: const .literal([2, 2]),
            ),
          );
        }),
      );
      return () {
        unawaited(
          enqueue(
            () => MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: const [layerId],
              sourceIds: const [sourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          try {
            await styleController.sources.updateGeoJsonData(
              sourceId,
              .text(
                const MapFocusBoundsDebugGeoJsonBuilder().build(bounds: bounds),
              ),
            );
          } on Exception catch (error, stackTrace) {
            talker.handle(error, stackTrace);
          }
        }),
      );
      return null;
    }, [styleController, bounds]);

    return const SizedBox.shrink();
  }
}
