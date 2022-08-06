import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/state/theme_providers.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../api/remote_db/telegram.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = MediaQuery.of(context).size.width;
    final earthquakeHistory = ref.watch(earthquakeHistoryController);
    final isDarkmode = ref.watch(themeController.notifier).isDarkMode;
    return AnimationLimiter(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
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
              delay: const Duration(milliseconds: 20),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: (vxse53.maxint != JmaIntensity.Int1)
                          ? (vxse53.maxint ?? JmaIntensity.Error)
                              .color
                              .withOpacity(0.3)
                          : null,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 42,
                          height: 42,
                          color: (vxse53.maxint ?? JmaIntensity.Error).color,
                          child: Center(
                            child: Text(
                              (vxse53.maxint ?? JmaIntensity.Error).name,
                              style: TextStyle(
                                fontSize: 35,
                                color: ((vxse53.maxint ?? JmaIntensity.Error)
                                        .shouldTextBlack)
                                    ? Colors.black
                                    : Colors.white,
                                fontFamily: 'CaskaydiaCove',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      /* leading: (vxse53.maxint != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/intensity/${vxse53.maxint!.name}.PNG',
                    ),
                  )
                : const SizedBox.shrink(),*/

                      enableFeedback: true,
                      title: Text(
                        '${vxse53.hypoName ?? '不明'} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        '${DateFormat('yyyy/MM/dd HH:mm').format(vxse53.time.toLocal())}頃 '
                        '${(vxse53.magnitudeCondition != null) ? vxse53.magnitudeCondition!.description : (vxse53.magnitude != null) ? 'M${vxse53.magnitude}' : "M不明"} '
                        '深さ${(vxse53.depthCondition != null) ? (vxse53.depthCondition!.description) : (vxse53.depth != null) ? '${vxse53.depth}km' : '不明'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
