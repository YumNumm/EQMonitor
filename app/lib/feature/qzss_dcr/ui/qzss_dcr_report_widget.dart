import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/qzss_serial_port_provider.dart';

class QzssDcrReportWidget extends HookConsumerWidget {
  const QzssDcrReportWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(latestQzssDcReportProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (report == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.satellite_alt,
                size: 48,
                color: colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                '災危通報を受信していません',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'GNSS受信機を接続し、衛星からの信号を受信してください',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // 災害カテゴリーのテキスト変換
    final disasterCategoryText = switch (report.disasterCategory) {
      DisasterCategory.earthquake => '地震',
      DisasterCategory.hypocenter => '震源',
      DisasterCategory.tsunami => '津波',
      DisasterCategory.northwestPacificTsunami => '北西太平洋津波',
      DisasterCategory.volcanoRelated => '火山',
      DisasterCategory.ashFall => '降灰',
      DisasterCategory.weatherRelated => '気象',
      DisasterCategory.floodRelated => '洪水',
      DisasterCategory.typhoonRelated => '台風',
      DisasterCategory.marineRelated => '海上',
      DisasterCategory.nankaiTroughEarthquakeRelated => '南海トラフ地震',
      DisasterCategory.testOrTraining => 'テスト/訓練',
      DisasterCategory.futureUse => '将来使用',
    };

    // 報告分類のテキスト変換
    final reportClassificationText = switch (report.reportClassification) {
      ReportClassification.normal => '通常',
      ReportClassification.training => '訓練',
      ReportClassification.test => 'テスト',
    };

    // 情報タイプのテキスト変換
    final informationTypeText = switch (report.informationType) {
      InformationType.issue => '発表',
      InformationType.correction => '訂正',
      InformationType.cancel => '取消',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー
            Row(
              children: [
                Icon(
                  Icons.satellite_alt,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '災危通報受信',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'クリア',
                  onPressed: () {
                    ref.read(latestQzssDcReportProvider.notifier).clear();
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            // 災害カテゴリー
            _InfoRow(
              label: 'カテゴリー',
              value: disasterCategoryText,
              icon: Icons.warning_amber,
            ),

            // 報告分類
            _InfoRow(
              label: '報告分類',
              value: reportClassificationText,
              icon: Icons.info_outline,
            ),

            // 情報タイプ
            _InfoRow(
              label: '情報タイプ',
              value: informationTypeText,
              icon: Icons.article_outlined,
            ),

            // 衛星ID
            _InfoRow(
              label: '衛星ID',
              value: 'QZS-${report.satelliteId}',
              icon: Icons.satellite,
            ),

            // 受信時刻（現在時刻）
            _InfoRow(
              label: '受信時刻',
              value: DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
              icon: Icons.access_time,
            ),

            const SizedBox(height: 16),

            // デコード内容（JMAの場合）
            if (report.jma != null) _JmaInfoCard(jma: report.jma!),

            // 生データ（デバッグ用）
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('生データ'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SelectableText(
                    report.sentence,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _JmaInfoCard extends StatelessWidget {
  const _JmaInfoCard({
    required this.jma,
  });

  final JmaReport jma;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'JMA情報',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            jma.toString(),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
