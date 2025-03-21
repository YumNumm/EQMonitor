import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// レイヤーデバッグページの基底クラス
abstract class BaseLayerDebugPage extends HookConsumerWidget {
  const BaseLayerDebugPage({super.key});

  /// ページのタイトル
  String get title;

  /// レイヤーの説明
  String get description;

  /// コントロール部分のウィジェット
  Widget buildControls(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<Map<String, dynamic>> layerParams,
  );

  /// レイヤーのデフォルトパラメータ
  Map<String, dynamic> get defaultLayerParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);
    final layerParams = useState<Map<String, dynamic>>(defaultLayerParams);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: switch (mapConfiguration) {
        AsyncData(:final value) when value.styleString != null => Column(
          children: [
            // 上部に地図を表示
            Expanded(
              flex: 3,
              child: _MapView(
                styleString: value.styleString!,
                buildLayer:
                    (context, ref, controller) =>
                        buildLayer(context, ref, controller, layerParams),
              ),
            ),
            // 下部にコントロールを表示
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'レイヤーパラメータ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(description, style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 16),
                      buildControls(context, ref, layerParams),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          layerParams.value = Map<String, dynamic>.from(
                            defaultLayerParams,
                          );
                        },
                        child: const Text('デフォルト値に戻す'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        AsyncError(:final error) => Center(child: Text('エラー: $error')),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }

  /// レイヤーを構築するメソッド
  Widget buildLayer(
    BuildContext context,
    WidgetRef ref,
    MapController controller,
    ValueNotifier<Map<String, dynamic>> layerParams,
  );
}

/// 地図表示用のウィジェット
class _MapView extends HookConsumerWidget {
  const _MapView({required this.styleString, required this.buildLayer});

  final String styleString;
  final Widget Function(BuildContext, WidgetRef, MapController) buildLayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useState(false);
    final controller = useState<MapController?>(null);

    // 日本全体が表示されるようなカメラ位置を設定
    final cameraPosition = MapCameraPosition.fitBounds(
      screenWidth: MediaQuery.of(context).size.width,
      screenHeight: MediaQuery.of(context).size.height / 2,
      bounds: (minLat: 30, minLng: 128.8, maxLat: 45.8, maxLng: 145.1),
      padding: 16,
    );

    return SizedBox.expand(
      child: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initStyle: 'file://$styleString',
          initZoom: cameraPosition.zoom,
          initCenter: Position(
            cameraPosition.target.lon,
            cameraPosition.target.lat,
          ),
        ),
        onStyleLoaded: (styleController) async {
          await ref
              .read(mapUtilityProvider)
              .addHypocenterImages(controller.value!);
          isInitialized.value = true;
        },
        onMapCreated: (c) => controller.value = c,
        children: [
          if (isInitialized.value && controller.value != null)
            buildLayer(context, ref, controller.value!),
        ],
      ),
    );
  }
}
