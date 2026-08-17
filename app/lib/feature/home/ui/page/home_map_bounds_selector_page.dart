import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/home/data/flow/save_home_map_bounds_flow.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 現在の表示範囲をホームのカスタム矩形として保存する。
class HomeMapBoundsSelectorPage extends ConsumerWidget {
  const new({super.key});

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
      AsyncData(value: MapConfiguration(:final styleString?)) => _Body(
        styleString: styleString,
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
  const new({required this.styleString, required this.mapSettings});

  final String styleString;
  final HomeMapSettings mapSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerRef = useRef<MapController?>(null);

    final options = const HomeMapOptionsBuilder().build(
      context: context,
      styleString: styleString,
      map: mapSettings,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('表示範囲を選択')),
      body: MapLibreMap(
        options: options,
        onMapCreated: (c) {
          controllerRef.value = c;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final controller = controllerRef.value;
          if (controller == null) {
            return;
          }
          await ref
              .read(saveHomeMapBoundsFlowProvider)
              .save(
                context: context,
                ref: ref,
                controller: controller,
              );
        },
        icon: const Icon(Icons.save),
        label: const Text('この範囲を保存'),
      ),
    );
  }
}
