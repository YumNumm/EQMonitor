import 'dart:async';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final earthquakeHistoryMapPopupActionProvider = Provider(
  (ref) => const EarthquakeHistoryMapPopupAction(),
);

/// 地震履歴マップの観測点・区域タップ時のポップアップ表示を担う。
class EarthquakeHistoryMapPopupAction {
  const new();

  /// 区域タップ時のポップアップ
  ///
  /// [intensityHistoryRoute] を指定すると「この地域の最大震度履歴」ボタンを表示する。
  Future<void> showArea(
    BuildContext context, {
    required String areaName,
    required JmaIntensity? maxIntensity,
    required Widget intensityContent,
    IntensityHistoryRoute? intensityHistoryRoute,
  }) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      builder: (context) => _AreaPopupBody(
        areaName: areaName,
        maxIntensity: maxIntensity,
        intensityContent: intensityContent,
        intensityHistoryRoute: intensityHistoryRoute,
      ),
    );
  }
}

class _AreaPopupBody extends StatelessWidget {
  const new({
    required this.areaName,
    required this.maxIntensity,
    required this.intensityContent,
    this.intensityHistoryRoute,
  });

  final String areaName;
  final JmaIntensity? maxIntensity;
  final Widget intensityContent;
  final IntensityHistoryRoute? intensityHistoryRoute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          shrinkWrap: true,
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
              ),
            intensityContent,
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
