import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';

import 'dart:async';

import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_history_map_action.dart';
import 'package:eqmonitor/feature/intensity_history/ui/action/intensity_history_page_action.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_city_camera.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_legend.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_loading_overlay.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_navigation_back_button.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_history_map_layers.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

/// 市区町村別最大震度マップのページ。
///
/// - [initialCityCode] と [initialPrefectureCode] の両方が指定されたとき、
///   当該市区町村が詳細モーダルの上に収まる初期カメラで開き、起動直後に
///   詳細モーダルを自動表示する。
class const IntensityHistoryPage({
  final String? initialPrefectureCode,
  final String? initialCityCode,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(intensityHistoryPageActionProvider);
    final jmaMap = initialPrefectureCode == null || initialCityCode == null
        ? null
        : ref.watch(jmaMapProvider);
    return switch ((ref.watch(mapConfigurationProvider), jmaMap)) {
      (
        AsyncData(value: MapConfiguration(:final styleString?)),
        null || AsyncData() || AsyncError(),
      ) =>
        _MapContent(
          styleString: styleString,
          initialPrefectureCode: initialPrefectureCode,
          initialCityCode: initialCityCode,
          initialCityMap: switch (jmaMap) {
            AsyncData(:final value) => value[JmaMapType.areaInformationCity],
            _ => null,
          },
        ),
      (AsyncError(:final error), _) => Scaffold(
        appBar: AppBar(title: const Text('市区町村別 最大震度')),
        body: Center(
          child: ErrorCard(
            error: error,
            onReload: () =>
                HapticUtil.light(() => action.retryMapConfiguration(ref)),
            showLoadingOverlayOnReload: false,
          ),
        ),
      ),
      _ => const Scaffold(
        body: Stack(
          children: [
            Center(child: AccessibleCircularProgressIndicator()),
            Positioned(
              top: 0,
              left: 0,
              child: IntensityHistoryNavigationBackButton(),
            ),
          ],
        ),
      ),
    };
  }
}

class const _MapContent({
  required final String styleString,
  required final String? initialPrefectureCode,
  required final String? initialCityCode,
  required final JmaMap_JmaMapData? initialCityMap,
}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(intensityHistoryMapActionProvider);
    final mapOptions =
        switch ((initialPrefectureCode, initialCityCode, initialCityMap)) {
          (_?, final cityCode?, final cityMap?) =>
            const IntensityHistoryCityCamera().initialMapOptions(
              cityCode: cityCode,
              cityMap: cityMap,
              viewportSize: MediaQuery.sizeOf(context),
              safePadding: MediaQuery.paddingOf(context),
              styleString: styleString,
            ),
          _ => null,
        } ??
        const MapZoomCalculator().japanViewMapOptions(
          context: context,
          styleString: styleString,
        );
    final mapController = useState<MapController?>(null);
    final didInitializeDeepLink = useRef(false);
    // パラメータ到着を effect の再実行契機にするため watch する。
    final hasParameter =
        ref.watch(parameterSetProvider).valueOrPrevious != null;
    // タップ地点の地域判定に使う Worker Isolate を、初回タップを待たずに温める。
    ref.watch(jmaMapIsolateProvider);

    useEffect(
      () {
        final prefectureCode = initialPrefectureCode;
        if (didInitializeDeepLink.value ||
            mapController.value == null ||
            !hasParameter ||
            prefectureCode == null ||
            initialCityCode == null) {
          return null;
        }
        didInitializeDeepLink.value = true;
        unawaited(
          action.openFromDeepLink(
            ref: ref,
            context: context,
            prefectureCode: prefectureCode,
            cityCode: initialCityCode,
          ),
        );
        return null;
      },
      [
        mapController.value,
        hasParameter,
        initialPrefectureCode,
        initialCityCode,
        action,
      ],
    );

    Future<void> handleTap(Geographic point) async {
      final controller = mapController.value;
      if (controller == null) {
        return;
      }
      await action.handleMapTap(
        ref: ref,
        context: context,
        point: point,
        mapController: controller,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          MapOperationQueueScope(
            child: MapLibreMap(
              onMapCreated: (controller) {
                mapController.value = controller;
              },
              options: mapOptions,
              onClick: (event) => handleTap(event.point),
              onLongClick: (event) => handleTap(event.point),
              children: const [IntensityHistoryMapLayers()],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  RegionFloatingPanel(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CachedDataBanner(
                      values: [
                        ref.watch(cityMaxIntensityProvider),
                      ],
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
            child: SafeArea(
              child: IntensityHistoryLegend(),
            ),
          ),

          const IntensityHistoryLoadingOverlay(),
          const IntensityHistoryErrorOverlay(),

          const Positioned(
            top: 0,
            left: 0,
            child: IntensityHistoryNavigationBackButton(),
          ),
        ],
      ),
    );
  }
}
