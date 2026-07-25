import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';

class EewWarningOverlayFullscreen extends StatelessWidget {
  const EewWarningOverlayFullscreen({
    required this.displayModel,
    required this.onMinimize,
    required this.onClose,
    super.key,
  });

  final EewWarningOverlayDisplayModel displayModel;
  final VoidCallback onMinimize;
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
    final magnitudeText = switch (displayModel.magnitude) {
      null => '不明',
      final double magnitude => 'M${magnitude.toStringAsFixed(1)}',
    };
    final depthText = switch (displayModel.depth) {
      null => '不明',
      0 => 'ごく浅い',
      final int depth => '${depth}km',
    };

    return Semantics(
      label: '緊急地震速報警報',
      scopesRoute: true,
      explicitChildNodes: true,
      child: SizedBox.expand(
        child: Material(
          color: colorScheme.errorContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const WarningStripeDecoration(
                colors: [Colors.red, Colors.black],
                height: 10,
              ),
              Expanded(
                child: SafeArea(
                  top: true,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Text(
                                displayModel.reportLabel,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 24),
                              _EewWarningHeadline(displayModel: displayModel),
                              const SizedBox(height: 28),
                              _EewWarningLocalIntensity(
                                displayModel: displayModel,
                                arrivalText: arrivalText,
                                intensityQualifier: intensityQualifier,
                              ),
                              const SizedBox(height: 24),
                              _EewWarningDetails(
                                displayModel: displayModel,
                                magnitudeText: magnitudeText,
                                depthText: depthText,
                              ),
                              if (displayModel.alertCount > 1) ...[
                                const SizedBox(height: 16),
                                Text(
                                  '${displayModel.alertCount}件の警報から代表表示',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onErrorContainer,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: onMinimize,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: colorScheme.onErrorContainer,
                                  side: BorderSide(
                                    color: colorScheme.onErrorContainer,
                                  ),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                label: const Text('最小化'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: onClose,
                                style: FilledButton.styleFrom(
                                  backgroundColor: colorScheme.error,
                                  foregroundColor: colorScheme.onError,
                                ),
                                icon: const Icon(Icons.close),
                                label: const Text('閉じる'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EewWarningHeadline extends StatelessWidget {
  const _EewWarningHeadline({required this.displayModel});

  final EewWarningOverlayDisplayModel displayModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onErrorContainer;
    final headlineStyle = theme.textTheme.headlineMedium?.copyWith(
      color: color,
      fontWeight: FontWeight.w900,
      height: 1.25,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (displayModel.hypocenterHeadline case final headline?)
          Text(headline, style: headlineStyle),
        Text(displayModel.strongMotionHeadline, style: headlineStyle),
      ],
    );
  }
}

class _EewWarningLocalIntensity extends StatelessWidget {
  const _EewWarningLocalIntensity({
    required this.displayModel,
    required this.arrivalText,
    required this.intensityQualifier,
  });

  final EewWarningOverlayDisplayModel displayModel;
  final String? arrivalText;
  final String intensityQualifier;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onErrorContainer;

    return Wrap(
      spacing: 20,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        JmaIntensityIcon(
          intensity: displayModel.localIntensity,
          type: IntensityIconType.filled,
          size: 104,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '現在地の予想震度',
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
            Text(
              '震度${displayModel.localIntensity.label}$intensityQualifier',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (arrivalText case final text?)
              Text(
                text,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _EewWarningDetails extends StatelessWidget {
  const _EewWarningDetails({
    required this.displayModel,
    required this.magnitudeText,
    required this.depthText,
  });

  final EewWarningOverlayDisplayModel displayModel;
  final String magnitudeText;
  final String depthText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.82),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _EewWarningDetailRow(
              label: '現在地域',
              value: displayModel.currentRegionName,
            ),
            const SizedBox(height: 10),
            _EewWarningDetailRow(
              label: '震源',
              value: displayModel.hypocenterName ?? '不明',
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 24,
              runSpacing: 8,
              children: [
                _EewWarningDetailRow(label: 'マグニチュード', value: magnitudeText),
                _EewWarningDetailRow(label: '深さ', value: depthText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EewWarningDetailRow extends StatelessWidget {
  const _EewWarningDetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label：',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          TextSpan(
            text: value,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
