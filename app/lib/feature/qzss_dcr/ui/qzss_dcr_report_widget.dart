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
            _buildInfoRow(
              context,
              'カテゴリー',
              _getDisasterCategoryText(report.disasterCategory),
              icon: Icons.warning_amber,
            ),

            // 報告分類
            _buildInfoRow(
              context,
              '報告分類',
              _getReportClassificationText(report.reportClassification),
              icon: Icons.info_outline,
            ),

            // 情報タイプ
            _buildInfoRow(
              context,
              '情報タイプ',
              _getInformationTypeText(report.informationType),
              icon: Icons.article_outlined,
            ),

            // 衛星ID
            _buildInfoRow(
              context,
              '衛星ID',
              'QZS-${report.satelliteId}',
              icon: Icons.satellite,
            ),

            // 受信時刻（現在時刻）
            _buildInfoRow(
              context,
              '受信時刻',
              DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
              icon: Icons.access_time,
            ),

            const SizedBox(height: 16),

            // デコード内容（JMAの場合）
            if (report.jma != null) _buildJmaInfo(context, report.jma!),

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

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    IconData? icon,
  }) {
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

  Widget _buildJmaInfo(BuildContext context, JmaReport jma) {
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

  String _getDisasterCategoryText(DisasterCategory category) {
    return switch (category) {
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
  }

  String _getReportClassificationText(ReportClassification classification) {
    return switch (classification) {
      ReportClassification.normal => '通常',
      ReportClassification.training => '訓練',
      ReportClassification.test => 'テスト',
    };
  }

  String _getInformationTypeText(InformationType type) {
    return switch (type) {
      InformationType.issue => '発表',
      InformationType.correction => '訂正',
      InformationType.cancel => '取消',
    };
  }
}
