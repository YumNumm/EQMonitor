import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 強震モニタの設定状況を考慮したスケールカード
class KyoshinMonitorScaleCard extends ConsumerWidget {
  const KyoshinMonitorScaleCard({this.onTap, super.key});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final realtimeDataType = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.requireValue.realtimeDataType,
      ),
    );
    final type = switch (realtimeDataType) {
      .shindo => KyoshinMonitorScaleType.intensity,
      .pga => KyoshinMonitorScaleType.pga,
      .pgv ||
      .response0125Hz ||
      .response025Hz ||
      .response05Hz ||
      .response1Hz ||
      .response2Hz ||
      .response4Hz => KyoshinMonitorScaleType.pgv,
      .pgd => KyoshinMonitorScaleType.pgd,
      _ => throw ArgumentError('Invalid realtimeDataType: $realtimeDataType)'),
    };
    final designSystem = context.designSystem;
    final color = designSystem.color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: designSystem.spacing.sm,
          vertical: designSystem.spacing.md,
        ),
        decoration: BoxDecoration(
          color: color.surfaceCard.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(designSystem.shape.md),
          border: Border.all(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              type.unit == ''
                  ? type.title
                  : '${type.title.toUpperCase()} [${type.unit}]',
              style: designSystem.typography.monoSmall.copyWith(
                textBaseline: TextBaseline.alphabetic,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: designSystem.spacing.sm),
            KyoshinMonitorScale(
              type: type,
              width: 15,
              height: 150,
              gradientDirection: KyoshinMonitorScaleGradientDirection.reverse,
              orientation: KyoshinMonitorScaleOrientation.vertical,
              textColor: designSystem.textColor.primary,
              tickInterval: 3,
              textStyle: designSystem.typography.monoSmall.copyWith(
                textBaseline: TextBaseline.alphabetic,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
