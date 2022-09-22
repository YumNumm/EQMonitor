// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/kmoni_controller.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/widget/map/base_map.dart';
import 'package:eqmonitor/widget/map/eew_estimated_intensity.dart';
import 'package:eqmonitor/widget/map/eew_hypocenter.dart';
import 'package:eqmonitor/widget/map/eew_intensity.dart';
import 'package:eqmonitor/widget/map/kyoshin_kansokuten.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../widget/eew/eew_body_widget.dart';

final transformationControllerProvider =
    Provider((ref) => TransformationController());

class KmoniMap extends HookConsumerWidget {
  const KmoniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;
    final doubleTapPosition = useState(TapDownDetails());
    return Stack(
      children: [
        GestureDetector(
          onDoubleTapDown: (details) => doubleTapPosition.value = details,
          onDoubleTap: () {
            final controller = ref.read(transformationControllerProvider);
            if (controller.value != Matrix4.identity()) {
              controller.value = Matrix4.identity();
            } else {
              final position = doubleTapPosition.value.localPosition;
              controller.value = Matrix4.identity()
                ..translate(-position.dx, -position.dy)
                ..scale(2);
            }
          },
          child: Center(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              transformationController:
                  ref.watch(transformationControllerProvider),
              maxScale: 20,
              constrained: false,
              child: SizedBox(
                height: 927.4,
                width: 476,
                child: Stack(
                  children: [
                    // マップベース
                    const BaseMapWidget(),
                    // EEWの距離減衰式による予想震度
                    if (isDeveloper ||
                        kDebugMode ||
                        (ref.watch(kmoniProvider).testCaseStartTime != null))
                      const EewEstimatedIntensityWidget(),

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
          const Center(
            child: IgnorePointer(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
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
        // EEW表示
        const OnEewWidget(),
        // KMoniの更新状況
        const Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: KmoniStatusWidget(),
          ),
        ),
      ],
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
