import 'dart:async';

import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_history_map_action.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_legend.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_navigation_back_button.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 市区町村別最大震度マップのページ。
///
/// - [initialPrefectureCode]: 指定時は起動直後に当該都道府県へカメラを寄せる。
/// - [initialCityCode]: 指定時はさらに市区町村詳細モーダルを自動表示する。
class IntensityHistoryPage extends ConsumerWidget {
  const new({
    this.initialPrefectureCode,
    this.initialCityCode,
    super.key,
  });

  final String? initialPrefectureCode;
  final String? initialCityCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(mapConfigurationProvider)) {
      AsyncData(value: MapConfiguration(:final styleString?)) => _MapContent(
        styleString: styleString,
        initialPrefectureCode: initialPrefectureCode,
        initialCityCode: initialCityCode,
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('市区町村別 最大震度')),
        body: Center(child: ErrorCard(error: error)),
      ),
      _ => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const new({
    required this.styleString,
    required this.initialPrefectureCode,
    required this.initialCityCode,
  });

  final String styleString;
  final String? initialPrefectureCode;
  final String? initialCityCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(intensityHistoryMapActionProvider);
    final mapController = useRef<MapController?>(null);
    final isMapCreated = useState(false);
    final didInitializeDeepLink = useRef(false);
    // パラメータ到着を effect の再実行契機にするため watch する。
    final hasParameter =
        ref.watch(parameterSetProvider).valueOrPrevious != null;
    // タップ地点の地域判定に使う Worker Isolate を、初回タップを待たずに温める。
    ref.watch(jmaMapIsolateProvider);

    useEffect(
      () {
        final prefectureCode = initialPrefectureCode;
        final controller = mapController.value;
        if (didInitializeDeepLink.value ||
            !isMapCreated.value ||
            !hasParameter ||
            prefectureCode == null ||
            controller == null) {
          return null;
        }
        didInitializeDeepLink.value = true;
        unawaited(
          action.openFromDeepLink(
            ref: ref,
            context: context,
            controller: controller,
            prefectureCode: prefectureCode,
            cityCode: initialCityCode,
          ),
        );
        return null;
      },
      [
        isMapCreated.value,
        hasParameter,
        initialPrefectureCode,
        initialCityCode,
        action,
      ],
    );

    return Scaffold(
      body: Stack(
        children: [
          MapOperationQueueScope(
            child: MapLibreMap(
              onMapCreated: (controller) {
                mapController.value = controller;
                isMapCreated.value = true;
              },
              options: const MapZoomCalculator().japanViewMapOptions(
                context: context,
                styleString: styleString,
              ),
              onEvent: (event) async {
                final point = switch (event) {
                  MapEventClick(:final point) => point,
                  MapEventLongClick(:final point) => point,
                  _ => null,
                };
                final controller = mapController.value;
                if (point == null || controller == null) {
                  return;
                }
                await action.handleMapTap(
                  ref: ref,
                  context: context,
                  controller: controller,
                  point: point,
                );
              },
              children: const [IntensityFillLayer()],
            ),
          ),

          // フローティングパネル（上部中央）+ キャッシュ表示バナー
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: RegionFloatingPanel(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CachedDataBanner(
                      values: [ref.watch(cityMaxIntensityProvider)],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 凡例（右下）
          const Positioned(
            bottom: 8,
            right: 8,
            child: SafeArea(child: IntensityHistoryLegend()),
          ),

          const Positioned(
            top: 0,
            left: 0,
            child: IntensityHistoryNavigationBackButton(),
          ),

          const IntensityHistoryErrorOverlay(),
        ],
      ),
    );
  }
}
