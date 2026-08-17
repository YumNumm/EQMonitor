import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_map_instance_owner.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/data/service/map_automatic_focus_controller.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class LiveMonitorMapHost extends StatelessWidget {
  const new({
    required this.slotId,
    required this.focus,
    required this.layers,
    super.key,
  });

  final String slotId;
  final LiveMonitorMapFocus focus;
  final List<Widget> layers;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _LiveMonitorMapViewport(
        slotId: slotId,
        focus: focus,
        layers: layers,
        viewportSize: constraints.biggest,
      ),
    );
  }
}

class _LiveMonitorMapViewport extends HookConsumerWidget {
  const new({
    required this.slotId,
    required this.focus,
    required this.layers,
    required this.viewportSize,
  });

  final String slotId;
  final LiveMonitorMapFocus focus;
  final List<Widget> layers;
  final Size viewportSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final homeConfiguration = ref.watch(homeConfigurationProvider);
    final mapSettings = homeConfiguration.value?.map ?? const HomeMapSettings();
    final instanceOwner = useMemoized(
      LiveMonitorMapInstanceOwner<MapController>.new,
    );
    final instanceKey = switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => (
        slotId,
        value.styleString,
        mapSettings,
      ),
      _ => null,
    };
    final instanceIdentity = useMemoized(instanceOwner.switchInstance, [
      instanceKey,
    ]);
    final controllerBinding =
        useState<
          ({LiveMonitorMapInstanceIdentity identity, MapController controller})?
        >(null);
    useEffect(() => instanceOwner.invalidate, [instanceOwner]);
    final cameraOperation = useMemoized(() async {
      final captured = controllerBinding.value;
      if (captured == null) {
        return;
      }
      final operation = instanceOwner.beginCameraOperation(
        identity: captured.identity,
        controller: captured.controller,
      );
      if (operation == null) {
        return;
      }
      await const MapAutomaticFocusController().fit(
        controller: captured.controller,
        bounds: focus.bounds.toLngLatBounds(),
        viewportSize: viewportSize,
        padding: focus.padding.toEdgeInsets(),
        isCurrent: () => instanceOwner.acceptCameraCompletion(operation),
      );
      if (!instanceOwner.acceptCameraCompletion(operation)) {
        return;
      }
    }, [controllerBinding.value, focus, instanceIdentity, viewportSize]);
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
                if (!instanceOwner.acceptController(
                  identity: instanceIdentity,
                  controller: createdController,
                )) {
                  return;
                }
                controllerBinding.value = (
                  identity: instanceIdentity,
                  controller: createdController,
                );
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
  const new({
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
      options: const HomeMapOptionsBuilder().build(
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
  const new();

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
  const new({required this.onRetry});

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
