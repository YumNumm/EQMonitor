import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';

class EewWarningOverlayBanner extends StatelessWidget {
  const EewWarningOverlayBanner({
    required this.displayModel,
    required this.onExpand,
    required this.onClose,
    super.key,
  });

  final EewWarningOverlayDisplayModel displayModel;
  final VoidCallback onExpand;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final arrivalText = formatEewWarningOverlayArrival(
      state: displayModel.arrivalState,
      secondsUntilArrival: displayModel.secondsUntilArrival,
    );
    final intensityQualifier = displayModel.localIntensityIsOver ? '以上' : '';
    final headline = displayModel.hypocenterHeadline == null
        ? displayModel.strongMotionHeadline
        : '${displayModel.hypocenterHeadline}\n${displayModel.strongMotionHeadline}';

    return Material(
      color: colorScheme.errorContainer,
      elevation: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WarningStripeDecoration(
            colors: [Colors.red, Colors.black],
            height: 10,
          ),
          SafeArea(
            top: true,
            bottom: false,
            child: InkWell(
              onTap: onExpand,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 4, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    JmaIntensityIcon(
                      intensity: displayModel.localIntensity,
                      type: IntensityIconType.filled,
                      size: 52,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '緊急地震速報（警報）',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            headline,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onErrorContainer,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 12,
                            runSpacing: 2,
                            children: [
                              Text(
                                '予想震度${displayModel.localIntensity.label}$intensityQualifier',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (arrivalText case final text?)
                                Text(
                                  text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onErrorContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onClose,
                      color: colorScheme.onErrorContainer,
                      tooltip: '警報表示を閉じる',
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
