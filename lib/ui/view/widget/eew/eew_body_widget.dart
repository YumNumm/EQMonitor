// ignore_for_file: lines_longer_than_80_chars

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:eqmonitor/ui/view/views.dart';
import 'package:eqmonitor/ui/view/widget/intensity_widget.dart';
import 'package:eqmonitor/utils/extension/relative_luminance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewBodyWidget extends StatefulHookConsumerWidget {
  const EewBodyWidget({
    super.key,
    required this.eew,
  });

  final EewTelegram eew;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EewBodyWidgetState();
}

class _EewBodyWidgetState extends ConsumerState<EewBodyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eew = widget.eew;
    final colors = ref.watch(jmaIntensityColorProvider);
    final isExpanded = useState<bool>(
      ref.read(eewExpandedProvider)[eew.head.eventId.toString()] ?? true,
    );

    /// 地震発生時刻があるかどうか
    final hasOriginTime = eew.eew.earthquake?.originTime != null;

    /// 最大震度
    /// to がoverなら fromを返す
    /// それ以外はtoを返す
    final forecastMaxIntensity =
        (eew.eew.intensity?.forecastMaxInt.to == JmaIntensity.over)
            ? eew.eew.intensity!.forecastMaxInt.from
            : eew.eew.intensity?.forecastMaxInt.to ?? JmaIntensity.unknown;

    /// 通常報でない場合は、早期Return
    if (eew.head.infoType != TelegramInfoType.announcement) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text(
                eew.head.headline ?? '先ほどの緊急地震速報は取り消されました',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    /// 警報かどうか
    final isWarning = eew.eew.isWarning ??
        eew.eew.comments?.warning?.codes.contains(201) ??
        false;

    final collapsedWidget = Card(
      key: const ValueKey(0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
      elevation: 3,
      color: (eew.eew.intensity?.forecastMaxInt.from ?? JmaIntensity.unknown)
          .fromUser(colors)
          .withOpacity(0.8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ヘッダー・予想最大震度
          FittedBox(
            child: IntensityWidget(
              intensity: forecastMaxIntensity,
              size: 48,
              opacity: 1,
            ),
          ),

          // 詳細情報
          if (eew.eew.earthquake != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${eew.eew.earthquake?.hypocenter.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: (eew.eew.intensity?.forecastMaxInt.from ??
                          JmaIntensity.unknown)
                      .fromUser(colors)
                      .onPrimary,
                ),
              ),
            ),
        ],
      ),
    );

    final expandedWidget = Card(
      key: const ValueKey(1),
      margin: EdgeInsets.zero,
      color: (eew.eew.intensity?.forecastMaxInt.from ?? JmaIntensity.unknown)
          .fromUser(colors)
          .withOpacity(0.8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ヘッダー・予想最大震度
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(),
                      const Text(
                        '緊急地震速報',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${isWarning ? '警報' : '予報'}'
                        '${eew.eew.isLastInfo ? ' 最終' : ''} #${eew.head.serialNo}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 予想最大震度
              Text(
                '予想最大震度',
                style: TextStyle(
                  color: (eew.eew.intensity?.forecastMaxInt.from ??
                          JmaIntensity.unknown)
                      .fromUser(colors)
                      .onPrimary,
                ),
              ),
              // 予想最大震度不明の場合
              if (forecastMaxIntensity == JmaIntensity.unknown)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: FittedBox(
                    child: Text(
                      '不明',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: (eew.eew.intensity?.forecastMaxInt.from ??
                                JmaIntensity.unknown)
                            .fromUser(colors)
                            .onPrimary,
                      ),
                    ),
                  ),
                )
              else
                FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      // 数字部分
                      Text(
                        forecastMaxIntensity.name
                            .replaceAll(RegExp(r'[^0-9]'), ''),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: (eew.eew.intensity?.forecastMaxInt.from ??
                                  JmaIntensity.unknown)
                              .fromUser(colors)
                              .onPrimary,
                        ),
                      ),
                      // 文字部分
                      Text(
                        forecastMaxIntensity.name
                            .replaceAll(RegExp(r'[0-9]'), '')
                            .replaceAll('+', '強')
                            .replaceAll('-', '弱'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: (eew.eew.intensity?.forecastMaxInt.from ??
                                  JmaIntensity.unknown)
                              .fromUser(colors)
                              .onPrimary,
                        ),
                      ),
                      // 程度以上
                      if (eew.eew.intensity?.forecastMaxInt.to ==
                          JmaIntensity.over)
                        Text(
                          '程度以上',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: (eew.eew.intensity?.forecastMaxInt.from ??
                                    JmaIntensity.unknown)
                                .fromUser(colors)
                                .onPrimary,
                          ),
                        ),
                    ],
                  ),
                ),
              //if (eew.eew.intensity?.forecastMaxLgInt != null)
              //  Text(
              //    '予想長周期地震動最大区分 ${eew.eew.intensity?.forecastMaxLgInt!.from.name}',
              //  ),
            ],
          ),
          // 詳細情報
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(),
                  if (eew.eew.earthquake != null)
                    Column(
                      children: [
                        FittedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '${eew.eew.earthquake?.hypocenter.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'で地震${hasOriginTime ? '発生' : '検知'}',
                              ),
                            ],
                          ),
                        ),
                        // M と 深さ
                        if (eew.eew.earthquake!.condition == '仮定震源要素')
                          const FittedBox(
                            child: Text(
                              'PLUM法による検知',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        else if (eew.eew.earthquake!.originTime == null &&
                            eew.eew.earthquake!.hypocenter.accuracy
                                    .epicenters[0] ==
                                1)
                          const FittedBox(
                            child: Text(
                              'レベル法による検知',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        else
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                // Magunitude
                                if (eew.eew.earthquake!.magnitude.condition ==
                                    null)
                                  const Text(
                                    'M',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                if (eew.eew.earthquake!.hypocenter.depth
                                        .condition ==
                                    null)
                                  Text(
                                    (eew.eew.earthquake!.magnitude.condition !=
                                            null)
                                        ? eew.eew.earthquake!.magnitude
                                            .condition!
                                        : eew.eew.earthquake?.magnitude.value
                                                .toString() ??
                                            '不明',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                    ),
                                  ),
                                const VerticalDivider(),
                                // Depth
                                if (eew.eew.earthquake!.hypocenter.depth
                                        .condition ==
                                    null)
                                  Text(
                                    eew.eew.earthquake?.hypocenter.depth.type ??
                                        '深さ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                Text(
                                  (eew.eew.earthquake!.hypocenter.depth
                                              .condition !=
                                          null)
                                      ? eew.eew.earthquake!.hypocenter.depth
                                          .condition!.name
                                      : eew.eew.earthquake?.hypocenter.depth
                                              .value
                                              .toString() ??
                                          '不明',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                  ),
                                ),
                                if (eew.eew.earthquake!.hypocenter.depth
                                        .condition ==
                                    null)
                                  Text(
                                    eew.eew.earthquake?.hypocenter.depth.unit ??
                                        'km',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        // 発生時刻と震源距離(NEED IMPL)
                        FittedBox(
                          child: Row(
                            children: [
                              Text(
                                DateFormat('yyyy/MM/dd HH:mm:ss').format(
                                  (eew.eew.earthquake!.originTime ??
                                          eew.eew.earthquake!.arrivalTime)
                                      .toLocal(),
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "頃${hasOriginTime ? '発生' : '検知'}",
                              ),
                            ],
                          ),
                        ),
                        // 震央精度
                        FittedBox(
                          child: Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Text(
                                '震源精度 ',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                (eew.eew.earthquake!.hypocenter.accuracy
                                            .epicenters[0] ==
                                        1)
                                    ? eew.eew.earthquake!.condition == '仮定震源要素'
                                        ? 'PLUM法'
                                        : eew.eew.earthquake!.originTime == null
                                            ? 'P波/S波レベル越え'
                                            : 'IPF法(1点)'
                                    : eew.eew.earthquake!.hypocenter.accuracy
                                        .hypocenterAccuracy
                                        .replaceAll(
                                          '(気象庁データ)',
                                          '',
                                        )
                                        .replaceAll(
                                          '(Hi-netデータ)',
                                          '',
                                        )
                                        .replaceAll(
                                          '震源とマグニチュードに基づく震度予測手法での精度が',
                                          '',
                                        ),
                              ),
                            ],
                          ),
                        ),
                        // デバッグ情報
                        if (ref.watch(developerModeProvider).isDeveloper)
                          FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  'EventID:${eew.head.eventId}',
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: InkWell(
          onTap: () {
            isExpanded.value = !isExpanded.value;
            ref.read(eewExpandedProvider)[eew.head.eventId!] =
                !ref.read(eewExpandedProvider)[eew.head.eventId!]!;
          },
          onDoubleTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '精度情報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    eew.eew.earthquake!.hypocenter.accuracy.toJson().toString(),
                  )
                ],
              ),
            ),
          ),
          //child: ExpandablePanel(
          //  controller: expandableController,
          //  theme: const ExpandableThemeData(
          //    animationDuration: Duration(milliseconds: 200),
          //  ),
          //  collapsed: collapsedWidget,
          //  expanded: expandedWidget,
          //),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            key: ValueKey(eew.head.eventId.toString()),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: (isExpanded.value) ? expandedWidget : collapsedWidget,
          ),
        ),
      ),
    );
  }
}
