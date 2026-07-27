import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorEarthquakeLayers extends ConsumerWidget {
  const LiveMonitorEarthquakeLayers({
    required this.earthquake,
    required this.displayMode,
    super.key,
  });

  final Earthquake earthquake;
  final IntensityDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = ref.watch(
      earthquakeHistoryMapLayerParameterProvider.select(
        (value) => value.value ?? const EarthquakeHistoryMapLayerParameter(),
      ),
    );
    final showingLpgmIntensity = displayMode == IntensityDisplayMode.lpgm;
    final tileUrl = earthquake.estimatedIntensityTileUrl;
    final coordinates = earthquake.hypocenter?.coordinates;

    final intensityLayers = switch (displayMode) {
      IntensityDisplayMode.estimated => <Widget>[
        if (tileUrl != null)
          EarthquakeHistoryDetailsEstimatedIntensityLayer(
            key: const ValueKey('live-monitor-earthquake-estimated'),
            tileUrl: tileUrl,
          ),
      ],
      IntensityDisplayMode.jma || IntensityDisplayMode.lpgm => <Widget>[
        EarthquakeHistoryFillLayer(
          key: const ValueKey('live-monitor-earthquake-fill'),
          earthquake: earthquake,
          parameter: parameter,
          showingLpgmIntensity: showingLpgmIntensity,
        ),
        EarthquakeHistoryStationIntensityLayer(
          key: const ValueKey('live-monitor-earthquake-station'),
          earthquake: earthquake,
          parameter: parameter,
          showingLpgmIntensity: showingLpgmIntensity,
        ),
      ],
    };

    return Stack(
      children: [
        ...intensityLayers,
        if (coordinates is CoordinateLatLng)
          EarthquakeHistoryHypocenterLayer(
            key: const ValueKey('live-monitor-earthquake-hypocenter'),
            earthquake: earthquake,
            parameter: parameter,
          ),
      ],
    );
  }
}
