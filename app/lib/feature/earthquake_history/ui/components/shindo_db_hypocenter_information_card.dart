import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShindoDbHypocenterInformationCard extends StatelessWidget {
  const ShindoDbHypocenterInformationCard({
    required this.catalog,
    required this.originTime,
    super.key,
  });

  final EarthquakeCatalog catalog;
  final DateTime? originTime;

  @override
  Widget build(BuildContext context) {
    final hypocenters = catalog.hypocenters;
    if (hypocenters.isEmpty) {
      return const SizedBox.shrink();
    }

    final primary = hypocenters.firstWhere(
      (h) => h.seq == 0,
      orElse: () => hypocenters.first,
    );

    final intensityColors = context.designSystem.colorTheme.intensity;
    final colorJma = primary.maxIntensity?.colorJmaIntensity;
    final cardBackgroundColor = colorJma != null
        ? intensityColors.fromJmaIntensity(colorJma).background
        : Colors.grey;
    final cardColor = cardBackgroundColor.withValues(alpha: 0.3);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ).add(const EdgeInsets.only(bottom: 4)),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBackgroundColor, width: 0),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (primary.maxIntensity != null) ...[
                  _MaxIntensityWidget(hypocenter: primary),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: _PrimaryHypocenterBody(
                    hypocenter: primary,
                    originTime: originTime,
                  ),
                ),
              ],
            ),
            _DetailsTile(catalog: catalog, primary: primary),
          ],
        ),
      ),
    );
  }
}

class _MaxIntensityWidget extends StatelessWidget {
  const _MaxIntensityWidget({required this.hypocenter});

  final EarthquakeCatalogHypocenter hypocenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        ShindoDbIntensityClassIcon(
          intensityClass: hypocenter.maxIntensity!,
          size: 60,
        ),
      ],
    );
  }
}

class _PrimaryHypocenterBody extends StatelessWidget {
  const _PrimaryHypocenterBody({
    required this.hypocenter,
    required this.originTime,
  });

  final EarthquakeCatalogHypocenter hypocenter;
  final DateTime? originTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOriginTime = hypocenter.originTime ?? originTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MagnitudeRow(magnitudes: hypocenter.magnitudes),
        if (hypocenter.depthKm != null) _DepthRow(hypocenter: hypocenter),
        Text(
          hypocenter.epicenterName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
        if (effectiveOriginTime != null)
          _OriginTimeRow(
            originTime: effectiveOriginTime,
            stderrSeconds: hypocenter.originTimeStderrSeconds,
          ),
      ],
    );
  }
}

class _MagnitudeRow extends StatelessWidget {
  const _MagnitudeRow({required this.magnitudes});

  final List<EarthquakeCatalogMagnitude> magnitudes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (magnitudes.isEmpty) {
      return Text(
        'M不明',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: const [FontFamily.notoSansJP],
        ),
      );
    }

    final first = magnitudes.first;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 4,
      children: [
        Text(
          'M${first.value.toStringAsFixed(1)}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.googleSansCode,
            fontFamilyFallback: const [FontFamily.notoSansJP],
          ),
        ),
        Text(
          first.typeLabel,
          style: theme.textTheme.bodySmall?.copyWith(
            color: context.designSystem.colorTheme.onSurfaceVariant,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
      ],
    );
  }
}

class _DepthRow extends StatelessWidget {
  const _DepthRow({required this.hypocenter});

  final EarthquakeCatalogHypocenter hypocenter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stderr = hypocenter.depthStderrKm;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 4,
      children: [
        Text(
          '深さ ${hypocenter.depthKm!.toStringAsFixed(0)}km',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.googleSansCode,
            fontFamilyFallback: const [FontFamily.notoSansJP],
          ),
        ),
        if (stderr != null)
          Text(
            '±${stderr.toStringAsFixed(1)}km',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
            ),
          ),
        if (hypocenter.depthIsFree)
          Text(
            '(深さフリー)',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
      ],
    );
  }
}

class _OriginTimeRow extends StatelessWidget {
  const _OriginTimeRow({required this.originTime, required this.stderrSeconds});

  final DateTime originTime;
  final double? stderrSeconds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm頃');

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 4,
      children: [
        Text(
          dateFormat.format(originTime.toLocal()),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.googleSansCode,
            fontFamilyFallback: const [FontFamily.notoSansJP],
          ),
        ),
        if (stderrSeconds != null)
          Text(
            '±${stderrSeconds!.toStringAsFixed(0)}秒',
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.designSystem.colorTheme.onSurfaceVariant,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
            ),
          ),
      ],
    );
  }
}

class _DetailsTile extends StatelessWidget {
  const _DetailsTile({required this.catalog, required this.primary});

  final EarthquakeCatalog catalog;
  final EarthquakeCatalogHypocenter primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final others = catalog.hypocenters.where((h) => h != primary).toList();

    return ExpansionTile(
      title: Text(
        '詳細',
        style: theme.textTheme.bodySmall?.copyWith(
          fontFamily: FontFamily.notoSansJP,
        ),
      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: [
        _InfoRow(label: 'レコード種別', value: primary.recordTypeLabel),
        if (primary.determinationFlagLabel != null)
          _InfoRow(label: '決定フラグ', value: primary.determinationFlagLabel!),
        if (primary.evaluationLabel != null)
          _InfoRow(label: '震源評価', value: primary.evaluationLabel!),
        _InfoRow(label: '観測点数', value: '${primary.stationCount}'),
        ...primary.magnitudes.map(
          (m) => _InfoRow(
            label: m.typeLabel,
            value: 'M${m.value.toStringAsFixed(1)}',
          ),
        ),
        for (final (i, h) in others.indexed)
          _HypocenterSection(index: i + 2, hypocenter: h),
        if (catalog.linkMatchConfidence != null)
          _InfoRow(
            label: '照合信頼度',
            value:
                '${(catalog.linkMatchConfidence! * 100).toStringAsFixed(0)}%',
          ),
      ],
    );
  }
}

class _HypocenterSection extends StatelessWidget {
  const _HypocenterSection({required this.index, required this.hypocenter});

  final int index;
  final EarthquakeCatalogHypocenter hypocenter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '震源 $index',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
        ),
        _InfoRow(label: 'レコード種別', value: hypocenter.recordTypeLabel),
        if (hypocenter.determinationFlagLabel != null)
          _InfoRow(label: '決定フラグ', value: hypocenter.determinationFlagLabel!),
        if (hypocenter.evaluationLabel != null)
          _InfoRow(label: '震源評価', value: hypocenter.evaluationLabel!),
        _InfoRow(label: '観測点数', value: '${hypocenter.stationCount}'),
        ...hypocenter.magnitudes.map(
          (m) => _InfoRow(
            label: m.typeLabel,
            value: 'M${m.value.toStringAsFixed(1)}',
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

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
            width: 96,
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
