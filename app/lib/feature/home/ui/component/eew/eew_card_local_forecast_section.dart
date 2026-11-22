import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_arrival_countdown.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_colors.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card_text_style.dart';
import 'package:material_ui/material_ui.dart';

class const EewCardLocalForecastSection({
  required final JmaIntensity intensity,
  required final String regionDisplayName,
  required final bool isLocalWarning,
  required final DateTime? arrivalTime,
  required final bool isArrived,
  required final bool isImminentArrival,
  required final DateTime Function()? clockOverride,
  required final EewCardColors colors,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labelStyle = EewCardFlexTextStyle(
      size: 10,
      weight: .w700,
      color: colors.secondary,
    );
    final showsCountdown = arrivalTime != null || isArrived;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: colors.divider, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .end,
          spacing: 6,
          children: [
            Flexible(
              // 予想震度と到達予想がそろうときは地名を省き、カウントダウンを大きく見せる。
              child: isImminentArrival
                  ? Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text('現在地', style: labelStyle),
                        FittedBox(
                          fit: .scaleDown,
                          alignment: .centerLeft,
                          child: Text(
                            'すぐに到達',
                            style: EewCardFlexTextStyle(
                              size: 16,
                              weight: .w800,
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    )
                  : showsCountdown
                  ? Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      children: [
                        Text('現在地\n揺れ到達まで', style: labelStyle),
                        EewCardArrivalCountdown(
                          arrivalTime: arrivalTime,
                          isArrived: isArrived,
                          clockOverride: clockOverride,
                          color: colors.primary,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      spacing: 2,
                      children: [
                        Text(
                          isLocalWarning ? '現在地に警報' : '現在地',
                          style: labelStyle,
                        ),
                        Text(
                          regionDisplayName,
                          style: EewCardFlexTextStyle(
                            size: 10,
                            weight: .w800,
                            color: colors.primary,
                          ),
                          maxLines: 2,
                          overflow: .ellipsis,
                        ),
                      ],
                    ),
            ),
            _EewLocalIntensityBadge(intensity: intensity),
          ],
        ),
      ),
    );
  }
}

class const _EewLocalIntensityBadge({required final JmaIntensity intensity})
    extends StatelessWidget {
  static const _size = 48.0;

  @override
  Widget build(BuildContext context) {
    final colorEntry = context.designSystem.colorTheme.intensity
        .fromJmaIntensity(intensity);
    final foreground = colorEntry.resolvedForeground;
    final suffix = intensity.suffix;

    return Semantics(
      label: '現在地の予想震度 ${intensity.label}',
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: _size, minHeight: _size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorEntry.background,
            borderRadius: BorderRadius.circular(_size * 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _size * 0.08),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: intensity.mainText),
                    if (suffix.isNotEmpty)
                      TextSpan(
                        text: suffix,
                        style: EewCardFlexTextStyle(
                          size: _size * 0.36,
                          weight: .w800,
                          color: foreground,
                        ),
                      ),
                  ],
                ),
                style: EewCardCodeTextStyle(
                  size: _size * 0.76,
                  weight: .w800,
                  color: foreground,
                ),
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
