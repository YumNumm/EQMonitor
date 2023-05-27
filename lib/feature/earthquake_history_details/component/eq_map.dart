import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/map.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryMap extends HookConsumerWidget {
  EarthquakeHistoryMap({required this.item, super.key}) : super() {
    mapKey = GlobalKey(debugLabel: 'eq-history-map-${item.eventId}');
  }
  final EarthquakeHistoryItem item;
  late final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapViewModelProvider(mapKey).notifier)
            ..registerWidgetSize(
              context.size!,
            )
            ..fitBounds(
              [
                const LatLng(45.3, 145.1),
                const LatLng(30, 128.8),
              ],
            );
        });
        return null;
      },
      [],
    );
    return ClipRRect(
      child: Stack(
        children: [
          // background
          Container(
            color: const Color.fromARGB(255, 179, 230, 255),
          ),
          ClipRRect(
            child: Stack(
              children: [
                BaseMapWidget(mapKey: mapKey),
              ],
            ),
          ),
          MapTouchHandlerWidget(mapKey: mapKey),
        ],
      ),
    );
  }
}

List<LatLng> _getShowBounds(EarthquakeHistoryItem item) {
  if (item.earthquake.intensity == null) {
    if (item.earthquake.earthquake != null) {
      // return [];
    }
  }
  return [
    const LatLng(45.3, 145.1),
    const LatLng(30, 128.8),
  ];
}
