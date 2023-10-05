import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_region_painter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryMap extends HookConsumerWidget {
  const EarthquakeHistoryMap({
    required this.item,
    required this.mapKey,
    super.key,
  });
  final EarthquakeHistoryItem item;
  final GlobalKey mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapData =
        ref.watch(zoomCachedProjectedFeatureLayerProvider).valueOrNull;
    if (mapData == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return EarthquakeIntensityMapWidget(
      item: item,
      mapKey: mapKey,
      showIntensityIcon: true,
      mapData: mapData,
    );
  }
}
