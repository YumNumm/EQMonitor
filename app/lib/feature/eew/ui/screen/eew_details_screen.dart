import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewDetailsByEventIdPage extends HookConsumerWidget {
  const EewDetailsByEventIdPage({
    required this.eventId,
    super.key,
  });

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewsAsyncValue = ref.watch(eewsByEventIdProvider(eventId));

    return Scaffold(
      appBar: AppBar(
        title: Text('緊急地震速報 詳細 ($eventId)'),
      ),
      body: eewsAsyncValue.when(
        data: _buildEewList,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }

  Widget _buildEewList(List<EewV1> eews) {
    if (eews.isEmpty) {
      return const Center(
        child: Text('データがありません'),
      );
    }

    return ListView.builder(
      itemCount: eews.length,
      itemBuilder: (context, index) {
        final eew = eews[index];
        return _EewCard(eew: eew);
      },
    );
  }
}

class _EewCard extends StatelessWidget {
  const _EewCard({
    required this.eew,
  });

  final EewV1 eew;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final originTime =
        eew.originTime != null ? dateFormat.format(eew.originTime!) : '不明';
    final reportTime = dateFormat.format(eew.reportTime);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '第${eew.serialNo}報',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('発生時刻: $originTime'),
            Text('報告時刻: $reportTime'),
            Text('震源地: ${eew.hypoName ?? "不明"}'),
            Text('深さ: ${eew.depth}km'),
            Text('マグニチュード: ${eew.magnitude}'),
            Text('最大予測震度: ${eew.forecastMaxIntensity?.toString() ?? '不明'}'),
            if (eew.isWarning ?? false)
              const Chip(
                label: Text('警報'),
                backgroundColor: Colors.red,
                labelStyle: TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
