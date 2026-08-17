import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_info_text_style.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class ShindoDbHypocenterInformationCard extends StatelessWidget {
  const new({
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
      margin: const EdgeInsets.symmetric(horizontal: 8)
          .add(const EdgeInsets.only(bottom: 4)),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBackgroundColor, width: 0),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
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
  const new({required this.hypocenter});

  final EarthquakeCatalogHypocenter hypocenter;

  @override
  Widget build(BuildContext context) {
    final maxIntensity = hypocenter.maxIntensity;
    if (maxIntensity == null) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        ShindoDbIntensityClassIcon(intensityClass: maxIntensity, size: 60),
      ],
    );
  }
}

class _PrimaryHypocenterBody extends StatelessWidget {
  const new({
    required this.hypocenter,
    required this.originTime,
  });

  final EarthquakeCatalogHypocenter hypocenter;
  final DateTime? originTime;

  @override
  Widget build(BuildContext context) {
    final effectiveOriginTime = hypocenter.originTime ?? originTime;

    final timeWidget = effectiveOriginTime != null
        ? _OriginTimeRow(
            originTime: effectiveOriginTime,
            stderrSeconds: hypocenter.originTimeStderrSeconds,
          )
        : null;

    return Wrap(
      spacing: 8,
      crossAxisAlignment: .center,
      alignment: .center,
      children: [
        const Row(),
        _MagnitudeRow(magnitudes: hypocenter.magnitudes),
        if (hypocenter.depthKm != null) _DepthRow(hypocenter: hypocenter),
        const SizedBox(width: double.infinity),
        _EpicenterWidget(epicenterName: hypocenter.epicenterName),
        const Row(),
        ?timeWidget,
      ],
    );
  }
}

class _MagnitudeRow extends StatelessWidget {
  const new({required this.magnitudes});

  final List<EarthquakeCatalogMagnitude> magnitudes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (magnitudes.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('M', style: textTheme.labelStyle(textTheme.titleSmall)),
          Text('不明', style: textTheme.valueStyle(textTheme.headlineMedium)),
        ],
      );
    }

    final first = magnitudes.first;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('M', style: textTheme.labelStyle(textTheme.titleSmall)),
            Text(
              first.value.toStringAsFixed(1),
              style: textTheme.valueStyle(textTheme.headlineLarge),
            ),
          ],
        ),
        Text(
          first.typeLabel,
          style: textTheme.bodySmall?.copyWith(
            color: context.designSystem.colorTheme.onSurfaceVariant,
            fontFamily: FontFamily.notoSansJP,
          ),
        ),
      ],
    );
  }
}

class _DepthRow extends StatelessWidget {
  const new({required this.hypocenter});

  final EarthquakeCatalogHypocenter hypocenter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final depthKm = hypocenter.depthKm;
    if (depthKm == null) {
      return const SizedBox.shrink();
    }
    final stderr = hypocenter.depthStderrKm;
    final subTextStyle = textTheme.labelStyle(textTheme.titleSmall);
    final hasSecondaryInfo = stderr != null || hypocenter.depthIsFree;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '深さ', style: subTextStyle),
              TextSpan(
                text: depthKm.toStringAsFixed(0),
                style: textTheme.valueStyle(textTheme.headlineLarge),
              ),
              TextSpan(text: 'km', style: subTextStyle),
            ],
          ),
        ),
        if (hasSecondaryInfo)
          Wrap(
            spacing: 4,
            children: [
              if (stderr != null)
                Text(
                  '±${stderr.toStringAsFixed(1)}km',
                  style: textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                    fontFamily: FontFamily.googleSansCode,
                    fontFamilyFallback: const [FontFamily.notoSansJP],
                  ),
                ),
              if (hypocenter.depthIsFree)
                Text(
                  '(深さフリー)',
                  style: textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                    fontFamily: FontFamily.notoSansJP,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _OriginTimeRow extends StatelessWidget {
  const new({required this.originTime, required this.stderrSeconds});

  final DateTime originTime;
  final double? stderrSeconds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss.SSS頃');
    final stderr = stderrSeconds;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '発生時刻: ${dateFormat.format(originTime.toLocal())}'),
          if (stderr != null) TextSpan(text: '±${stderr.toStringAsFixed(1)}秒'),
        ],
        style: theme.textTheme.bodySmall?.copyWith(
          color: context.designSystem.colorTheme.onSurfaceVariant,
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: const [FontFamily.notoSansJP],
        ),
      ),
    );
  }
}

class _EpicenterWidget extends StatelessWidget {
  const new({required this.epicenterName});

  final String epicenterName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      textBaseline: .ideographic,
      mainAxisSize: .min,
      crossAxisAlignment: .baseline,
      children: [
        Text('震源地', style: textTheme.labelStyle(textTheme.bodySmall)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            epicenterName,
            style: textTheme.valueStyle(textTheme.headlineSmall),
          ),
        ),
      ],
    );
  }
}

class _DetailsTile extends StatelessWidget {
  const new({required this.catalog, required this.primary});

  final EarthquakeCatalog catalog;
  final EarthquakeCatalogHypocenter primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final others = catalog.hypocenters
        .where((h) => h.seq != primary.seq)
        .toList();

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
        if (primary.determinationFlagLabel case final label?)
          _InfoRow(label: '決定フラグ', value: label),
        if (primary.evaluationLabel case final label?)
          _InfoRow(label: '震源評価', value: label),
        _InfoRow(label: '観測点数', value: '${primary.stationCount}'),
        ...primary.magnitudes.map(
          (m) => _InfoRow(
            label: m.typeLabel,
            value: 'M${m.value.toStringAsFixed(1)}',
          ),
        ),
        for (final (i, h) in others.indexed)
          _HypocenterSection(index: i + 2, hypocenter: h),
        if (catalog.linkMatchConfidence case final confidence?)
          _InfoRow(
            label: '照合信頼度',
            value: '${(confidence * 100).toStringAsFixed(0)}%',
          ),
      ],
    );
  }
}

class _HypocenterSection extends StatelessWidget {
  const new({required this.index, required this.hypocenter});

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
        if (hypocenter.determinationFlagLabel case final label?)
          _InfoRow(label: '決定フラグ', value: label),
        if (hypocenter.evaluationLabel case final label?)
          _InfoRow(label: '震源評価', value: label),
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
