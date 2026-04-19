import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 現在の表示範囲をホームのカスタム矩形として保存する。
class HomeMapBoundsSelectorPage extends ConsumerWidget {
  const HomeMapBoundsSelectorPage({super.key});

  static Future<void> open(BuildContext context) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => const HomeMapBoundsSelectorPage(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final homeAsync = ref.watch(homeConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _Body(
        styleString: value.styleString!,
        mapSettings: homeAsync.value?.map ?? const HomeMapSettings(),
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(),
        body: Center(child: ErrorCard(error: error)),
      ),
      _ => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    };
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    required this.styleString,
    required this.mapSettings,
  });

  final String styleString;
  final HomeMapSettings mapSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerRef = useRef<MapController?>(null);

    final options = homeMapOptionsFromSettings(
      context: context,
      styleString: styleString,
      map: mapSettings,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('表示範囲を選択'),
      ),
      body: MapLibreMap(
        options: options,
        onMapCreated: (c) {
          controllerRef.value = c;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final c = controllerRef.value;
          if (c == null) {
            return;
          }
          final region = c.getVisibleRegion();
          final current = await ref.read(homeConfigurationProvider.future);
          await ref
              .read(homeConfigurationProvider.notifier)
              .updateMap(
                current.map.copyWith(
                  defaultBounds: HomeMapDefaultBounds.custom,
                  customBounds: HomeMapCustomBounds(
                    longitudeWest: region.longitudeWest,
                    longitudeEast: region.longitudeEast,
                    latitudeSouth: region.latitudeSouth,
                    latitudeNorth: region.latitudeNorth,
                  ),
                ),
              );
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('この範囲を保存'),
      ),
    );
  }
}
