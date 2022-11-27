// ignore_for_file: lines_longer_than_80_chars

import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/schema/remote/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/ui/view/views.dart';
import 'package:eqmonitor/ui/view/widget/intensity_widget.dart';
import 'package:eqmonitor/utils/extension/relative_luminance.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import '../../../theme/jma_intensity.dart';

class EewBodyWidget extends ConsumerStatefulWidget {
  const EewBodyWidget({
    super.key,
    required this.eew,
  });

  final MapEntry<CommonHead, EEWInformation> eew;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EewBodyWidgetState();
}

class _EewBodyWidgetState extends ConsumerState<EewBodyWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(eewExpandedProvider)
          .putIfAbsent(widget.eew.key.eventId!, () => true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eew = widget.eew;
    final colors = ref.watch(jmaIntensityColorProvider);

    /// 地震発生時刻があるかどうか
    final hasOriginTime = eew.value.earthQuake?.originTime != null;

    /// 最大震度
    /// to がoverなら fromを返す
    /// それ以外はtoを返す
    final maxIntensity = (eew.value.intensity?.maxint.to == JmaIntensity.over)
        ? eew.value.intensity!.maxint.from
        : eew.value.intensity?.maxint.to ?? JmaIntensity.Unknown;

    /// 通常報でない場合は、早期Return
    if (eew.key.infoType != CommonHeadInfoType.announcement) {
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
                eew.key.headline ?? '先ほどの緊急地震速報は取り消されました',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }
    final expandableController = ExpandableController(
      initialExpanded: ref.watch(eewExpandedProvider)[eew.key.eventId],
    );

    /// 警報かどうか
    final isWarning = eew.value.isWarning ??
        eew.value.comments?.warning?.codes.contains(201) ??
        false;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            onTap: () {
              expandableController.toggle();
              ref.read(eewExpandedProvider)[eew.key.eventId!] =
                  !ref.read(eewExpandedProvider)[eew.key.eventId!]!;
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
                      '震央位置:${eew.value.earthQuake!.hypoCenter.accuracy.epicCenterAccuracy.epicCenterAccuracy.description}\n'
                      '震源位置: ${eew.value.earthQuake!.hypoCenter.accuracy.epicCenterAccuracy.hypoCenterAccuracy.description}\n'
                      '深さ: ${eew.value.earthQuake!.hypoCenter.accuracy.depthCalculation.description}\n'
                      'マグニチュード: ${eew.value.earthQuake!.hypoCenter.accuracy.magnitudeCalculation.description}',
                    )
                  ],
                ),
              ),
            ),
            child: ExpandablePanel(
              controller: expandableController,
              theme: const ExpandableThemeData(
                animationDuration: Duration(milliseconds: 200),
              ),
              collapsed: Card(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                elevation: 3,
                color:
                    (eew.value.intensity?.maxint.from ?? JmaIntensity.Unknown)
                        .fromUser(colors)
                        .withOpacity(0.8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ヘッダー・予想最大震度
                    FittedBox(
                      child: IntensityWidget(
                        intensity: maxIntensity,
                        size: 48,
                        opacity: 1,
                      ),
                    ),

                    // 詳細情報
                    if (eew.value.earthQuake != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${eew.value.earthQuake?.hypoCenter.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: (eew.value.intensity?.maxint.from ??
                                    JmaIntensity.Unknown)
                                .fromUser(colors)
                                .onPrimary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              expanded: Card(
                margin: EdgeInsets.zero,
                color:
                    (eew.value.intensity?.maxint.from ?? JmaIntensity.Unknown)
                        .fromUser(colors)
                        .withOpacity(0.8),
                child: Row(
                  children: [
                    // ヘッダー・予想最大震度
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
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
                                  '${eew.value.isLastInfo ? ' 最終' : ''} #${eew.key.serialNo}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 予想最大震度
                          Text(
                            '予想最大震度',
                            style: TextStyle(
                              color: (eew.value.intensity?.maxint.from ??
                                      JmaIntensity.Unknown)
                                  .fromUser(colors)
                                  .onPrimary,
                            ),
                          ),
                          // 予想最大震度不明の場合
                          if (maxIntensity == JmaIntensity.Unknown)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: FittedBox(
                                child: Text(
                                  '不明',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: (eew.value.intensity?.maxint.from ??
                                            JmaIntensity.Unknown)
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
                                    maxIntensity.name
                                        .replaceAll(RegExp(r'[^0-9]'), ''),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                      color:
                                          (eew.value.intensity?.maxint.from ??
                                                  JmaIntensity.Unknown)
                                              .fromUser(colors)
                                              .onPrimary,
                                    ),
                                  ),
                                  // 文字部分
                                  Text(
                                    maxIntensity.name
                                        .replaceAll(RegExp(r'[0-9]'), '')
                                        .replaceAll('+', '強')
                                        .replaceAll('-', '弱'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color:
                                          (eew.value.intensity?.maxint.from ??
                                                  JmaIntensity.Unknown)
                                              .fromUser(colors)
                                              .onPrimary,
                                    ),
                                  ),
                                  // 程度以上
                                  if (eew.value.intensity?.maxint.to ==
                                      JmaIntensity.over)
                                    Text(
                                      '程度以上',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color:
                                            (eew.value.intensity?.maxint.from ??
                                                    JmaIntensity.Unknown)
                                                .fromUser(colors)
                                                .onPrimary,
                                      ),
                                    ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    // 詳細情報
                    Flexible(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(),
                              if (eew.value.earthQuake != null)
                                Column(
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        '${eew.value.earthQuake?.hypoCenter.name} で地震${hasOriginTime ? '発生' : '検知'}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    // M と 深さ
                                    if (eew.value.earthQuake!.isAssuming)
                                      const FittedBox(
                                        child: Text(
                                          'PLUM法による検知',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      )
                                    else if (eew.value.earthQuake!.originTime ==
                                            null &&
                                        eew
                                                .value
                                                .earthQuake!
                                                .hypoCenter
                                                .accuracy
                                                .epicCenterAccuracy
                                                .epicCenterAccuracy ==
                                            EpicCenterAccuracy.f1)
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            // Magunitude
                                            if (eew.value.earthQuake!.magnitude
                                                    .condition ==
                                                null)
                                              const Text(
                                                'M',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            if (eew.value.earthQuake!.hypoCenter
                                                    .depth.condition ==
                                                null)
                                              Text(
                                                (eew.value.earthQuake!.magnitude
                                                            .condition !=
                                                        null)
                                                    ? eew
                                                        .value
                                                        .earthQuake!
                                                        .magnitude
                                                        .condition!
                                                        .description
                                                    : eew.value.earthQuake
                                                            ?.magnitude.value
                                                            .toString() ??
                                                        '不明',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 45,
                                                ),
                                              ),
                                            const VerticalDivider(),
                                            // Depth
                                            if (eew.value.earthQuake!.hypoCenter
                                                    .depth.condition ==
                                                null)
                                              Text(
                                                eew.value.earthQuake?.hypoCenter
                                                        .depth.type ??
                                                    '深さ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            Text(
                                              (eew.value.earthQuake!.hypoCenter
                                                          .depth.condition !=
                                                      null)
                                                  ? eew
                                                      .value
                                                      .earthQuake!
                                                      .hypoCenter
                                                      .depth
                                                      .condition!
                                                      .description
                                                  : eew
                                                          .value
                                                          .earthQuake
                                                          ?.hypoCenter
                                                          .depth
                                                          .value
                                                          .toString() ??
                                                      '不明',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 45,
                                              ),
                                            ),
                                            if (eew.value.earthQuake!.hypoCenter
                                                    .depth.condition ==
                                                null)
                                              Text(
                                                eew.value.earthQuake?.hypoCenter
                                                        .depth.unit ??
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
                                            DateFormat('yyyy/MM/dd HH:mm:ss頃')
                                                    .format(
                                                  (eew.value.earthQuake!
                                                              .originTime ??
                                                          eew.value.earthQuake!
                                                              .arrivalTime)
                                                      .toLocal(),
                                                ) +
                                                (hasOriginTime ? '発生' : '検知'),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // 震央精度
                                    FittedBox(
                                      child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          const Text(
                                            '震央精度 ',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            (eew
                                                        .value
                                                        .earthQuake!
                                                        .hypoCenter
                                                        .accuracy
                                                        .epicCenterAccuracy
                                                        .epicCenterAccuracy ==
                                                    EpicCenterAccuracy.f1)
                                                ? eew.value.earthQuake!
                                                        .isAssuming
                                                    ? 'PLUM法'
                                                    : eew.value.earthQuake!
                                                                .originTime ==
                                                            null
                                                        ? 'P波/S波レベル越え'
                                                        : 'IPF法(1点)'
                                                : eew
                                                    .value
                                                    .earthQuake!
                                                    .hypoCenter
                                                    .accuracy
                                                    .epicCenterAccuracy
                                                    .epicCenterAccuracy
                                                    .description
                                                    .replaceAll(
                                                      '(気象庁データ)',
                                                      '',
                                                    )
                                                    .replaceAll(
                                                      '(Hi-netデータ)',
                                                      '',
                                                    )
                                                    .replaceAll(
                                                      '(海域,観測網外)',
                                                      '(海域)',
                                                    )
                                                    .replaceAll(
                                                      '((内陸,観測網内)',
                                                      '(内陸)',
                                                    ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // デバッグ情報
                                    if (ref
                                        .watch(developerModeProvider)
                                        .isDeveloper)
                                      FittedBox(
                                        child: Column(
                                          children: [
                                            Text(
                                              'EventID:${eew.key.eventId}',
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
