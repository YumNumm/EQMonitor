import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ShindoDbStationDetailSheet extends StatelessWidget {
  const new({required this.station, super.key});

  final ShindoDbStationNode station;

  @override
  Widget build(BuildContext context) {
    final record = station.record;
    final maxAccel = record.maxAcceleration;
    final periods = record.periods;

    return SafeArea(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList.list(
              children: [
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: context.designSystem.colorTheme.onSurfaceVariant
                          .withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                _Header(station: station),
                const SizedBox(height: 12),
                _InfoRows(record: record),
                if (maxAccel != null) ...[
                  const SizedBox(height: 16),
                  _MaxAccelTable(
                    maxAccel: maxAccel,
                    maxAccelTime: record.maxAccelTime,
                  ),
                ],
                if (periods != null) ...[
                  const SizedBox(height: 16),
                  _PeriodsTable(periods: periods),
                ],
                const SizedBox(height: 16),
                const _RelatedLinksCard(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const new({required this.station});

  final ShindoDbStationNode station;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final record = station.record;
    final historicalDesc = record.intensityClass.historicalDescription;

    return Row(
      crossAxisAlignment: .start,
      children: [
        ShindoDbIntensityClassIcon(
          intensityClass: record.intensityClass,
          size: 44,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                station.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: .bold,
                  fontFamily: FontFamily.notoSansJP,
                ),
              ),
              if (record.instrumentalIntensity case final ii?)
                Text(
                  '計測震度 ${ii.toStringAsFixed(1)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                    fontFamily: FontFamily.googleSansCode,
                    fontFamilyFallback: const [FontFamily.notoSansJP],
                  ),
                ),
              if (historicalDesc != null)
                Text(
                  historicalDesc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                    fontFamily: FontFamily.notoSansJP,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRows extends StatelessWidget {
  const new({required this.record});

  final EarthquakeCatalogStationRecord record;

  @override
  Widget build(BuildContext context) {
    final observedAt = record.observedAt;
    final observationCount = record.observationCount;

    if (observedAt == null && observationCount == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        if (observedAt != null)
          _InfoRow(
            label: '観測時刻',
            value: observedAt.formatWithTz(
              DateTimeFormat.yearMonthDayHourMinuteSecond,
            ),
          ),
        if (observationCount != null)
          _InfoRow(label: '観測回数', value: '$observationCount 回'),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const new({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
                fontFamily: FontFamily.notoSansJP,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: const [FontFamily.notoSansJP],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaxAccelTable extends StatelessWidget {
  const new({required this.maxAccel, required this.maxAccelTime});

  final EarthquakeCatalogMaxAcceleration maxAccel;
  final DateTime? maxAccelTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String galText(double? gal) =>
        gal != null ? '${gal.toStringAsFixed(2)}gal' : '-';

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '最大加速度',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: .bold,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(
            color: context.designSystem.colorTheme.outlineVariant,
            borderRadius: BorderRadius.circular(context.designSystem.shape.sm),
          ),
          defaultVerticalAlignment: .middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: context.designSystem.colorTheme.surfaceContainerHighest,
              ),
              children: [
                const _TableCell(text: '合成', isHeader: true),
                const _TableCell(text: '南北', isHeader: true),
                const _TableCell(text: '東西', isHeader: true),
                const _TableCell(text: '上下', isHeader: true),
              ],
            ),
            TableRow(
              children: [
                _TableCell(text: galText(maxAccel.synthesizedGal)),
                _TableCell(text: galText(maxAccel.nsGal)),
                _TableCell(text: galText(maxAccel.ewGal)),
                _TableCell(text: galText(maxAccel.udGal)),
              ],
            ),
          ],
        ),
        if (maxAccelTime case final accelTime?) ...[
          const SizedBox(height: 4),
          Text(
            '最大加速度時刻: ${accelTime.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecond)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
            ),
          ),
        ],
      ],
    );
  }
}

class _PeriodsTable extends StatelessWidget {
  const new({required this.periods});

  final EarthquakeCatalogPeriods periods;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rows = <({String label, EarthquakeCatalogPeriodComponent component})>[
      if (periods.ns case final ns?) (label: 'NS', component: ns),
      if (periods.ew case final ew?) (label: 'EW', component: ew),
      if (periods.ud case final ud?) (label: 'UD', component: ud),
    ];

    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          '周期',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: .bold,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(
            color: context.designSystem.colorTheme.outlineVariant,
            borderRadius: BorderRadius.circular(context.designSystem.shape.sm),
          ),
          defaultVerticalAlignment: .middle,
          columnWidths: const {0: IntrinsicColumnWidth()},
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: context.designSystem.colorTheme.surfaceContainerHighest,
              ),
              children: [
                const _TableCell(text: '成分', isHeader: true),
                const _TableCell(text: '最大加速度周期', isHeader: true),
                const _TableCell(text: '卓越周期', isHeader: true),
              ],
            ),
            ...rows.map(
              (row) => TableRow(
                children: [
                  _TableCell(text: row.label, isHeader: true),
                  _TableCell(text: row.component.maxAccelPeriodText ?? '-'),
                  _TableCell(text: row.component.predominantPeriodText ?? '-'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  const new({required this.text, this.isHeader = false});

  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Center(
          child: Text(
            text,
            textAlign: .center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: isHeader ? .bold : null,
              color: context.designSystem.colorTheme.onSurface,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
            ),
          ),
        ),
      ),
    );
  }
}

class _RelatedLinksCard extends StatelessWidget {
  const new();

  static const List<({String title, String url})> _links = [
    (
      title: '気象庁 震度データベース検索',
      url: 'https://www.data.jma.go.jp/svd/eqdb/index.html',
    ),
    (
      title: '震度データについて(地震月報カタログ編)',
      url: 'https://www.data.jma.go.jp/eqev/data/bulletin/shindo.html',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: context.designSystem.colorTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '気象庁ホームページ',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: .bold,
                      color: context.designSystem.colorTheme.onSurfaceVariant,
                      fontFamily: FontFamily.notoSansJP,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._links.map(
              (link) => InkWell(
                onTap: () => launchUrl(Uri.parse(link.url)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    link.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: context.designSystem.colorTheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: context.designSystem.colorTheme.primary,
                      fontFamily: FontFamily.notoSansJP,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
