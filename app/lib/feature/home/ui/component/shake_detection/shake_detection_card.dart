import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_region_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ShakeDetectionCard extends ConsumerWidget {
  const ShakeDetectionCard({required this.event, super.key});

  final ShakeDetectionEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionsAsync = ref.watch(
      shakeDetectionRegionsProvider(event),
    );
    final regions = regionsAsync.asData?.value ?? {};

    final designSystem = Theme.of(context).designSystemThemeExtension;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.lg),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: color.surfaceCard,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(shape.card),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ShakeDetectionCardHeader(event: event),
            if (regions.isNotEmpty)
              _ShakeDetectionRegionBody(regions: regions),
          ],
        ),
      ),
    );
  }
}

class _ShakeDetectionCardHeader extends StatelessWidget {
  const _ShakeDetectionCardHeader({required this.event});

  final ShakeDetectionEvent event;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    final bgColor = _headerColorForLevel(event.level);
    final title = _titleForLevel(event.level);
    final timeStr = DateFormat('HH:mm').format(event.createdAt.toLocal());

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

class _ShakeDetectionRegionBody extends StatelessWidget {
  const _ShakeDetectionRegionBody({required this.regions});

  final Map<String, List<String>> regions;

  @override
  Widget build(BuildContext context) {
    final designSystem = Theme.of(context).designSystemThemeExtension;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;
    final spacing = designSystem.spacing;

    return Padding(
      padding: EdgeInsets.all(spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final entry in regions.entries) ...[
            Text(
              entry.key,
              style: typography.titleSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: spacing.sm),
              child: Text(
                entry.value.join(' '),
                style: typography.bodySmall.copyWith(
                  color: textColor.secondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
