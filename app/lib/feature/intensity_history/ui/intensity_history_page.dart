import 'dart:async';

import 'package:eqmonitor/core/component/cached_data_banner.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地域別最大震度マップのページ。
///
/// - [initialPrefectureCode]: 指定時は起動直後に当該都道府県にフォーカスする(Lv2)。
/// - [initialCityCode]: 指定時はさらに市区町村詳細モーダルを自動表示する。
class IntensityHistoryPage extends ConsumerWidget {
  const IntensityHistoryPage({
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
        appBar: AppBar(title: const Text('都道府県別 最大震度')),
        body: Center(child: ErrorCard(error: error)),
      ),
      _ => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({
    required this.styleString,
    required this.initialPrefectureCode,
    required this.initialCityCode,
  });

  final String styleString;
  final String? initialPrefectureCode;
  final String? initialCityCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intensityHistoryControllerProvider);
    final action = ref.watch(intensityHistoryMapActionProvider);
    final isFocused = state is IntensityHistoryStateCity;
    final canNavigateBack = Navigator.canPop(context);
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

    return PopScope(
      // フォーカス中は戻る操作を全国表示への復帰に割り当てる。
      canPop: !isFocused,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        final controller = mapController.value;
        if (controller == null) {
          return;
        }
        unawaited(action.backToJapan(ref: ref, controller: controller));
      },
      child: Scaffold(
        body: Stack(
          children: [
            MapOperationQueueScope(
              child: MapLibreMap(
                onMapCreated: (controller) {
                  mapController.value = controller;
                  isMapCreated.value = true;
                },
                options: calculateJapanViewMapOptions(
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
                        values: [
                          ref.watch(prefectureHighestProvider),
                          if (state is IntensityHistoryStateCity)
                            ref.watch(
                              cityHighestProvider(state.prefectureCode),
                            ),
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
              child: SafeArea(child: IntensityHistoryLegend()),
            ),

            const Positioned(
              top: 0,
              left: 0,
              child: IntensityHistoryNavigationBackButton(),
            ),

            const IntensityHistoryErrorOverlay(),

            // 全国表示へ戻るボタン（左上、都道府県フォーカス中のみ表示）
            if (mapController.value case final controller? when isFocused)
              Positioned(
                top: canNavigateBack ? 56 : 0,
                left: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _BackToJapanButton(
                      onTap: () async =>
                          action.backToJapan(ref: ref, controller: controller),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BackToJapanButton extends StatelessWidget {
  const _BackToJapanButton({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: const Tooltip(
          message: '全国表示に戻る',
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.public_rounded),
          ),
        ),
      ),
    );
  }
}
