import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../api/db/telegram.dart';

class EarthquakeHistoryPage extends HookConsumerWidget {
  EarthquakeHistoryPage({super.key});

  final TelegramApi telegramApi = TelegramApi();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earthquakeHistory = ref.watch(earthquakeHistoryNotifier);
    return ListView.builder(
      itemCount: earthquakeHistory.telegramsGroupByEventId.length,
      itemBuilder: (context, index) {
        final key =
            earthquakeHistory.telegramsGroupByEventId.keys.elementAt(index);
        final telegrams = earthquakeHistory.telegramsGroupByEventId[key]!;
        return ListTile(
          tileColor: (telegrams
                      .lastWhere(
                        (element) => element.type == 'VXSE53',
                      )
                      .maxint ??
                  JmaIntensity.Error)
              .color,
          textColor: (telegrams
                          .lastWhere(
                            (element) => element.type == 'VXSE53',
                          )
                          .maxint ??
                      JmaIntensity.Error)
                  .shouldTextBlack
              ? Colors.black
              : Colors.white,
          enableFeedback: true,
          title: Text(
            "$key 最大震度${(telegrams.lastWhere(
                  (element) => element.type == 'VXSE53',
                ).maxint ?? JmaIntensity.Error).name}",
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            telegrams
                .map(
                  (telegram) =>
                      '${telegram.type} ${telegram.id} ${telegram.headline}',
                )
                .join('\n'),
            style: const TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }
}
