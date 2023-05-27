import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/eq_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsPage extends ConsumerWidget {
  const EarthquakeHistoryDetailsPage({
    required this.eventId,
    super.key,
  });

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 当該データがアレばOK
    final data = ref
        .watch(earthquakeHistoryViewModelProvider)
        .value
        ?.firstWhereOrNull((e) => e.eventId == eventId);
    if (data == null) {
      return const Scaffold(
        body: Center(
          child: Text('当該データが見つかりませんでした\n再度地震の履歴を読み込んでください'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data.earthquake.earthquake?.hypocenter.name ?? ''} "
          'M${data.earthquake.earthquake?.magnitude.value ?? ''} '
          '${data.earthquake.earthquake?.hypocenter.depth ?? ''}km',
        ),
      ),
      body: Stack(
        children: [
          EarthquakeHistoryMap(item: data),
        ],
      ),
    );
  }
}
