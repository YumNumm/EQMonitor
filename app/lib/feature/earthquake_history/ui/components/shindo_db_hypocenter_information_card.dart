import 'package:eqmonitor/core/component/expansion/expandable_section.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_catalog_hypocenter_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_info_text_style.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:material_ui/material_ui.dart';

class const ShindoDbHypocenterInformationCard({
  required final EarthquakeCatalog catalog,
  required final DateTime? originTime,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hypocenters = const EarthquakeCatalogHypocenterOrder().sort(
      catalog.hypocenters,
    );
    final primary = hypocenters.firstOrNull;
    if (primary == null) {
      return const SizedBox.shrink();
    }

    final intensityColors = context.designSystem.colorTheme.intensity;
    final colorJma = primary.maxIntensity?.colorJmaIntensity;
    final cardBackgroundColor = colorJma != null
        ? intensityColors.fromJmaIntensity(colorJma).background
        : Colors.grey;
    final cardColor = cardBackgroundColor.withValues(alpha: 0.3);

    const margin = EdgeInsets.only(left: 8, right: 8, bottom: 4);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Card(
          margin: margin,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: cardBackgroundColor, width: 0),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
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
          ),
        ),
        Padding(
          padding: margin,
          child: _DetailsTile(
            primary: primary,
            others: hypocenters.skip(1).toList(),
          ),
        ),
      ],
    );
  }
}

class const _MaxIntensityWidget({
  required final EarthquakeCatalogHypocenter hypocenter,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxIntensity = hypocenter.maxIntensity;
    if (maxIntensity == null) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: .min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: .bold)),
        const SizedBox(height: 4),
        ShindoDbIntensityClassIcon(intensityClass: maxIntensity, size: 60),
      ],
    );
  }
}

class const _PrimaryHypocenterBody({
  required final EarthquakeCatalogHypocenter hypocenter,
  required final DateTime? originTime,
}) extends StatelessWidget {
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

class const _MagnitudeRow({
  required final List<EarthquakeCatalogMagnitude> magnitudes,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (magnitudes.isEmpty) {
      return Row(
        mainAxisSize: .min,
        crossAxisAlignment: .baseline,
        textBaseline: .alphabetic,
        children: [
          Text('M', style: textTheme.labelStyle(textTheme.titleSmall)),
          Text('不明', style: textTheme.valueStyle(textTheme.headlineMedium)),
        ],
      );
    }

    final first = magnitudes.first;
    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisSize: .min,
          crossAxisAlignment: .baseline,
          textBaseline: .alphabetic,
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

class const _DepthRow({required final EarthquakeCatalogHypocenter hypocenter})
    extends StatelessWidget {
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
      mainAxisSize: .min,
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
                  '（深さフリー）',
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

class const _OriginTimeRow({
  required final DateTime originTime,
  required final double? stderrSeconds,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stderr = stderrSeconds;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:
                '発生時刻: ${originTime.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecondMillisecond)}頃',
          ),
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

class const _EpicenterWidget({required final String epicenterName})
    extends StatelessWidget {
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

class const _DetailsTile({
  required final EarthquakeCatalogHypocenter primary,
  required final List<EarthquakeCatalogHypocenter> others,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpandableSection(
      title: Text(
        '震源の詳細情報',
        style: theme.textTheme.bodySmall?.copyWith(
          fontFamily: FontFamily.notoSansJP,
        ),
      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: [
        if (primary.determinationFlagLabel case final label?)
          _InfoRow(label: '決定フラグ', value: label),
        if (primary.evaluationLabel case final label?)
          _InfoRow(label: '震源評価', value: label),
        if (others.isEmpty || primary.stationCount > 0)
          _InfoRow(label: '観測点数', value: '${primary.stationCount}'),
        ...primary.magnitudes.map(
          (m) => _InfoRow(
            label: m.typeLabel,
            value: 'M${m.value.toStringAsFixed(1)}',
          ),
        ),
        for (final (i, h) in others.indexed)
          _HypocenterSection(index: i + 2, hypocenter: h),
      ],
    );
  }
}

class const _HypocenterSection({
  required final int index,
  required final EarthquakeCatalogHypocenter hypocenter,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            '震源 $index',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: .bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
        ),
        _InfoRow(label: 'レコード種別', value: hypocenter.recordTypeLabel),
        if (hypocenter.determinationFlagLabel case final label?)
          _InfoRow(label: '決定フラグ', value: label),
        if (hypocenter.evaluationLabel case final label?)
          _InfoRow(label: '震源評価', value: label),
        if (hypocenter.stationCount > 0)
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

class const _InfoRow({required final String label, required final String value})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: const [FontFamily.notoSansJP],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: const [
                  FontFamily.googleSansCode,
                  FontFamily.notoSansJP,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
