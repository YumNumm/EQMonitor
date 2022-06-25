import 'package:auto_size_text/auto_size_text.dart';
import 'package:eqmonitor/schema/svir/Body/accuracy/depth_calculation.dart';
import 'package:eqmonitor/schema/svir/Body/accuracy/epicCenterAccuracy.dart';
import 'package:eqmonitor/schema/svir/Body/accuracy/magnitude_calculation.dart';
import 'package:eqmonitor/schema/svir/Body/accuracy/number_of_magnitude_calculation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../schema/svir/svirResponse.dart';
import '../utils/KyoshinMonitorlib/JmaIntensity.dart';

class OnEEWWidget extends StatelessWidget {
  OnEEWWidget({
    super.key,
    required this.eew,
    required this.now,
  });

  final SvirResponse eew;
  final DateTime now;
  final headGroup = AutoSizeGroup();
  final depthAndMagnitudeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    final maxIntensity = JmaIntensity.values.firstWhere(
      (e) => e.name == eew.body.intensity?.maxInt,
      orElse: () => JmaIntensity.Error,
    );
    return Card(
      color: const Color.fromRGBO(236, 245, 251, 1),
      margin: const EdgeInsets.fromLTRB(5, 3, 5, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    color: const Color.fromRGBO(255, 203, 203, 1),
                    margin: const EdgeInsets.all(8),
                    child: Text(
                        ((eew.body.warningFlag) ? 'EEW(警報 ' : 'EEW(予報 ') +
                            ((eew.body.endFlag)
                                ? '最終報(第${eew.head.serial}報))'
                                : '第${eew.head.serial}報)'),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: maxIntensity.color.withAlpha(100),
                    //color: const Color.fromARGB(255, 241, 230, 127),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '予想最大震度',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            eew.body.intensity?.maxInt ?? '不明',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CaskaydiaCove',
                            ),
                            textScaleFactor: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.all(5),
              color: const Color(0xFFCFE9F8),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      eew.body.earthquake.hypocenter.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'M${eew.body.earthquake.magnitude ?? '不明'} '
                      '深さ${(eew.body.earthquake.hypocenter.depth != null) ? (eew.body.earthquake.hypocenter.depth != 0) ? '${eew.body.earthquake.hypocenter.depth}km' : 'ごく浅い' : '不明'}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd HH:mm頃')
                          .format(eew.body.earthquake.originTime.toLocal()),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            await showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  '深さ精度値: ${eew.body.earthquake.accuracy.depthCalculation.description}\n'
                                  'M精度値: ${eew.body.earthquake.accuracy.magnitudeCalculation.description}\n'
                                  'M計算使用観測点数:${eew.body.earthquake.accuracy.numberOfMagnitudeCalculation.description}\n'
                                  '震央位置: ${eew.body.earthquake.accuracy.epicCenterAccuracy.epicCenterAccuracy.description}\n'
                                  '震源位置: ${eew.body.earthquake.accuracy.epicCenterAccuracy.hypoCenterAccuracy.description}\n',
                                ),
                              ),
                            );
                          },
                          child: const Text('精度情報'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(5),
      color: (eew.body.warningFlag)
          ? const Color.fromARGB(240, 147, 28, 6)
          : const Color.fromARGB(238, 255, 64, 0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 221, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: AutoSizeText(
                      (eew.body.warningFlag) ? 'EEW(警報)' : 'EEW(予報)',
                      group: headGroup,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 206, 0, 0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: AutoSizeText(
                    (eew.body.endFlag)
                        ? '最終報(第${eew.head.serial}報)'
                        : '第${eew.head.serial}報',
                    group: headGroup,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                AutoSizeText(
                  '${eew.body.earthquake.hypocenter.name}で地震',
                  group: headGroup,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '予想最大震度',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                          '${(eew.body.intensity != null) ? '${eew.body.intensity!.maxInt}.PNG' : 'unknown.PNG'}',
                          height: Get.height * 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            AutoSizeText(
                              '深さ${(eew.body.earthquake.hypocenter.depth != null) ? (eew.body.earthquake.hypocenter.depth != 0) ? '${eew.body.earthquake.hypocenter.depth}km' : 'ごく浅い' : '不明'}',
                              style: context.textTheme.headline5!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              group: depthAndMagnitudeGroup,
                            ),
                            AutoSizeText(
                              'マグニチュード:${(eew.body.earthquake.magnitude != null) ? eew.body.earthquake.magnitude.toString() : '不明'}',
                              style: context.textTheme.headline5!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              group: depthAndMagnitudeGroup,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                '発生時刻: '
                                '${DateFormat("yyyy/MM/dd HH:mm:ss頃").format(eew.body.earthquake.originTime.toLocal())}\n'
                                '地震発生から${now.difference(eew.body.earthquake.originTime).inSeconds}秒経過',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }*/
}
