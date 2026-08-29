import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_region_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShakeDetectionCard extends ConsumerWidget {
  const new({
    required this.event,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 4),
    super.key,
  });

  final ShakeDetectionEvent event;
  final EdgeInsetsGeometry outerPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionsAsync = ref.watch(shakeDetectionRegionsProvider(event));

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ShakeDetectionCardHeader(event: event),
            _ShakeDetectionCardBody(event: event, regionsAsync: regionsAsync),
          ],
        ),
      ),
    );
  }
}

class _ShakeDetectionCardHeader extends StatelessWidget {
  const new({required this.event});

  final ShakeDetectionEvent event;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    final bgColor = _headerColorForLevel(event.level);
    final title = _titleForLevel(event.level);
    final timeStr = event.createdAt.formatWithTz(
      DateTimeFormat.hourMinuteSecond,
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.sm,
          vertical: spacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: typography.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              timeStr,
              style: typography.monoSmall.copyWith(
                color: Colors.white70,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _titleForLevel(ShakeDetectionLevel level) => switch (level) {
    ShakeDetectionLevel.stronger => '非常に強い揺れを検知',
    ShakeDetectionLevel.strong => '強い揺れを検知',
    ShakeDetectionLevel.medium => '揺れを検知',
    ShakeDetectionLevel.weak => '弱い揺れを検知',
    ShakeDetectionLevel.weaker => '微弱な揺れを検知',
  };

  static Color _headerColorForLevel(ShakeDetectionLevel level) =>
      switch (level) {
        ShakeDetectionLevel.weaker => const Color(0xFF546E7A),
        ShakeDetectionLevel.weak => const Color(0xFF1565C0),
        ShakeDetectionLevel.medium => const Color(0xFFF57F17),
        ShakeDetectionLevel.strong => const Color(0xFFE65100),
        ShakeDetectionLevel.stronger => const Color(0xFFB71C1C),
      };
}

class _ShakeDetectionCardBody extends StatelessWidget {
  const new({
    required this.event,
    required this.regionsAsync,
  });

  final ShakeDetectionEvent event;
  final AsyncValue<Map<String, List<String>>> regionsAsync;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    final regions = regionsAsync.asData?.value ?? {};

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.sm,
        vertical: spacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${event.pointCount}地点で検知',
            style: typography.labelMedium.copyWith(
              color: colorTheme.onSurfaceVariant,
            ),
          ),
          if (regionsAsync.isLoading) ...[
            SizedBox(height: spacing.xs),
            const LinearProgressIndicator(minHeight: 2),
          ],
          if (regions.isNotEmpty) ...[
            SizedBox(height: spacing.xs),
            for (final entry in regions.entries) ...[
              Text(entry.key, style: typography.titleSmall),
              Padding(
                padding: EdgeInsets.only(left: spacing.sm),
                child: Text(
                  entry.value.join(' '),
                  style: typography.bodySmall.copyWith(
                    color: colorTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
