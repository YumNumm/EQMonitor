import 'package:auto_size_text/auto_size_text.dart';
import 'package:eqmonitor/utils/svir/svirResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    print(eew.head.dateTime);
    if (eew.head.dateTime.difference(now).inSeconds >= -180) {
      return Card(
        elevation: 10,
        margin: const EdgeInsets.all(5),
        color: (eew.body.warningFlag)
            ? const Color.fromARGB(255, 209, 0, 0)
            : const Color.fromARGB(255, 255, 37, 37),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                            minFontSize: 17,
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
                          minFontSize: 17,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/intensity/${(eew.body.intensity != null) ? '${eew.body.intensity!.maxInt}.PNG' : 'unknown.PNG'}',
                  height: Get.height * 0.1,
                ),
              ),
              Text('NOW: ${now.toIso8601String()}'),
              Text('EEW: ${eew.head.dateTime.toIso8601String()}'),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
