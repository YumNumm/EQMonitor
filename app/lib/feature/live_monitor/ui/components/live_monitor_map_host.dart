import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class LiveMonitorMapHost extends HookConsumerWidget {
  const LiveMonitorMapHost({
    required this.slotId,
    required this.focus,
    required this.layers,
    super.key,
  });

  final String slotId;
  final LiveMonitorMapFocus focus;
  final List<Widget> layers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final homeConfiguration = ref.watch(homeConfigurationProvider);
    final mapSettings = homeConfiguration.value?.map ?? const HomeMapSettings();
    final controller = useState<MapController?>(null);
    final generation = useRef<int>(0);
    final cameraOperation = useMemoized(() async {
      final captured = controller.value;
      if (captured == null) {
        return;
      }
      final capturedGeneration = ++generation.value;
      await captured.fitBounds(
        bounds: focus.bounds.toLngLatBounds(),
        padding: focus.padding.toEdgeInsets(),
      );
      if (!identical(captured, controller.value) ||
          capturedGeneration != generation.value) {
        return;
      }
    }, [controller.value, focus]);
    useFuture(cameraOperation);

    return switch (mapConfiguration) {
      AsyncData(:final value) => switch (value.styleString) {
        final String styleString => MapOperationQueueScope(
          child: MapLibreEventProvider(
            child: _LiveMonitorMapContent(
              slotId: slotId,
              styleString: styleString,
              mapSettings: mapSettings,
              layers: layers,
              onMapCreated: (createdController) {
                controller.value = createdController;
              },
            ),
          ),
        ),
        null => const _LiveMonitorMapLoadingCard(),
      },
      AsyncError() => _LiveMonitorMapErrorCard(
        onRetry: () {
          ref.invalidate(mapConfigurationProvider);
        },
      ),
      _ => const _LiveMonitorMapLoadingCard(),
    };
  }
}

class _LiveMonitorMapContent extends StatelessWidget {
  const _LiveMonitorMapContent({
    required this.slotId,
    required this.styleString,
    required this.mapSettings,
    required this.layers,
    required this.onMapCreated,
  });

  final String slotId;
  final String styleString;
  final HomeMapSettings mapSettings;
  final List<Widget> layers;
  final ValueChanged<MapController> onMapCreated;

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      key: ValueKey((slotId, styleString, mapSettings)),
      options: homeMapOptionsFromSettings(
        context: context,
        styleString: styleString,
        map: mapSettings,
      ),
      onMapCreated: onMapCreated,
      onEvent: (event) => MapLibreEventProvider.of(context).emit(event),
      children: layers,
    );
  }
}

extension LiveMonitorGeoBoundsMapLibreX on LiveMonitorGeoBounds {
  LngLatBounds toLngLatBounds() => LngLatBounds(
    longitudeWest: minLng,
    longitudeEast: maxLng,
    latitudeSouth: minLat,
    latitudeNorth: maxLat,
  );
}

extension LiveMonitorMapPaddingFlutterX on LiveMonitorMapPadding {
  EdgeInsets toEdgeInsets() => EdgeInsets.fromLTRB(left, top, right, bottom);
}

class _LiveMonitorMapLoadingCard extends StatelessWidget {
  const _LiveMonitorMapLoadingCard();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator.adaptive(),
              SizedBox(height: 12),
              Text('地図を準備しています'),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveMonitorMapErrorCard extends StatelessWidget {
  const _LiveMonitorMapErrorCard({required this.onRetry});

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
              const Text('地図を読み込めませんでした'),
              const SizedBox(height: 8),
              FilledButton(onPressed: onRetry, child: const Text('再試行')),
            ],
          ),
        ),
      ),
    );
  }
}
