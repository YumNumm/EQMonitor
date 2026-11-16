import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_group.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_region_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 揺れ検知イベントのカード。EEW カードと同じ構成で、警戒帯は入れない。
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
    final regions =
        ref.watch(shakeDetectionEventRegionsProvider(event)).value ??
        const <ShakeDetectionRegionGroup>[];

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.sm,
                vertical: spacing.xs,
              ),
              child: Row(
                crossAxisAlignment: .start,
                spacing: spacing.sm,
                children: [
                  _ShakeDetectionLevelSection(level: event.level),
                  Expanded(
                    child: _ShakeDetectionRegionSection(
                      event: event,
                      regions: regions,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShakeDetectionCardHeader extends StatelessWidget {
  const new({required this.event});

  final ShakeDetectionEvent event;

  static const _secondaryTextColor = Color.fromRGBO(255, 255, 255, 0.7);

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final spacing = designSystem.spacing;

    return DecoratedBox(
      decoration: BoxDecoration(color: event.level.cardColor),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.sm,
          vertical: spacing.sm,
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

class _ShakeDetectionLevelSection extends StatelessWidget {
  const new({required this.level});

  final ShakeDetectionLevel level;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Column(
      mainAxisSize: .min,
      spacing: spacing.xs,
      children: [
        Text(
          '揺れの強さ',
          style: typography.labelMedium.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: level.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox.square(
            dimension: 48,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(spacing.xs),
                child: FittedBox(
                  fit: .scaleDown,
                  child: Text(
                    level.cardBadgeLabel,
                    textAlign: .center,
                    style: typography.titleMedium.copyWith(
                      fontWeight: .w700,
                      color: Colors.white,
                      height: 1.1,
                    ),
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

class _ShakeDetectionRegionSection extends StatelessWidget {
  const new({required this.event, required this.regions});

  final ShakeDetectionEvent event;
  final List<ShakeDetectionRegionGroup> regions;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Column(
      crossAxisAlignment: .start,
      spacing: spacing.xs,
      children: [
        Text(
          '${event.pointCount}地点で検知',
          style: typography.labelMedium.copyWith(
            color: colorTheme.onSurfaceVariant,
          ),
        ),
        for (final region in regions)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: region.prefectureName,
                  style: typography.titleSmall.copyWith(fontWeight: .w700),
                ),
                if (!region.isWholePrefecture && region.regionNames.isNotEmpty)
                  TextSpan(
                    text: '  ${region.regionNames.join(' ')}',
                    style: typography.bodySmall.copyWith(
                      color: colorTheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
      ],
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

  String get cardBadgeLabel => switch (this) {
    .stronger => '非常に\n強い',
    .strong => '強い',
    .medium => 'やや\n強い',
    .weak => '弱い',
    .weaker => '微弱',
  };

  Color get cardColor => switch (this) {
    .weaker => const Color(0xFF546E7A),
    .weak => const Color(0xFF1565C0),
    .medium => const Color(0xFFF57F17),
    .strong => const Color(0xFFE65100),
    .stronger => const Color(0xFFB71C1C),
  };
}
