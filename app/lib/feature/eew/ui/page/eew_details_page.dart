import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewDetailsPage extends HookConsumerWidget {
  const new({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewsAsyncValue = ref.watch(eewsByEventIdProvider(eventId));

    return Scaffold(
      appBar: AppBar(title: Text('緊急地震速報 詳細 ($eventId)')),
      body: eewsAsyncValue.when(
        data: (eews) => _EewList(eews: eews),
        loading: () => const _EewDetailsPageSkeleton(),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}

class _EewList extends StatelessWidget {
  const new({required this.eews});

  final List<EewTelegramItem> eews;

  @override
  Widget build(BuildContext context) {
    if (eews.isEmpty) {
      return const AppEmptyState(
        message: 'EEW情報はありません',
        icon: Icons.warning_amber_outlined,
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

class _EewDetailsPageSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        children: [
          for (final i in List.generate(3, (i) => i))
            Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '第${i + 1}報',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text('発生時刻: 2026/04/21 12:34:56'),
                    const Text('報告時刻: 2026/04/21 12:34:58'),
                    const Text('震源地: 東京都'),
                    const Text('深さ: 10km'),
                    const Text('マグニチュード: 5.5'),
                    const Text('最大予測震度: 4'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EewCard extends StatelessWidget {
  const new({required this.eew});

  final EewTelegramItem eew;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final originTime = switch (eew.originTime) {
      final originTime? => dateFormat.format(originTime),
      null => '不明',
    };
    final reportTime = dateFormat.format(eew.reportTime);
    final hypocenter = eew.hypocenter;

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
            Text('震源地: ${hypocenter?.name ?? "不明"}'),
            Text('深さ: ${hypocenter?.depth ?? "不明"}km'),
            Text('マグニチュード: ${hypocenter?.magnitude ?? "不明"}'),
            Text(
              '最大予測震度: ${eew.forecastIntensity?.maxIntensity?.label ?? '不明'}${eew.forecastIntensity?.maxIntensityIsOver ?? false ? '程度以上' : ''}',
            ),
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
