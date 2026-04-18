import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_map_focus.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 各地の震度でマップフォーカスが選ばれたときにカメラを移動する
class EarthquakeHistoryDetailsMapCameraController extends ConsumerWidget {
  const EarthquakeHistoryDetailsMapCameraController({
    required this.eventId,
    required this.earthquake,
    super.key,
  });

  final String eventId;
  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<EarthquakeIntensityMapFocus?>(
      earthquakeHistoryMapFocusProvider(eventId),
      (previous, next) {
        if (next == null) {
          return;
        }
        final mapController = MapController.maybeOf(context);
        if (mapController == null) {
          return;
        }
        final target =
            geographicForEarthquakeIntensityFocus(earthquake, next) ??
                initialGeographicForEarthquake(earthquake);
        unawaited(
          mapController.animateCamera(
            center: target,
            zoom: kEarthquakeHistoryMapFocusZoom,
            nativeDuration: const Duration(milliseconds: 600),
          ),
        );
      },
    );

    return const SizedBox.shrink();
  }
}
