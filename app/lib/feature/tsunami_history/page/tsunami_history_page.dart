import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/tsunami_history/data/tsunami_summary.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_models.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TsunamiHistoryPage extends HookConsumerWidget {
  const TsunamiHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tsunamiAsync = ref.watch(tsunamiSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('津波情報'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async => ref.refresh(tsunamiSummaryProvider),
          ),
        ],
      ),
      body: tsunamiAsync.when(
        data: (data) => _TsunamiList(data: data),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('エラーが発生しました'),
              const SizedBox(height: 8),
              Text(error.toString()),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.refresh(tsunamiSummaryProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TsunamiList extends StatelessWidget {
  const _TsunamiList({required this.data});

  final List<TsunamiEvent> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.tsunami, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('津波情報がありません'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final event = data[index];
        return _TsunamiEventCard(event: event);
      },
    );
  }
}

class _TsunamiEventCard extends StatelessWidget {
  const _TsunamiEventCard({required this.event});

  final TsunamiEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 津波警報レベルを取得
    final warningLevel = event.highestWarning;
    final warningColor = warningLevel?.color ?? TsunamiWarningColor.grey;
    final displayName = warningLevel?.displayName ?? '情報なし';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () async =>
            TsunamiDetailsRoute($extra: event).push<void>(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ヘッダー部分
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getWarningColor(warningColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 有効期限切れの表示
                  if (event.isExpired)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '期限切れ',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  if (event.isExpired) const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.headline ?? 'ヘッドラインなし',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: event.isExpired ? Colors.grey : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // 情報詳細
              _buildInfoRow('イベントID', event.eventId),
              _buildInfoRow('発表時刻', _formatDateTime(event.pressAt)),
              _buildInfoRow('報告時刻', _formatDateTime(event.reportAt)),
              if (event.validAt != null)
                _buildInfoRow(
                  '有効期限',
                  '${_formatDateTime(event.validAt!)}${event.isExpired ? ' (期限切れ)' : ''}',
                ),
              _buildInfoRow('情報種別', event.infoType),
              _buildInfoRow('状態', event.status),

              // 津波データの種類
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  if (event.info != null) _buildTypeChip('津波情報', Colors.orange),
                  if (event.observationInfo != null)
                    _buildTypeChip('沖合観測', Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getWarningColor(TsunamiWarningColor warningColor) {
    return switch (warningColor) {
      TsunamiWarningColor.purple => Colors.purple,
      TsunamiWarningColor.red => Colors.red,
      TsunamiWarningColor.yellow => Colors.orange,
      TsunamiWarningColor.blue => Colors.blue,
      TsunamiWarningColor.grey => Colors.grey,
    };
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.month.toString().padLeft(2, '0')}/'
        '${local.day.toString().padLeft(2, '0')} '
        '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}
