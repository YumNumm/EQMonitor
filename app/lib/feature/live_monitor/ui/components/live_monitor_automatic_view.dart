import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_display_state.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_coordinator.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_layers.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_overlay.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_map_host.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_realtime_cards.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_realtime_layers.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorAutomaticView extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveMonitorCoordinatorProvider);
    final eews = ref.watch(eewAliveTelegramProvider) ?? const [];
    final shakes = ref.watch(shakeDetectionVisibleProvider);
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (configuration) => configuration.value?.map ?? const HomeMapSettings(),
      ),
    );
    final homeMapBounds = const HomeMapBoundsResolver().resolve(mapSettings);
    final homeBounds = LiveMonitorGeoBounds(
      minLat: homeMapBounds.latitudeSouth,
      maxLat: homeMapBounds.latitudeNorth,
      minLng: homeMapBounds.longitudeWest,
      maxLng: homeMapBounds.longitudeEast,
    );
    final realtimeCardHeight = useState(0.0);
    final earthquakeTopCardHeight = useState(0.0);
    final earthquakeBottomCardHeight = useState(0.0);
    final systemInsets = MediaQuery.paddingOf(context);
    final realtimeObscuredInsets = LiveMonitorMapFocusBuilder.obscuredInsets(
      systemTopInset: systemInsets.top,
      systemBottomInset: systemInsets.bottom,
      topCardHeight: 0,
      bottomCardHeight: realtimeCardHeight.value,
    );
    final earthquakeObscuredInsets = LiveMonitorMapFocusBuilder.obscuredInsets(
      systemTopInset: systemInsets.top,
      systemBottomInset: systemInsets.bottom,
      topCardHeight: earthquakeTopCardHeight.value,
      bottomCardHeight: earthquakeBottomCardHeight.value,
    );
    final realtimeFocus = const LiveMonitorMapFocusBuilder().forRealtime(
      homeBounds: homeBounds,
      eews: eews,
      shakes: shakes,
      obscuredBottom: realtimeObscuredInsets.bottom,
    );
    final (layers, focus) = switch (state) {
      LiveMonitorRealtimeDisplayState() => (
        const <Widget>[LiveMonitorRealtimeLayers()],
        realtimeFocus,
      ),
      LiveMonitorEarthquakeDisplayState(:final earthquake, :final trigger) => (
        <Widget>[
          LiveMonitorEarthquakeLayers(
            earthquake: earthquake,
            displayMode: LiveMonitorEarthquakePresentation.forTrigger(
              earthquake: earthquake,
              trigger: trigger,
            ).displayMode,
          ),
        ],
        const LiveMonitorMapFocusBuilder().forEarthquake(
          earthquake: earthquake,
          fallbackBounds: homeBounds,
          obscuredTop: earthquakeObscuredInsets.top,
          obscuredBottom: earthquakeObscuredInsets.bottom,
        ),
      ),
    };
    final now = ref.read(appClockProvider.notifier).now();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maximumCardHeight = constraints.maxHeight * 0.5;
        final card = switch (state) {
          LiveMonitorRealtimeDisplayState() => LiveMonitorRealtimeCards(
            maximumHeight: maximumCardHeight,
            onHeightChanged: (height) {
              realtimeCardHeight.value = height;
            },
          ),
          LiveMonitorEarthquakeDisplayState(
            :final earthquake,
            :final trigger,
          ) =>
            LiveMonitorEarthquakeOverlay(
              earthquake: earthquake,
              presentation: LiveMonitorEarthquakePresentation.forTrigger(
                earthquake: earthquake,
                trigger: trigger,
              ),
              initialNow: now,
              onTopHeightChanged: (height) {
                earthquakeTopCardHeight.value = height;
              },
              onBottomHeightChanged: (height) {
                earthquakeBottomCardHeight.value = height;
              },
            ),
        };

        return Stack(
          children: [
            Positioned.fill(
              child: LiveMonitorMapHost(
                key: const ValueKey('live-monitor-automatic-map'),
                slotId: 'automatic',
                focus: focus,
                layers: layers,
              ),
            ),
            Positioned.fill(
              child: SafeArea(minimum: const EdgeInsets.all(8), child: card),
            ),
          ],
        );
      },
    );
  }
}
