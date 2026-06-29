import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LpgmStationDetailSheet extends ConsumerWidget {
  const LpgmStationDetailSheet({
    required this.station,
    super.key,
  });

  final StationLpgmIntensityNode station;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorModel = ref.watch(intensityColorProvider);
    final intensity = station.intensity;
    final prePeriods = intensity?.prePeriods;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            _Header(station: station),
            if (prePeriods != null && prePeriods.isNotEmpty) ...[
              const SizedBox(height: 16),
              _PrePeriodsTable(
                prePeriods: prePeriods,
                colorModel: colorModel,
              ),
            ],
            const SizedBox(height: 16),
            const _RelatedLinksCard(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.station});

  final StationLpgmIntensityNode station;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final intensity = station.intensity;
    final maxLpgmIntensity = intensity?.maxLpgmIntensity;
    final sva = intensity?.sva;

    return Row(
      children: [
        if (maxLpgmIntensity != null) ...[
          JmaLpgmIntensityIcon(
            intensity: maxLpgmIntensity,
            type: IntensityIconType.filled,
            size: 44,
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                station.station.name.ja,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.notoSansJP,
                ),
              ),
              if (sva != null)
                Text(
                  '最大 ${sva.toStringAsFixed(1)} cm/s',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrePeriodsTable extends StatelessWidget {
  const _PrePeriodsTable({
    required this.prePeriods,
    required this.colorModel,
  });

  final List<PrePeriod> prePeriods;
  final IntensityColorModel colorModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = [...prePeriods]
      ..sort((a, b) => a.band.compareTo(b.band));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '周期別階級',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(
            color: theme.colorScheme.outlineVariant,
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              children: [
                _headerCell('周期', theme),
                ...sorted.map(
                  (p) => _headerCell('${p.band.toInt()}秒台', theme),
                ),
              ],
            ),
            TableRow(
              children: [
                _headerCell('階級', theme),
                ...sorted.map(
                  (p) => _intensityCell(p.lpgmIntensity, theme),
                ),
              ],
            ),
            TableRow(
              children: [
                _headerCell('SVA', theme),
                ...sorted.map(
                  (p) => _svaCell(p.sva, theme),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '※ SVA: 絶対速度応答スペクトル (cm/s)',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text, ThemeData theme) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Center(
          child: Text(
            text,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
        ),
      ),
    );
  }

  Widget _intensityCell(JmaLpgmIntensity intensity, ThemeData theme) {
    final color = colorModel.fromJmaLpgmIntensity(intensity);
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        color: color.background,
        child: Center(
          child: Text(
            intensity.label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color.foreground,
              fontFamily: FontFamily.googleSansCode,
            ),
          ),
        ),
      ),
    );
  }

  Widget _svaCell(double sva, ThemeData theme) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Center(
          child: Text(
            sva.toStringAsFixed(1),
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: FontFamily.googleSansCode,
            ),
          ),
        ),
      ),
    );
  }
}

class _RelatedLinksCard extends StatelessWidget {
  const _RelatedLinksCard();

  static const List<({String title, String url})> _links = [
    (
      title: '長周期地震動階級および長周期地震動階級関連解説表について',
      url:
          'https://www.jma.go.jp/jma/kishou/know/jishin/ltpgm_explain/about_level.html',
    ),
    (
      title: '固有周期と建物の関係について',
      url:
          'https://www.jma.go.jp/jma/kishou/know/jishin/ltpgm_explain/about_period.html',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '気象庁ホームページ',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontFamily: FontFamily.notoSansJP,
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
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.colorScheme.primary,
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
