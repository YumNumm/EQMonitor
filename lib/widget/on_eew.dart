import 'package:auto_size_text/auto_size_text.dart';
import 'package:eqmonitor/utils/svir/svirResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnEEWWidget extends StatelessWidget {
  OnEEWWidget({
    Key? key,
    required this.eew,
    required this.now,
  }) : super(key: key);

  final SvirResponse eew;
  final DateTime now;
  final headGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(5),
      color: (eew.body.warningFlag)
          ? const Color.fromARGB(240, 147, 28, 6)
          : Color.fromARGB(237, 255, 126, 20),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
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
                          'assets/intensity/${(eew.body.intensity != null) ? '${eew.body.intensity!.maxInt}.PNG' : 'unknown.PNG'}',
                          height: Get.height * 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '深さ',
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    (eew.body.earthquake.hypocenter.depth !=
                                            null)
                                        ? (eew.body.earthquake.hypocenter
                                                    .depth !=
                                                0)
                                            ? '${eew.body.earthquake.hypocenter.depth}km'
                                            : 'ごく浅い'
                                        : '不明',
                                    style: context.textTheme.displaySmall!
                                        .copyWith(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'マグニチュード',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  (eew.body.earthquake.magnitude != null)
                                      ? eew.body.earthquake.magnitude.toString()
                                      : '不明',
                                  style:
                                      context.textTheme.displaySmall!.copyWith(
                                    color: Colors.black,
                                  ),
                                )
                              ],
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
  }
}
