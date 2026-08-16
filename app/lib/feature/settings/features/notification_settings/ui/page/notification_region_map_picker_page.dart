import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/latest_map_operation_guard.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_region_map_selection_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_region_catalog_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_region_map_layer.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_region_map_selection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class NotificationRegionMapPickerPage extends HookConsumerWidget {
  const NotificationRegionMapPickerPage({super.key});

  static Future<NotificationRegionSelection?> show(BuildContext context) =>
      Navigator.of(context).push<NotificationRegionSelection>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const NotificationRegionMapPickerPage(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfigurationAsync = ref.watch(mapConfigurationProvider);
    final catalogAsync = ref.watch(notificationRegionCatalogProvider);
    final isolateAsync = ref.watch(jmaMapIsolateProvider);
    final selection = ref.watch(
      notificationRegionMapSelectionControllerProvider,
    );
    final controller = useRef<MapController?>(null);
    final isStyleLoaded = useState(false);
    final isResolving = useState(false);
    final operationGuard = useMemoized(LatestMapOperationGuard.new);
    useEffect(() {
      return () {
        operationGuard.dispose();
        controller.value = null;
      };
    }, [operationGuard]);

    final styleString = mapConfigurationAsync.value?.styleString;
    final catalog = catalogAsync.value;
    final isolate = isolateAsync.value;
    final hasError =
        mapConfigurationAsync.hasError ||
        catalogAsync.hasError ||
        isolateAsync.hasError;

    if (hasError) {
      return Scaffold(
        appBar: AppBar(title: const Text('地図から地域を選択')),
        body: _NotificationRegionMapError(
          onRetry: () {
            ref
              ..invalidate(mapConfigurationProvider)
              ..invalidate(notificationRegionCatalogProvider)
              ..invalidate(jmaMapIsolateProvider);
          },
        ),
      );
    }
    if (styleString == null || catalog == null || isolate == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('地図から地域を選択')),
        body: const Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    final mapOptions = calculateJapanViewMapOptions(
      context: context,
      styleString: styleString,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('地図から地域を選択'),
        actions: [
          if (selection is! NotificationRegionMapNationwide)
            IconButton(
              tooltip: '全国表示に戻す',
              icon: const Icon(Icons.public),
              onPressed: isResolving.value
                  ? null
                  : () async {
                      final generation = operationGuard.begin();
                      ref
                          .read(
                            notificationRegionMapSelectionControllerProvider
                                .notifier,
                          )
                          .reset();
                      final mapController = controller.value;
                      if (mapController == null) {
                        return;
                      }
                      try {
                        await operationGuard.runLatest(
                          generation: generation,
                          operation: () => mapController.animateCamera(
                            center: JapanBounds.center,
                            zoom: mapOptions.initZoom,
                          ),
                        );
                      } on Exception catch (error, stackTrace) {
                        talker.handle(error, stackTrace);
                      }
                    },
            ),
        ],
      ),
      body: Stack(
        children: [
          MapOperationQueueScope(
            child: MapLibreMap(
              options: mapOptions,
              onMapCreated: (mapController) {
                controller.value = mapController;
              },
              onStyleLoaded: (_) {
                isStyleLoaded.value = true;
              },
              onEvent: (event) {
                if (event is! MapEventClick && event is! MapEventLongClick) {
                  return;
                }
                if (!context.mounted) {
                  return;
                }
                if (isResolving.value) {
                  return;
                }
                final point = switch (event) {
                  MapEventClick(:final point) => point,
                  MapEventLongClick(:final point) => point,
                  _ => throw UnimplementedError(),
                };
                unawaited(() async {
                  final generation = operationGuard.begin();
                  isResolving.value = true;
                  final state = ref.read(
                    notificationRegionMapSelectionControllerProvider,
                  );
                  final type = switch (state) {
                    NotificationRegionMapNationwide() =>
                      JmaMapType.areaForecastLocalEew,
                    _ => JmaMapType.areaInformationCity,
                  };
                  try {
                    final item = await isolate.calculateNearestElement(
                      latitude: point.lat,
                      longitude: point.lon,
                      type: type,
                    );
                    if (!operationGuard.isCurrent(generation) ||
                        !context.mounted) {
                      return;
                    }
                    final property = item?.property;
                    if (property == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('この場所は選択できません')),
                      );
                      return;
                    }
                    final notifier = ref.read(
                      notificationRegionMapSelectionControllerProvider.notifier,
                    );
                    if (state is NotificationRegionMapNationwide) {
                      final region = catalog.regionByCode(property.code);
                      final bounds = item?.bounds;
                      final mapController = controller.value;
                      if (region == null ||
                          bounds == null ||
                          mapController == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('地域情報を特定できませんでした')),
                        );
                        return;
                      }
                      notifier.focusRegion(region);
                      final size = MediaQuery.sizeOf(context);
                      final zoom = zoomLevelForBounds(
                        minLat: bounds.southWest.lat,
                        maxLat: bounds.northEast.lat,
                        minLng: bounds.southWest.lng,
                        maxLng: bounds.northEast.lng,
                        screenWidth: size.width,
                        screenHeight: size.height * 0.65,
                      ).clamp(6, 9).toDouble();
                      await operationGuard.runLatest(
                        generation: generation,
                        operation: () => mapController.animateCamera(
                          center: Geographic(
                            lon:
                                (bounds.southWest.lng + bounds.northEast.lng) /
                                2,
                            lat:
                                (bounds.southWest.lat + bounds.northEast.lat) /
                                2,
                          ),
                          zoom: zoom,
                        ),
                      );
                    } else {
                      final region = switch (state) {
                        NotificationRegionMapFocused(:final region) => region,
                        NotificationRegionMapCitySelected(:final region) =>
                          region,
                        NotificationRegionMapNationwide() => null,
                      };
                      final city = region?.cityByCode(property.code);
                      if (city == null || !notifier.selectCity(city)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('フォーカス中の地域内を選択してください')),
                        );
                      }
                    }
                  } on Exception catch (error, stackTrace) {
                    talker.handle(error, stackTrace);
                    if (operationGuard.isCurrent(generation) &&
                        context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('地図から地域を選択できませんでした')),
                      );
                    }
                  } finally {
                    if (operationGuard.isCurrent(generation) &&
                        context.mounted) {
                      isResolving.value = false;
                    }
                  }
                }());
              },
              children: [
                if (isStyleLoaded.value) const NotificationRegionMapLayer(),
              ],
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: SafeArea(
              top: false,
              child: NotificationRegionMapSelectionCard(
                selection: selection,
                isResolving: isResolving.value,
                onDecideRegion: () {
                  final region = switch (selection) {
                    NotificationRegionMapFocused(:final region) => region,
                    NotificationRegionMapCitySelected(:final region) => region,
                    NotificationRegionMapNationwide() => null,
                  };
                  if (region == null) {
                    return;
                  }
                  Navigator.of(context).pop(
                    NotificationRegionSelection(
                      regionCode: region.code,
                      regionName: region.name,
                    ),
                  );
                },
                onDecideCity: () {
                  if (selection case NotificationRegionMapCitySelected(
                    :final region,
                    :final city,
                  )) {
                    Navigator.of(context).pop(
                      NotificationRegionSelection(
                        regionCode: region.code,
                        regionName: region.name,
                        cityCode: city.code,
                        cityName: city.name,
                      ),
                    );
                  }
                },
                onBackToRegion: () => ref
                    .read(
                      notificationRegionMapSelectionControllerProvider.notifier,
                    )
                    .deselectCity(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationRegionMapError extends StatelessWidget {
  const _NotificationRegionMapError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('地図情報を読み込めませんでした'),
        const SizedBox(height: 8),
        FilledButton.tonal(onPressed: onRetry, child: const Text('再試行')),
      ],
    ),
  );
}
