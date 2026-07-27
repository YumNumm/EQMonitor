import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_map_host.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_realtime_cards.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_realtime_layers.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorRealtimePane extends HookConsumerWidget {
  const LiveMonitorRealtimePane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewAliveTelegramProvider) ?? const [];
    final shakes = ref.watch(shakeDetectionVisibleProvider);
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (configuration) => configuration.value?.map ?? const HomeMapSettings(),
      ),
    );
    final homeMapBounds = lngLatBoundsForHomeMapSettings(mapSettings);
    final homeBounds = LiveMonitorGeoBounds(
      minLat: homeMapBounds.latitudeSouth,
      maxLat: homeMapBounds.latitudeNorth,
      minLng: homeMapBounds.longitudeWest,
      maxLng: homeMapBounds.longitudeEast,
    );
    final cardHeight = useState(0.0);
    final systemInsets = MediaQuery.paddingOf(context);
    final obscuredInsets = liveMonitorMapObscuredInsets(
      systemTopInset: systemInsets.top,
      systemBottomInset: systemInsets.bottom,
      topCardHeight: 0,
      bottomCardHeight: cardHeight.value,
    );
    final focus = const LiveMonitorMapFocusBuilder().forRealtime(
      homeBounds: homeBounds,
      eews: eews,
      shakes: shakes,
      obscuredBottom: obscuredInsets.bottom,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: LiveMonitorMapHost(
                key: const ValueKey('live-monitor-realtime-map'),
                slotId: 'realtimeSplit',
                focus: focus,
                layers: const [LiveMonitorRealtimeLayers()],
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                minimum: const EdgeInsets.all(8),
                child: LiveMonitorRealtimeCards(
                  maximumHeight: constraints.maxHeight * 0.5,
                  onHeightChanged: (height) {
                    cardHeight.value = height;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
