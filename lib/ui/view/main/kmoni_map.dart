// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/earthquake/kmoni_controller.dart';
import 'package:eqmonitor/provider/package_info.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/ui/view/widget/map/eew_hypocenter.dart';
import 'package:eqmonitor/ui/view/widget/map/kyoshin_kansokuten.dart';
import 'package:eqmonitor/ui/view/widget/updater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../view/widget/eew/eew_body_widget.dart';
import '../widget/map/base_map.dart';
import '../widget/map/eew_estimated_intensity.dart';
import '../widget/map/eew_intensity.dart';

final transformationControllerProvider = Provider(
  (ref) => TransformationController(),
);

class KmoniMap extends HookConsumerWidget {
  KmoniMap({super.key});

  final mapKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;

    return Scaffold(
      appBar: AppBar(
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
              onPressed: () => context.push('/settings/debug/eew_test'),
            ),
          const UpdaterButtonWidget(),
        ],
        leading: (ref.watch(developerModeProvider).isDeveloper)
            ? const Icon(Icons.lock_open)
            : null,
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
              child: Center(
                child: InteractiveViewer(
                  transformationController:
                      ref.watch(transformationControllerProvider),
                  maxScale: 20,
                  boundaryMargin: const EdgeInsets.all(100),
                  clipBehavior: Clip.none,
                  child: SizedBox(
                    height: 927.4,
                    width: 476,
                    child: Stack(
                      children: [
                        // マップベース
                        const BaseMapWidget(),
                        // EEWの距離減衰式による予想震度
                        if (isDeveloper ||
                            (ref.watch(kmoniProvider).testCaseStartTime !=
                                null))
                          EewEstimatedIntensityWidget(isDeveloper: isDeveloper),

                        // EEWの予想震度
                        const EewIntensityWidget(),
                        // 観測点
                        const KyoshinKansokutenWidget(),
                        // EEWの震央位置
                        const EewHypoCenterWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // テストモードのオーバレイ
            if (ref.watch(kmoniProvider).testCaseStartTime != null)
              Center(
                child: IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: FittedBox(
                      child: BorderedText(
                        strokeWidth: 1,
                        strokeColor: Colors.white,
                        child: const Text(
                          'TEST MODE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(129, 255, 0, 0),
                            fontSize: 200,
                          ),
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
    final eewProvider = ref.watch(eewHistoryProvider);

    final maxShindoColor = (kmoni.analyzedPoint.length > 100)
        ? kmoni.analyzedPoint
            .reduce(
              (curr, next) =>
                  (curr.shindo ?? -4) > (next.shindo ?? -4) ? curr : next,
            )
            .shindoColor
        : null;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (kmoni.analyzedPoint.length > 100)
              ? maxShindoColor?.withAlpha(100)
              : null,
          border: Border.all(
            color: maxShindoColor ?? Colors.transparent,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                        fontWeight: ((kmoni.lastUpdateAttempt
                                    .difference(
                                      kmoni.lastUpdated ?? DateTime(2000),
                                    )
                                    .inSeconds >
                                3))
                            ? FontWeight.bold
                            : null,
                        fontFamily: 'CaskaydiaCove',
                      ),
                    ),
                    const SizedBox(width: 8),
                    // WebSocket 接続状態
                    if (ref.watch(developerModeProvider).isDeveloper)
                      if (eewProvider.subscription?.isJoined() == true)
                        InkWell(
                          onLongPress: () async {
                            // SnackBarを表示
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('WebSocketに再接続しています...'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            eewProvider.subscription?.rejoinUntilConnected();
                          },
                          child: const Icon(
                            Icons.link,
                            semanticLabel: 'WebSocket 接続中',
                          ),
                        )
                      else
                        InkWell(
                          onLongPress: () async {
                            // SnackBarを表示
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('WebSocketに再接続しています...'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            eewProvider.subscription?.rejoinUntilConnected();
                          },
                          child: const Icon(
                            Icons.link_off,
                            color: Colors.red,
                            semanticLabel: 'WebSocket 切断',
                          ),
                        ),
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
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));
    return Column(
      children: [
        for (final eew in eews)
          EewBodyWidget(
            eew: eew,
            colors: ref.watch(jmaIntensityColorProvider),
          ),
      ],
    );
  }
}
