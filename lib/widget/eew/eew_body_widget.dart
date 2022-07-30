import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/const/res/text_styles.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    /// 通常報でない場合は、早期Return
    if (eew.key.infoType != CommonHeadInfoType.announcement) {
      return Card(
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
    return Card(
      color: eew.value.intensity?.maxint.from.color.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// EEWタイトル部分
            Text(
              '緊急地震速報(${(eew.value.isLastInfo) ? '最終' : '第'}${eew.key.serialNo}報)',
              style: TextStyles.eewTitleStyle(
                isTextBlack: eew.value.intensity?.maxint.from.shouldTextBlack,
              ),
            ),
            const SizedBox(height: 2),

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
                  Text(magAndDepth.toString()),
                  // 予想最大震度
                  Text(
                    '予想最大震度 ${eew.value.intensity!.maxint.from.name}'
                    '${(eew.value.intensity!.maxint.to == JmaIntensity.over) ? '程度以上' : ''}',
                  ),
                  // PLUM報かどうか
                  if (eew.value.earthQuake!.isAssuming) const Text('PLUM報'),
                  if (eew.value.comments?.warning?.text != null)
                    Text(eew.value.comments!.warning!.text),
                  if (eew.value.text != null) Text(eew.value.text!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
