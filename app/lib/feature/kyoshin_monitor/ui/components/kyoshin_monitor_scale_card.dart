import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

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
    // LPGMデータ種別は連続スケールを持たないためnullを返す
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
      _ => null,
    };

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    // LPGMデータ種別の場合はスケールの代わりにラベルのみ表示
    if (type == null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: designSystem.spacing.sm,
            vertical: designSystem.spacing.md,
          ),
          decoration: BoxDecoration(
            color: colorTheme.surfaceContainerHigh.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(designSystem.shape.md),
            border: Border.all(color: colorTheme.outlineVariant),
          ),
          child: Text(
            realtimeDataType.displayName,
            style: designSystem.typography.monoSmall.copyWith(
              textBaseline: TextBaseline.alphabetic,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: [FontFamily.notoSansJP],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: designSystem.spacing.sm,
          vertical: designSystem.spacing.md,
        ),
        decoration: BoxDecoration(
          color: colorTheme.surfaceContainerHigh.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(designSystem.shape.md),
          border: Border.all(color: colorTheme.outlineVariant),
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
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: [
                  FontFamily.notoSansJP,
                ],
              ),
            ),
            SizedBox(height: designSystem.spacing.sm),
            KyoshinMonitorScale(
              type: type,
              width: 15,
              height: 150,
              gradientDirection: KyoshinMonitorScaleGradientDirection.reverse,
              orientation: KyoshinMonitorScaleOrientation.vertical,
              textColor: designSystem.colorTheme.onSurface,
              tickInterval: 3,
              textStyle: designSystem.typography.monoSmall.copyWith(
                textBaseline: TextBaseline.alphabetic,
                fontSize: 10,
                fontFamily: FontFamily.googleSansCode,
                fontFamilyFallback: [
                  FontFamily.notoSansJP,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
