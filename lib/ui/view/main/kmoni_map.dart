// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:eqmonitor/model/setting/kmoni_setting_model.dart';
import 'package:eqmonitor/provider/earthquake/eew_provider.dart';
import 'package:eqmonitor/provider/earthquake/kmoni_controller.dart';
import 'package:eqmonitor/provider/package_info.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/ui/route.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map.viewmodel.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/layer_selector.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/map/eew_hypocenter.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/map/eew_pswave_arraival_circle.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/map/eew_pswave_arraival_circle_stroke.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/map/kyoshin_kansokuten.dart';
import 'package:eqmonitor/ui/view/widget/updater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../view/widget/eew/eew_body_widget.dart';
import 'kmoni_map/map/base_map.dart';
import 'kmoni_map/map/eew_estimated_intensity.dart';
import 'kmoni_map/map/eew_intensity.dart';

final transformationControllerProvider = Provider(
  (ref) => TransformationController(),
);

class KmoniMap extends HookConsumerWidget {
  KmoniMap({this.showAppBar = true, super.key});

  final bool showAppBar;
  final mapKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;
    final vm = ref.watch(kmoniSettingProvider);

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: FittedBox(
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const Text('EQMonitor'),
                    const SizedBox(width: 5),
                    ref.watch(packageInfoProvider).when<Widget>(
                          loading: () => const SizedBox.shrink(),
                          error: (error, stack) => const SizedBox.shrink(),
                          data: (data) => Text(
                            'V${data.version}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                  ],
                ),
              ),
              actions: [
                if (kDebugMode ||
                    ref.watch(developerModeProvider).isDeveloper == true)
                  IconButton(
                    icon: const Icon(Icons.settings_ethernet),
                    onPressed: () => EewTestRoute().push(context),
                  ),
                const UpdaterButtonWidget(),
              ],
              leading: (ref.watch(developerModeProvider).isDeveloper)
                  ? const Icon(Icons.lock_open)
                  : null,
            )
          : null,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async => showKmoniLayerSelectorAlert(context),
        child: const Icon(Icons.layers),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: ref.watch(themeProvider.notifier).isDarkMode
              ? const Color.fromARGB(255, 22, 28, 45)
              : const Color.fromARGB(255, 207, 219, 255),
        ),
        child: Stack(
          key: mapKey,
          children: [
            GestureDetector(
              child: InteractiveViewer(
                transformationController:
                    ref.watch(transformationControllerProvider),
                maxScale: 10,
                boundaryMargin: const EdgeInsets.all(1000),
                clipBehavior: Clip.none,
                child: SizedBox(
                  height: 927.4,
                  width: 476,
                  child: Stack(
                    children: [
                      // マップベース
                      if (vm.layers.contains(KmoniLayer.baseMap))
                        const BaseMapWidget(),
                      if (vm.layers.contains(KmoniLayer.psWaveArrivalCircle))
                        const EewPswaveArraivalCirclesWidget(),
                      // EEWの距離減衰式による予想震度
                      if ((ref.watch(kmoniProvider).testCaseStartTime !=
                              null) ||
                          (vm.layers
                              .contains(KmoniLayer.distanceDecayIntensity)))
                        EewEstimatedIntensityWidget(isDeveloper: isDeveloper),

                      // EEWの予想震度
                      if (vm.layers.contains(KmoniLayer.jmaIntensity))
                        const EewIntensityWidget(),
                      // 観測点
                      if (vm.layers.contains(KmoniLayer.kmoniPoints) ||
                          vm.layers.contains(KmoniLayer.realtimeIntensityIcon))
                        KyoshinKansokutenWidget(
                          showIntensityIcon: vm.layers
                              .contains(KmoniLayer.realtimeIntensityIcon),
                          showKmoniPoints:
                              vm.layers.contains(KmoniLayer.kmoniPoints),
                        ),
                      // EEWのP/S波到達予想円 枠
                      if (vm.layers
                          .contains(KmoniLayer.psWaveArrivalCircleStroke))
                        const EewPswaveArraivalCircleStrokeWidgets(),
                      // EEWの震央位置
                      const EewHypocentersWidget(),
                    ],
                  ),
                ),
              ),
            ),

            // テストモードのオーバレイ
            if (ref.watch(kmoniProvider).testCaseStartTime != null)
              const IgnorePointer(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(kFloatingActionButtonMargin * 3),
                    child: FittedBox(
                      child: Text(
                        '訓練',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(202, 255, 0, 0),
                          fontSize: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // EEW表示
            const RepaintBoundary(child: OnEewWidget()),
            // KMoniの更新状況
            const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(4),
                child: KmoniStatusWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KmoniStatusWidget extends ConsumerWidget {
  const KmoniStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoni = ref.watch(kmoniProvider);
    final eewState = ref.watch(eewProvider);

    final maxShindoColor = (kmoni.analyzedPoint.length > 100)
        ? kmoni.analyzedPoint
            .reduce(
              (curr, next) =>
                  (curr.shindo ?? -4) > (next.shindo ?? -4) ? curr : next,
            )
            .shindoColor
        : null;
    return ClipRRect(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (kmoni.analyzedPoint.length > 100)
              ? maxShindoColor?.withOpacity(0.4)
              : null,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "最終更新: ${(kmoni.lastUpdated != null) ? DateFormat('yyyy/MM/dd HH:mm:ss').format((kmoni.lastUpdated!).toLocal()) : '-'}",
                        style: TextStyle(
                          color: (kmoni.lastUpdateAttempt
                                      .difference(
                                        kmoni.lastUpdated ?? DateTime(2000),
                                      )
                                      .inSeconds >
                                  3)
                              ? const Color.fromARGB(255, 255, 17, 0)
                              : null,
                          fontWeight: (kmoni.lastUpdateAttempt
                                      .difference(
                                        kmoni.lastUpdated ?? DateTime(2000),
                                      )
                                      .inSeconds >
                                  3)
                              ? FontWeight.bold
                              : null,
                          fontFamily: 'CaskaydiaCove',
                        ),
                      ),
                      const SizedBox(width: 8),
                      // TODO(YumNumm): WebSocket 接続状態
                      //if (eewState.channel?.isJoined == true)
                      //  const Icon(
                      //    Icons.link,
                      //    semanticLabel: 'WebSocket 接続中',
                      //  )
                      //else
                      //  const Icon(
                      //    Icons.link_off,
                      //    color: Colors.red,
                      //    semanticLabel: 'WebSocket 切断',
                      //  ),
                      const SizedBox(width: 8),

                      /// テストモード時
                      if (ref.watch(kmoniProvider).testCaseStartTime != null)
                        const Icon(Icons.bug_report),

                      if (kmoni.isUpdating)
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 0, 140, 255),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 69, 125),
                            ),
                          ),
                        )
                      else
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final eewExpandedProvider =
    StateProvider<Map<String, bool>>((ref) => <String, bool>{});

/// EEW情報
class OnEewWidget extends ConsumerWidget {
  const OnEewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewProvider.select((value) => value.showEews));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final eew in eews)
            EewBodyWidget(
              eew: eew,
            ),
        ],
      ),
    );
  }
}
