import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LpgmStationDetailSheet extends ConsumerWidget {
  const new({required this.station, super.key});

  final StationLpgmIntensityNode station;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColors = context.designSystem.colorTheme.intensity;
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
                  color: context.designSystem.colorTheme.onSurfaceVariant
                      .withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            _Header(station: station),
            if (prePeriods != null && prePeriods.isNotEmpty) ...[
              const SizedBox(height: 16),
              _PrePeriodsTable(
                prePeriods: prePeriods,
                intensityColors: intensityColors,
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
  const new({required this.station});

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
                    color: context.designSystem.colorTheme.onSurfaceVariant,
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
  const new({
    required this.prePeriods,
    required this.intensityColors,
  });

  final List<PrePeriod> prePeriods;
  final IntensityColors intensityColors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = [...prePeriods]..sort((a, b) => a.band.compareTo(b.band));

    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(
          '長周期地震動の周期別階級',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
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
                _headerCell('周期', theme, context),
                ...sorted.map(
                  (p) => _headerCell('${p.band.toInt()}秒台', theme, context),
                ),
              ],
            ),
            TableRow(
              children: [
                _headerCell('階級', theme, context),
                ...sorted.map((p) {
                  final entry = intensityColors.fromJmaLpgmIntensity(
                    p.lpgmIntensity,
                  );
                  return TableCell(
                    verticalAlignment: .fill,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 4,
                      ),
                      color: entry.background,
                      child: Center(
                        child: Text(
                          p.lpgmIntensity.label,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: entry.resolvedForeground,
                            fontFamily: FontFamily.googleSansCode,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            TableRow(
              children: [
                _headerCell('SVA', theme, context),
                ...sorted.map((p) => _svaCell(p.sva, theme, context)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '※ SVA: 絶対速度応答スペクトル (cm/s)',
          style: theme.textTheme.labelSmall?.copyWith(
            color: context.designSystem.colorTheme.onSurface,
            fontFamily: FontFamily.googleSansCode,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String text, ThemeData theme, BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Center(
          child: Text(
            text,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: [FontFamily.notoSansJP],
              color: context.designSystem.colorTheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _svaCell(double sva, ThemeData theme, BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Center(
          child: Text(
            sva.toStringAsFixed(1),
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: FontFamily.googleSansCode,
              color: context.designSystem.colorTheme.onSurface,
              fontFamilyFallback: [FontFamily.notoSansJP],
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
                  color: context.designSystem.colorTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '気象庁ホームページ',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.designSystem.colorTheme.onSurfaceVariant,
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
