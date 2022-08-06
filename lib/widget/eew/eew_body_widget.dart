import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/res/text_styles.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../extension/relative_luminance.dart';

class EewBodyWidget extends StatelessWidget {
  const EewBodyWidget({
    super.key,
    required this.eew,
  });

  final MapEntry<CommonHead, EEWInformation> eew;

  @override
  Widget build(BuildContext context) {
    /// 地震発生時刻があるかどうか
    final hasOriginTime = eew.value.earthQuake?.originTime != null;

    /// 最大震度
    /// to がoverなら fromを返す
    /// それ以外はtoを返す
    final maxIntensity = (eew.value.intensity?.maxint.to == JmaIntensity.over)
        ? eew.value.intensity!.maxint.from
        : eew.value.intensity?.maxint.to ?? JmaIntensity.Error;

    /// 通常報でない場合は、早期Return
    if (eew.key.infoType != CommonHeadInfoType.announcement) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            eew.key.headline ?? '先ほどの緊急地震速報は取り消されました',
            style: TextStyles.eewTitleStyle(),
          ),
        ),
      );
    }
    // マグニチュードと深さの文章
    final magAndDepth = StringBuffer()
      ..writeAll(<String>[
        (eew.value.earthQuake!.magnitude.condition != null)
            ? eew.value.earthQuake!.magnitude.condition!.description
            : (eew.value.earthQuake!.magnitude.value != null)
                ? 'M${eew.value.earthQuake!.magnitude.value}'
                : '不明',
        ' ',
        (eew.value.earthQuake!.hypoCenter.depth.condition != null)
            ? eew.value.earthQuake!.hypoCenter.depth.condition!.description
            : (eew.value.earthQuake!.hypoCenter.depth.value != null)
                ? '深さ${eew.value.earthQuake!.hypoCenter.depth.value}km'
                : '不明',
      ]);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
          color: eew.value.intensity?.maxint.from.color.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: eew.value.intensity?.maxint.from.color ?? Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '予想最大震度',
                    style: TextStyle(
                      color: maxIntensity.color.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    maxIntensity.name,
                    style: TextStyle(
                      fontSize: 40,
                      color: maxIntensity.color.onPrimary,
                      fontFamily: 'CaskaydiaCove',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (eew.value.intensity!.maxint.to == JmaIntensity.over)
                    Text(
                      '程度以上',
                      style: TextStyle(
                        color: maxIntensity.color.onPrimary,
                      ),
                    )
                ],
              ),

              /// EEW 本文部分
              DefaultTextStyle.merge(
                style: TextStyle(
                  color:
                      (eew.value.intensity?.maxint.from.shouldTextBlack == null)
                          ? null
                          : (eew.value.intensity!.maxint.from.shouldTextBlack)
                              ? Colors.black
                              : Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 震央地
                    Text(
                      '${eew.value.earthQuake!.hypoCenter.name}で地震${hasOriginTime ? '発生' : '検知'}',
                    ),
                    Text(
                      '${DateFormat('yyyy/MM/dd hh:mm:ss頃').format(eew.value.earthQuake!.originTime ?? eew.value.earthQuake!.arrivalTime)}${hasOriginTime ? '発生' : '検知'}',
                    ),
                    // マグニチュード
                    Text(
                      '$magAndDepth '
                      '(${(eew.value.isLastInfo) ? '最終' : ''}第${eew.key.serialNo}報)',
                    ),
                    // PLUM報かどうか
                    if (eew.value.earthQuake!.isAssuming) const Text('PLUM報'),
                    if (eew.value.comments?.warning?.text != null)
                      Text(eew.value.comments!.warning!.text),
                    if (eew.value.text != null) Text(eew.value.text!),
                  ],
                ),
              ),

              /// info button
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
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
                  );
                },
                child: const Text(
                  '精度情報',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
