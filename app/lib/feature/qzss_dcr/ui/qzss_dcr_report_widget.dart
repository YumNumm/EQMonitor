import 'package:dart_azarashi/dart_azarashi.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/qzss_dcr/data/provider/qzss_serial_port_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QzssDcrReportWidget extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(latestQzssDcReportProvider);
    final theme = Theme.of(context);
    final designSystem = context.designSystem;

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
                color: designSystem.colorTheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                '災危通報を受信していません',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: designSystem.colorTheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'GNSS受信機を接続し、衛星からの信号を受信してください',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: designSystem.colorTheme.onSurface.withValues(
                    alpha: 0.4,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // 災害カテゴリーのテキスト変換
    final disasterCategoryText = switch (report) {
      QzssDcReportEarthquakeEarlyWarning() => '地震',
      QzssDcReportHypocenter() => '震源',
      QzssDcReportSeismicIntensity() => '震度',
      QzssDcReportTsunami() => '津波',
      QzssDcReportNorthwestPacificTsunami() => '北西太平洋津波',
      QzssDcReportVolcano() => '火山',
      QzssDcReportAshFall() => '降灰',
      QzssDcReportWeather() => '気象',
      QzssDcReportFlood() => '洪水',
      QzssDcReportTyphoon() => '台風',
      QzssDcReportMarine() => '海上',
      QzssDcReportNankaiTroughEarthquake() => '南海トラフ地震',
      QzssDcReportDcxOutsideJapan() => '海外情報',
      QzssDcReportDcxLAlert() => 'L-Alert',
      QzssDcReportDcxJAlert() => 'J-Alert',
      QzssDcReportDcxMTInfo() => 'Municipality-Transmitted Information',
      QzssDcReportDcxUnknown() => 'Unknown',
      QzssDcReportDcxNull() => 'DCX Null',
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
                  color: designSystem.colorTheme.primary,
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
            // 衛星ID
            _InfoRow(
              label: '衛星ID',
              value: 'QZS-${report.satelliteId}',
              icon: Icons.satellite,
            ),

            // 受信時刻（現在時刻）
            _InfoRow(
              label: '受信時刻',
              value: DateTime.now().formatWithTz(
                .yearMonthDayHourMinuteSecond,
              ),
              icon: Icons.access_time,
            ),

            const SizedBox(height: 16),

            // デコード内容（JMAの場合）

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
  const new({
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
