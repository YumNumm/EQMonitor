import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/tsunami_history/data/tsunami_summary.dart';
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
        data: (data) => _TsunamiList(data: data.data),
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

  final List<TsunamiGroupedByEvent> data;

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
        final group = data[index];
        return _TsunamiGroupCard(group: group);
      },
    );
  }
}

class _TsunamiGroupCard extends StatelessWidget {
  const _TsunamiGroupCard({required this.group});

  final TsunamiGroupedByEvent group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 最新の津波データを取得
    final latestData = _getLatestTsunamiData();
    if (latestData == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    color: _getTsunamiTypeColor(latestData.type),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getTsunamiTypeShort(latestData.type),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    latestData.headline ?? 'ヘッドラインなし',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 情報詳細
            _buildInfoRow('イベントID', group.eventId),
            _buildInfoRow('発表時刻', _formatDateTime(latestData.pressAt)),
            _buildInfoRow('報告時刻', _formatDateTime(latestData.reportAt)),
            _buildInfoRow('情報種別', latestData.infoType),
            _buildInfoRow('状態', latestData.status),

            // 津波データの種類
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                if (group.vtse41 != null) _buildTypeChip('警報・注意報', Colors.red),
                if (group.vtse51 != null) _buildTypeChip('津波情報', Colors.orange),
                if (group.vtse52 != null) _buildTypeChip('沖合観測', Colors.blue),
              ],
            ),
          ],
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

  // 最新の津波データを取得（優先度: vtse41 > vtse51 > vtse52）
  ({
    int id,
    int eventId,
    int? serialNo,
    String type,
    String status,
    String? headline,
    String infoType,
    DateTime pressAt,
    DateTime reportAt,
    DateTime? validAt,
  })?
  _getLatestTsunamiData() {
    if (group.vtse41 != null) {
      final data = group.vtse41!;
      return (
        id: data.id,
        eventId: data.eventId,
        serialNo: data.serialNo,
        type: '津波警報・注意報・予報a',
        status: data.status,
        headline: data.headline,
        infoType: data.infoType,
        pressAt: data.pressAt,
        reportAt: data.reportAt,
        validAt: data.validAt,
      );
    }
    if (group.vtse51 != null) {
      final data = group.vtse51!;
      return (
        id: data.id,
        eventId: data.eventId,
        serialNo: data.serialNo,
        type: '津波情報a',
        status: data.status,
        headline: data.headline,
        infoType: data.infoType,
        pressAt: data.pressAt,
        reportAt: data.reportAt,
        validAt: data.validAt,
      );
    }
    if (group.vtse52 != null) {
      final data = group.vtse52!;
      return (
        id: data.id,
        eventId: data.eventId,
        serialNo: data.serialNo,
        type: '沖合の津波観測に関する情報',
        status: data.status,
        headline: data.headline,
        infoType: '発表', // VTSE52では固定値
        pressAt: DateTime.now(), // VTSE52では現在時刻（表示用）
        reportAt: DateTime.now(), // VTSE52では現在時刻（表示用）
        validAt: null, // VTSE52ではnull
      );
    }
    return null;
  }

  String _getTsunamiTypeShort(String type) {
    return switch (type) {
      '津波警報・注意報・予報a' => '警報・注意報',
      '津波情報a' => '津波情報',
      '沖合の津波観測に関する情報' => '沖合観測',
      _ => type,
    };
  }

  Color _getTsunamiTypeColor(String type) {
    return switch (type) {
      '津波警報・注意報・予報a' => Colors.red,
      '津波情報a' => Colors.orange,
      '沖合の津波観測に関する情報' => Colors.blue,
      _ => Colors.grey,
    };
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
