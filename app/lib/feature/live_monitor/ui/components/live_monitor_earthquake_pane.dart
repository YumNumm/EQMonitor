import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_layers.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_map_host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorEarthquakePane extends HookConsumerWidget {
  const LiveMonitorEarthquakePane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardHeight = useState(0.0);
    final latest = ref.watch(liveMonitorLatestEarthquakeProvider);
    final earthquake = latest.valueOrPrevious;
    if (earthquake == null) {
      final message = latest.hasError
          ? '最新の地震情報を読み込めませんでした'
          : '表示できる地震情報はありません';
      return switch (latest) {
        AsyncLoading() => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 12),
                  Text('最新の地震情報を読み込んでいます'),
                ],
              ),
            ),
          ),
        ),
        _ => LiveMonitorLatestEarthquakeUnavailable(
          message: message,
          onRetry: () {
            ref.invalidate(liveMonitorLatestEarthquakeProvider);
          },
        ),
      };
    }

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
    final focus = const LiveMonitorMapFocusBuilder().forEarthquake(
      earthquake: earthquake,
      fallbackBounds: homeBounds,
      obscuredBottom: cardHeight.value,
    );
    final displayMode = preferredIntensityMode(
      earthquake: earthquake,
      trigger: null,
    );
    final now = ref.read(appClockProvider.notifier).now();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: LiveMonitorMapHost(
                key: const ValueKey('live-monitor-earthquake-map'),
                slotId: 'earthquakeSplit',
                focus: focus,
                layers: [
                  LiveMonitorEarthquakeLayers(
                    earthquake: earthquake,
                    displayMode: displayMode,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                minimum: const EdgeInsets.all(8),
                child: LiveMonitorEarthquakeCard(
                  earthquake: earthquake,
                  trigger: null,
                  compact: false,
                  now: now,
                  maximumHeight: constraints.maxHeight * 0.5,
                  onHeightChanged: (height) {
                    cardHeight.value = height;
                  },
                ),
              ),
            ),
            if (latest.hasError)
              Positioned.fill(
                child: IgnorePointer(
                  child: SafeArea(
                    minimum: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Material(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Text('更新に失敗しました'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class LiveMonitorLatestEarthquakeUnavailable extends StatelessWidget {
  const LiveMonitorLatestEarthquakeUnavailable({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 8),
              FilledButton(onPressed: onRetry, child: const Text('再試行')),
            ],
          ),
        ),
      ),
    );
  }
}
