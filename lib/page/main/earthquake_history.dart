import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/intensity/intensity_widget.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/remote_db/telegram.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = MediaQuery.of(context).size.width;
    final earthquakeHistory = ref.watch(earthquakeHistoryController);
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: earthquakeHistory.telegramsGroupByEventId.length,
        itemBuilder: (context, index) {
          final key =
              earthquakeHistory.telegramsGroupByEventId.keys.elementAt(index);
          final telegrams = earthquakeHistory.telegramsGroupByEventId[key]!;
          final vxse53 = telegrams.firstWhere(
            (element) => element.type == 'VXSE53',
          );
          final magnitude = (vxse53.magnitudeCondition != null)
              ? vxse53.magnitudeCondition!.description
              : (vxse53.magnitude != null)
                  ? vxse53.magnitude.toString()
                  : 'M不明';
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 50),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                      color: (vxse53.maxint?.color ?? Colors.white)
                          .withOpacity(0.7),
                    ),
                    child: Row(
                      children: [
                        IntensityWidget(
                          intensity: vxse53.maxint ?? JmaIntensity.Error,
                          size: 60,
                        ),
                        // 地震情報
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 震源地
                            Text(
                              (vxse53.hypoName ?? '') + magnitude,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('\n\naaa')
                          ],
                        )
                      ],
                    ),
                  ),
                 
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
