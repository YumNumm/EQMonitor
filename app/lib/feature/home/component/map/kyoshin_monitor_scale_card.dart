import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

/// 強震モニタの設定状況を考慮したスケールカード
class KyoshinMonitorScaleCard extends ConsumerWidget {
  const KyoshinMonitorScaleCard({this.onTap, super.key});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final realtimeDataType = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.realtimeDataType),
    );
    final type = switch (realtimeDataType) {
      RealtimeDataType.shindo => KyoshinMonitorScaleType.intensity,
      RealtimeDataType.pga => KyoshinMonitorScaleType.pga,
      RealtimeDataType.pgv ||
      RealtimeDataType.response0125Hz ||
      RealtimeDataType.response025Hz ||
      RealtimeDataType.response05Hz ||
      RealtimeDataType.response1Hz ||
      RealtimeDataType.response2Hz ||
      RealtimeDataType.response4Hz => KyoshinMonitorScaleType.pgv,
      RealtimeDataType.pgd => KyoshinMonitorScaleType.pgd,
      _ => throw ArgumentError('Invalid realtimeDataType: $realtimeDataType)'),
    };
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type.unit == ''
                ? type.title
                : '${type.title.toUpperCase()} [${type.unit}]',
            style: theme.textTheme.bodySmall!.copyWith(
              fontFamily: FontFamily.jetBrainsMono,
              textBaseline: TextBaseline.alphabetic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          KyoshinMonitorScale(
            type: type,
            width: 15,
            height: 150,
            gradientDirection: KyoshinMonitorScaleGradientDirection.reverse,
            orientation: KyoshinMonitorScaleOrientation.vertical,
            textColor: theme.colorScheme.onSurface,
            tickInterval: 3,
            textStyle: theme.textTheme.bodySmall!.copyWith(
              fontFamily: FontFamily.jetBrainsMono,
              textBaseline: TextBaseline.alphabetic,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
