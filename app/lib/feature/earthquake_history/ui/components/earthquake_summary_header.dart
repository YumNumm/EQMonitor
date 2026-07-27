import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/depth_text.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_info_text_style.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarthquakeSummaryHeader extends StatelessWidget {
  const EarthquakeSummaryHeader({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final maxIntensity = item.intensity?.maxIntensity;
    final colorTheme = context.designSystem.colorTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            if (maxIntensity != null)
              _MaxIntensityWidget(intensity: maxIntensity),
            const SizedBox(width: 4),
            Expanded(
              child: _EarthquakeInformationBody(
                item: item,
                hypocenter: item.hypocenter,
                hasIntensityDetails:
                    item.intensity?.intensityTree.isNotEmpty ?? false,
              ),
            ),
          ],
        ),
        if (item.status != TelegramStatus.normal)
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: FittedBox(
                  child: Text(
                    item.status.name,
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.w700,
                      color: colorTheme.onSurfaceVariant.withValues(alpha: 0.2),
                      fontFamily: FontFamily.googleSansCode,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MaxIntensityWidget extends StatelessWidget {
  const _MaxIntensityWidget({required this.intensity});

  final JmaIntensity intensity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        JmaIntensityIcon(type: .filled, size: 60, intensity: intensity),
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
  final EarthquakeHypocenter? hypocenter;
  final bool hasIntensityDetails;

  @override
  Widget build(BuildContext context) {
    final epicenterName = hypocenter?.name;
    final epicenterDetailName = hypocenter?.detailedName?.replaceAll('、', ' ');
    final magnitude = hypocenter?.magnitude;
    final depth = hypocenter?.depth;
    final isMagnitudeUnknown =
        magnitude == null || magnitude is EarthquakeMagnitudeUnknown;
    final isDepthUnknown = depth == null || depth is EarthquakeDepthUnknown;
    final isMagnitudeAndDepthUnknown = isMagnitudeUnknown && isDepthUnknown;
    final isEarthquakeNull = isMagnitudeAndDepthUnknown && hypocenter == null;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm頃');
    final timeText = switch ((item.originTime, item.arrivalTime)) {
      (final DateTime originTime, _) =>
        '発生時刻: ${dateFormat.format(originTime.toLocal())}',
      (_, final DateTime arrivalTime) =>
        '検知時刻: ${dateFormat.format(arrivalTime.toLocal())}',
      _ => null,
    };

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.center,
      children: [
        const Row(),
        if (isEarthquakeNull)
          _EarthquakeNullWidget(hasIntensityDetails: hasIntensityDetails)
        else if (isMagnitudeAndDepthUnknown) ...[
          _MagnitudeDepthUnknownWidget(
            hasIntensityDetails: hasIntensityDetails,
          ),
          _HypocenterWidget(
            epicenterName: epicenterName,
            epicenterDetailName: epicenterDetailName,
          ),
        ] else ...[
          MagnitudeText(
            magnitude: hypocenter?.magnitude,
            variant: MagnitudeTextVariant.display,
          ),
          DepthText(depth: hypocenter?.depth),
          const SizedBox(width: double.infinity),
          _HypocenterWidget(
            epicenterName: epicenterName,
            epicenterDetailName: epicenterDetailName,
          ),
        ],
        const Row(),
        if (timeText != null) Wrap(children: [Text(timeText)]),
      ],
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
    final bodySmall = textTheme.bodySmall ?? const TextStyle();
    final headlineSmall = textTheme.headlineSmall ?? const TextStyle();
    final titleMedium = textTheme.titleMedium ?? const TextStyle();

    return Row(
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text('震源地', style: textTheme.labelStyle(bodySmall)),
        const SizedBox(width: 4),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: epicenterName ?? '不明',
                  style: textTheme.valueStyle(headlineSmall),
                ),
                if (epicenterDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '\n($epicenterDetailName)',
                    style: textTheme.valueStyle(titleMedium),
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
      label: '震源要素',
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
    final titleSmall = textTheme.titleSmall ?? const TextStyle();
    final titleLarge = textTheme.titleLarge ?? const TextStyle();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(label, style: textTheme.labelStyle(titleSmall)),
        const SizedBox(width: 4),
        Text(
          value,
          style: titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.googleSansCode,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );
  }
}
