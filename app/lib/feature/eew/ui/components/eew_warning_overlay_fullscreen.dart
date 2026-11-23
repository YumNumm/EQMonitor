import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/util/jma_depth_formatter.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_top_stripe.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_intensity_formatter.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_label_formatter.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const EewWarningOverlayFullscreen({
  required final EewWarningOverlayDisplayModel displayModel,
  required final VoidCallback onMinimize,
  required final VoidCallback onClose,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final arrivalText = const EewWarningOverlayArrivalFormatter().format(
      state: displayModel.arrivalState,
      secondsUntilArrival: displayModel.secondsUntilArrival,
    );
    final intensityText = const EewWarningOverlayIntensityFormatter().format(
      intensity: displayModel.localIntensity,
      isOver: displayModel.localIntensityIsOver,
    );
    final magnitudeText = switch (displayModel.magnitude) {
      null => '不明',
      final double magnitude => 'M${magnitude.toStringAsFixed(1)}',
    };
    final depthText = const JmaDepthFormatter().format(
      depth: displayModel.depth,
    );

    return BlockSemantics(
      child: Semantics(
        label: const EewWarningOverlayLabelFormatter().semanticsLabel(
          source: displayModel.source,
        ),
        scopesRoute: true,
        explicitChildNodes: true,
        child: SizedBox.expand(
          child: Material(
            color: colorScheme.errorContainer,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                const EewWarningOverlayTopStripe(),
                Expanded(
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      child: Column(
                        crossAxisAlignment: .stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  displayModel.reportLabel,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onErrorContainer,
                                    fontWeight: .w700,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _EewWarningHeadline(displayModel: displayModel),
                                const SizedBox(height: 28),
                                _EewWarningLocalIntensity(
                                  displayModel: displayModel,
                                  arrivalText: arrivalText,
                                  intensityText: intensityText,
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
                                child: M3EOutlinedButton.icon(
                                  onPressed: onMinimize,
                                  decoration: M3EButtonDecoration.styleFrom(
                                    foregroundColor:
                                        colorScheme.onErrorContainer,
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
                                child: M3EFilledButton.icon(
                                  onPressed: onClose,
                                  decoration: M3EButtonDecoration.styleFrom(
                                    backgroundColor: colorScheme.error,
                                    foregroundColor: colorScheme.onError,
                                    haptic: .light,
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
      ),
    );
  }
}

class const _EewWarningHeadline({
  required final EewWarningOverlayDisplayModel displayModel,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onErrorContainer;
    final headlineStyle = theme.textTheme.headlineMedium?.copyWith(
      color: color,
      fontWeight: .w900,
      height: 1.25,
    );

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (displayModel.hypocenterHeadline case final headline?)
          Text(headline, style: headlineStyle),
        Text(displayModel.strongMotionHeadline, style: headlineStyle),
      ],
    );
  }
}

class const _EewWarningLocalIntensity({
  required final EewWarningOverlayDisplayModel displayModel,
  required final String? arrivalText,
  required final String intensityText,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onErrorContainer;

    return Wrap(
      spacing: 20,
      runSpacing: 16,
      crossAxisAlignment: .center,
      children: [
        ExcludeSemantics(
          child: JmaIntensityIcon(
            intensity: displayModel.localIntensity,
            type: IntensityIconType.filled,
            size: 104,
          ),
        ),
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              '現在地の予想震度',
              style: theme.textTheme.titleMedium?.copyWith(color: color),
            ),
            Text(
              '震度$intensityText',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: .w800,
              ),
            ),
            if (arrivalText case final text?)
              Text(
                text,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: .w800,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class const _EewWarningDetails({
  required final EewWarningOverlayDisplayModel displayModel,
  required final String magnitudeText,
  required final String depthText,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.82),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .stretch,
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

class const _EewWarningDetailRow({
  required final String label,
  required final String value,
}) extends StatelessWidget {
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
              fontWeight: .w600,
            ),
          ),
        ],
      ),
    );
  }
}
