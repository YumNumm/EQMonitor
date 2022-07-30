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
    final earthquakeHistory = ref.watch(earthquakeHistoryController);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: earthquakeHistory.telegramsGroupByEventId.length,
      itemBuilder: (context, index) {
        final key =
            earthquakeHistory.telegramsGroupByEventId.keys.elementAt(index);
        final telegrams = earthquakeHistory.telegramsGroupByEventId[key]!;
        final vxse53 = telegrams.firstWhere(
          (element) => element.type == 'VXSE53',
        );
        return ListTile(
          /*leading: Container(
            color: (vxse53.maxint ?? JmaIntensity.Error).color,
            child: Text(
              (vxse53.maxint ?? JmaIntensity.Error).name,
              style: const TextStyle(fontSize: 18),
            ),
          ),*/
          tileColor: (vxse53.maxint != JmaIntensity.Int1)
              ? (vxse53.maxint ?? JmaIntensity.Error).color.withOpacity(0.3)
              : null,
          enableFeedback: true,
          title: Text(
            (vxse53.hypoName ?? '不明') +
                ' ' +
                ('最大震度${(vxse53.maxint ?? JmaIntensity.Error).name}'),
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            telegrams
                .map(
                  (telegram) => '${telegram.type} ${telegram.headline}',
                )
                .join('\n'),
            style: const TextStyle(fontSize: 14),
          ),
        );
      },
    );
  }
}
