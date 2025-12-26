import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHypocenterInformationCard extends HookConsumerWidget {
  const EarthquakeHypocenterInformationCard({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityColorScheme = ref.watch(intensityColorProvider);
    final maxIntensity = item.intensity?.maxIntensity;
    final hypocenter = item.hypocenter;

    final colorScheme = maxIntensity != null
        ? intensityColorScheme.fromIntensityValue(maxIntensity)
        : null;

    final maxIntensityWidget = maxIntensity != null
        ? _MaxIntensityWidget(intensity: maxIntensity)
        : null;

    final cardBackgroundColor = colorScheme?.background ?? Colors.transparent;
    final cardColor = cardBackgroundColor.withValues(alpha: 0.3);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8)
          .add(const EdgeInsets.only(bottom: 4)),
      elevation: 0,
      shape: RoundedRectangleBorder(
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
                ?maxIntensityWidget,
                const SizedBox(width: 4),
                Expanded(
                  child: _EarthquakeInformationBody(
                    item: item,
                    hypocenter: hypocenter,
                    hasIntensityDetails: item.intensity?.cities != null,
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

class _MaxIntensityWidget extends StatelessWidget {
  const _MaxIntensityWidget({required this.intensity});

  final IntensityValue intensity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        IntensityValueIcon(
          type: IntensityIconType.filled,
          size: 60,
          intensity: intensity,
        ),
      ],
    );
  }
}

class _EarthquakeInformationBody extends StatelessWidget {
  const _EarthquakeInformationBody({
    required this.item,
    required this.hypocenter,
    required this.hasIntensityDetails,
  });

  final Earthquake item;
  final Hypocenter? hypocenter;
  final bool hasIntensityDetails;

  @override
  Widget build(BuildContext context) {
    final epicenterName = hypocenter?.code?.name;
    final epicenterDetailName = hypocenter?.detailedCode?.name;

    final isMagnitudeAndDepthUnknown =
        (hypocenter?.magnitude?.condition != null ||
            hypocenter?.magnitude == null) &&
        hypocenter?.depth == null;

    final isEarthquakeNull =
        isMagnitudeAndDepthUnknown && hypocenter?.code == null;

    final timeText = _getTimeText();
    final timeWidget =
        timeText != null ? Wrap(children: [Text(timeText)]) : null;

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.center,
      children: [
        const Row(),
        if (isEarthquakeNull)
          _EarthquakeNullWidget(hasIntensityDetails: hasIntensityDetails)
        else if (isMagnitudeAndDepthUnknown) ...[
          _MagnitudeDepthUnknownWidget(hasIntensityDetails: hasIntensityDetails),
          _HypocenterWidget(
            epicenterName: epicenterName,
            epicenterDetailName: epicenterDetailName,
          ),
        ] else ...[
          _MagnitudeWidget(hypocenter: hypocenter),
          _DepthWidget(hypocenter: hypocenter),
          const SizedBox(width: double.infinity),
          _HypocenterWidget(
            epicenterName: epicenterName,
            epicenterDetailName: epicenterDetailName,
          ),
        ],
        const Row(),
        ?timeWidget,
      ],
    );
  }

  String? _getTimeText() {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm頃');
    return switch ((item.originTime, item.arrivalTime)) {
      (final DateTime originTime, _) =>
        '発生時刻: ${dateFormat.format(originTime.toLocal())}',
      (_, final DateTime arrivalTime) =>
        '検知時刻: ${dateFormat.format(arrivalTime.toLocal())}',
      _ => null,
    };
  }
}

extension _TextStyleExtension on TextTheme {
  TextStyle labelStyle(TextStyle base) {
    return base.copyWith(
      color: base.color!.withValues(alpha: 0.8),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle valueStyle(TextStyle base) {
    return base.copyWith(
      fontWeight: FontWeight.bold,
      fontFamily: FontFamily.notoSansJP,
    );
  }
}

class _HypocenterWidget extends StatelessWidget {
  const _HypocenterWidget({
    required this.epicenterName,
    required this.epicenterDetailName,
  });

  final String? epicenterName;
  final String? epicenterDetailName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text('震源地', style: textTheme.labelStyle(textTheme.bodySmall!)),
        const SizedBox(width: 4),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: epicenterName ?? '不明',
                  style: textTheme.valueStyle(textTheme.headlineSmall!),
                ),
                if (epicenterDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '\n($epicenterDetailName)',
                    style: textTheme.valueStyle(textTheme.titleMedium!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MagnitudeWidget extends StatelessWidget {
  const _MagnitudeWidget({required this.hypocenter});

  final Hypocenter? hypocenter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final magnitude = hypocenter?.magnitude;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (magnitude?.condition == null)
          Text('M', style: textTheme.labelStyle(textTheme.titleSmall!)),
        Flexible(
          child: Text(
            _getMagnitudeText(),
            style: _getMagnitudeStyle(textTheme),
          ),
        ),
      ],
    );
  }

  String _getMagnitudeText() {
    final magnitude = hypocenter?.magnitude;
    return switch ((magnitude?.condition, magnitude?.value)) {
      (final String cond, _) => cond,
      (_, final double value) => value.toStringAsFixed(1),
      _ => '調査中',
    };
  }

  TextStyle _getMagnitudeStyle(TextTheme textTheme) {
    final baseStyle = hypocenter?.magnitude?.condition != null
        ? textTheme.headlineMedium!
        : textTheme.headlineLarge!;

    return textTheme.valueStyle(baseStyle);
  }
}

class _DepthWidget extends StatelessWidget {
  const _DepthWidget({required this.hypocenter});

  final Hypocenter? hypocenter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final depth = hypocenter?.depth;

    if (depth == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('深さ', style: textTheme.labelStyle(textTheme.titleSmall!)),
          Text('調査中', style: textTheme.valueStyle(textTheme.headlineMedium!)),
        ],
      );
    }

    final depthText = switch (depth) {
      '0km' || 'ごく浅い' => 'ごく浅い',
      '700km以上' => '700km以上',
      _ => depth,
    };

    if (depthText == 'ごく浅い' || depthText == '700km以上') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text('深さ', style: textTheme.labelStyle(textTheme.titleSmall!)),
          Text(depthText, style: textTheme.valueStyle(textTheme.headlineMedium!)),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('深さ', style: textTheme.labelStyle(textTheme.titleSmall!)),
        Text(depth, style: textTheme.valueStyle(textTheme.headlineLarge!)),
      ],
    );
  }
}

class _MagnitudeDepthUnknownWidget extends StatelessWidget {
  const _MagnitudeDepthUnknownWidget({required this.hasIntensityDetails});

  final bool hasIntensityDetails;

  @override
  Widget build(BuildContext context) {
    return _UnknownInfoWidget(
      label: 'M・深さ',
      value: hasIntensityDetails ? '不明' : '調査中',
    );
  }
}

class _EarthquakeNullWidget extends StatelessWidget {
  const _EarthquakeNullWidget({required this.hasIntensityDetails});

  final bool hasIntensityDetails;

  @override
  Widget build(BuildContext context) {
    return _UnknownInfoWidget(
      label: 'M・深さ・震源地',
      value: hasIntensityDetails ? '不明' : '調査中',
    );
  }
}

class _UnknownInfoWidget extends StatelessWidget {
  const _UnknownInfoWidget({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(label, style: textTheme.labelStyle(textTheme.titleMedium!)),
        const SizedBox(width: 4),
        Text(
          value,
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
  }
}
