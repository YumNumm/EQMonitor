import 'package:eqmonitor/core/component/chip/beta_chip.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_access_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/shake_detection_notification_detail_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ShakeDetectionBetaCard({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailRecognizer = useMemoized(TapGestureRecognizer.new);
    useEffect(() => detailRecognizer.dispose, [detailRecognizer]);

    if (ref.watch(shakeDetectionNotificationAccessProvider) == .hidden) {
      return const SizedBox.shrink();
    }

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final foreground = colorTheme.onPrimaryContainer;

    Future<void> openDetail() =>
        const ShakeDetectionNotificationDetailSheetAction().show(context);
    detailRecognizer.onTap = openDetail;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.lg, spacing.md),
      child: Material(
        color: colorTheme.primaryContainer,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.card),
          side: BorderSide(color: colorTheme.outlineVariant),
        ),
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: openDetail,
          child: Padding(
            padding: EdgeInsets.all(spacing.lg),
            child: Row(
              crossAxisAlignment: .start,
              spacing: spacing.md,
              children: [
                Icon(Icons.sensors_rounded, color: foreground, size: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: spacing.xs,
                    children: [
                      Wrap(
                        spacing: spacing.sm,
                        runSpacing: spacing.xs,
                        crossAxisAlignment: .center,
                        children: [
                          Text(
                            '揺れ検知の通知',
                            style: typography.titleMedium.copyWith(
                              color: foreground,
                              fontWeight: .bold,
                            ),
                          ),
                          const BetaChip(),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: '通知地域を選ぶと、地域ごとに揺れ検知の通知を設定できます。 ',
                            ),
                            TextSpan(
                              text: '注意事項',
                              style: TextStyle(
                                color: colorTheme.primary,
                                decoration: .underline,
                                decorationColor: colorTheme.primary,
                                fontWeight: .w600,
                              ),
                              recognizer: detailRecognizer,
                            ),
                          ],
                        ),
                        style: typography.bodySmall.copyWith(color: foreground),
                      ),
                    ],
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
