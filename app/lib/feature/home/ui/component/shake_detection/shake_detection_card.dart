import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_summary.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_region_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 揺れ検知イベントのカード。EEW カードと同じ構成で、警戒帯は入れない。
class const ShakeDetectionCard({
  required final ShakeDetectionEvent event,
  final EdgeInsetsGeometry outerPadding = const EdgeInsets.symmetric(
    horizontal: 4,
  ),
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(shakeDetectionEventRegionsProvider(event));

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;

    return Padding(
      padding: outerPadding,
      child: Card(
        elevation: 0,
        clipBehavior: .antiAlias,
        margin: EdgeInsets.zero,
        color: colorTheme.surfaceContainerHigh,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(shape.card),
          side: BorderSide(color: colorTheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            _ShakeDetectionCardHeader(event: event),
            if (summary != null && summary.entries.isNotEmpty)
              _ShakeDetectionRegionSection(summary: summary),
          ],
        ),
      ),
    );
  }
}

class const _ShakeDetectionCardHeader({
  required final ShakeDetectionEvent event,
}) extends StatelessWidget {
  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    return DecoratedBox(
      decoration: BoxDecoration(color: event.level.cardColor),
      child: Padding(
        // 角丸の内側に文字が寄りすぎないよう、EEW カードより余白を広く取る。
        padding: EdgeInsets.symmetric(
          horizontal: spacing.lg,
          vertical: spacing.md,
        ),
        child: Row(
          spacing: spacing.sm,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    '揺れ検知',
                    style: typography.monoSmall.copyWith(
                      color: Colors.white,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    event.level.cardTitle,
                    style: typography.titleSmall.copyWith(
                      fontWeight: .w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: .end,
              children: [
                Text(
                  '検知時刻',
                  style: typography.labelSmall.copyWith(
                    color: _secondaryTextColor,
                  ),
                ),
                Text(
                  event.createdAt.formatWithTz(DateTimeFormat.hourMinuteSecond),
                  style: typography.monoMedium.copyWith(
                    fontSize: 20,
                    fontWeight: .w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
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

class const _ShakeDetectionRegionSection({
  required final ShakeDetectionRegionSummary summary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final nameStyle = typography.titleSmall.copyWith(fontWeight: .w700);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.md,
      ),
      child: summary.isGrouped
          ? Text(
              summary.entries.map((entry) => entry.name).join('　'),
              style: nameStyle,
            )
          : Column(
              crossAxisAlignment: .start,
              spacing: spacing.xs,
              children: [
                for (final entry in summary.entries)
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: entry.name, style: nameStyle),
                        if (entry.detail case final detail?)
                          TextSpan(
                            text: '  $detail',
                            style: typography.bodySmall.copyWith(
                              color: colorTheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

extension on ShakeDetectionLevel {
  String get cardTitle => switch (this) {
    .stronger => '非常に強い揺れを検知',
    .strong => '強い揺れを検知',
    .medium => 'やや強い揺れを検知',
    .weak => '弱い揺れを検知',
    .weaker => '微弱な揺れを検知',
  };

  Color get cardColor => switch (this) {
    .weaker => const Color(0xFF546E7A),
    .weak => const Color(0xFF1565C0),
    .medium => const Color(0xFFF57F17),
    .strong => const Color(0xFFE65100),
    .stronger => const Color(0xFFB71C1C),
  };
}
