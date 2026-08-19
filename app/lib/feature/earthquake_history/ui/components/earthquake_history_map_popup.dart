import 'dart:async';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final earthquakeHistoryMapPopupActionProvider = Provider(
  (ref) => const EarthquakeHistoryMapPopupAction(),
);

/// 地震履歴マップの観測点・区域タップ時のポップアップ表示を担う。
class EarthquakeHistoryMapPopupAction {
  const new();

  /// 観測点タップ時のポップアップ
  ///
  /// [intensityLabel] は [intensity] が null のときにラベルテキストで震度を表示する
  /// フォールバック (震度DBの歴史的階級など JmaIntensity に対応しない階級向け)。
  Future<void> showStation(
    BuildContext context, {
    required String stationName,
    required JmaIntensity? intensity,
    required JmaLpgmIntensity? lpgmIntensity,
    String? intensityLabel,
  }) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      builder: (context) => _StationPopupBody(
        stationName: stationName,
        intensity: intensity,
        lpgmIntensity: lpgmIntensity,
        intensityLabel: intensityLabel,
      ),
    );
  }

  /// 区域タップ時のポップアップ
  ///
  /// [intensityHistoryRoute] を指定すると「この地域の最大震度履歴」ボタンを表示する。
  Future<void> showArea(
    BuildContext context, {
    required String areaName,
    required JmaIntensity? maxIntensity,
    IntensityHistoryRoute? intensityHistoryRoute,
  }) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      builder: (context) => _AreaPopupBody(
        areaName: areaName,
        maxIntensity: maxIntensity,
        intensityHistoryRoute: intensityHistoryRoute,
      ),
    );
  }
}

class _StationPopupBody extends StatelessWidget {
  const new({
    required this.stationName,
    required this.intensity,
    required this.lpgmIntensity,
    this.intensityLabel,
  });

  final String stationName;
  final JmaIntensity? intensity;
  final JmaLpgmIntensity? lpgmIntensity;
  final String? intensityLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: context.designSystem.colorTheme.onSurface.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(stationName, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                if (intensity case final currentIntensity?) ...[
                  JmaIntensityIcon(
                    intensity: currentIntensity,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '震度 ${currentIntensity.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ] else if (intensityLabel != null) ...[
                  Text('震度 $intensityLabel', style: theme.textTheme.bodyLarge),
                ],
                if (lpgmIntensity case final currentLpgmIntensity?
                    when currentLpgmIntensity != JmaLpgmIntensity.zero) ...[
                  const SizedBox(width: 16),
                  JmaLpgmIntensityIcon(
                    intensity: currentLpgmIntensity,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '長周期 ${currentLpgmIntensity.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AreaPopupBody extends StatelessWidget {
  const new({
    required this.areaName,
    required this.maxIntensity,
    this.intensityHistoryRoute,
  });

  final String areaName;
  final JmaIntensity? maxIntensity;
  final IntensityHistoryRoute? intensityHistoryRoute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: context.designSystem.colorTheme.onSurface.withValues(
                    alpha: 0.3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(areaName, style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            if (maxIntensity case final currentMaxIntensity?)
              Row(
                children: [
                  JmaIntensityIcon(
                    intensity: currentMaxIntensity,
                    type: .filled,
                    size: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '最大震度 ${currentMaxIntensity.label}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              )
            else
              Text(
                '観測なし',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: context.designSystem.colorTheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
            if (intensityHistoryRoute case final route?) ...[
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  unawaited(route.push<void>(context));
                },
                icon: const Icon(Icons.bar_chart_outlined),
                label: const Text('この地域の最大震度履歴'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
