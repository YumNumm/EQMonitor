import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/earthquake_history/viewmodel/earthquake_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryDetailsPage extends ConsumerWidget {
  EarthquakeHistoryDetailsPage({
    required this.eventId,
    super.key,
  }) : super() {
    mapKey = GlobalKey(debugLabel: 'eq-history-details-$eventId');
  }

  late final mapKey;

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
        title: Text(eventId.toString()),
      ),
      body: SingleChildScrollView(
        child: Text(
          data.toString(),
        ),
      ),
    );
  }
}
