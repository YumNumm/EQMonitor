import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_top_stripe.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_intensity_formatter.dart';
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
    final intensityText = formatEewWarningOverlayIntensity(
      intensity: displayModel.localIntensity,
      isOver: displayModel.localIntensityIsOver,
    );
    final bannerLabel = formatEewWarningOverlayBannerLabel(
      source: displayModel.source,
      reportLabel: displayModel.reportLabel,
    );
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
          const EewWarningOverlayTopStripe(),
          SafeArea(
            top: false,
            bottom: false,
            child: InkWell(
              onTap: onExpand,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 4, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExcludeSemantics(
                      child: JmaIntensityIcon(
                        intensity: displayModel.localIntensity,
                        type: IntensityIconType.filled,
                        size: 52,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bannerLabel,
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
                                '予想震度$intensityText',
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
