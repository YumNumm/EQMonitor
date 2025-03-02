import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapContent extends HookConsumerWidget {
  const HomeMapContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfigurationAsyncValue = ref.watch(
      mapConfigurationNotifierProvider,
    );

    return mapConfigurationAsyncValue.when(
      data: (mapConfiguration) {
        return MapLibreMap(
          acceptLicense: true,
          options: MapOptions(
            // initStyle: mapConfiguration.styleString ?? '',
            initCenter: Position(35.681236, 139.767125),
            initZoom: 5,
          ),
        );
      },
      loading:
          () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      error:
          (error, stackTrace) => Center(
            child: Text('マップの読み込みに失敗しました: $error'),
          ),
    );
  }
}
