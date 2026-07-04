import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:flutter/material.dart';

/// 震度凡例オーバーレイウィジェット
///
/// 現在のデータで実際に観測されている震度範囲のみを表示する。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級を表示する。
class EarthquakeHistoryMapLegend extends StatelessWidget {
  const EarthquakeHistoryMapLegend({
    required this.intensity,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final bool showingLpgmIntensity;

  @override
  Widget build(BuildContext context) {
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: context.designSystem.colorTheme.surface.withValues(alpha: 0.85),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: showingLpgmIntensity
            ? _LpgmLegend(intensity: intensity!)
            : _JmaLegend(intensity: intensity!),
      ),
    );
  }
}

class _JmaLegend extends StatelessWidget {
  const _JmaLegend({required this.intensity});
  final EarthquakeIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final levels = intensity.intensityTree.keys.toList()
      ..sort((a, b) => b.index.compareTo(a.index));
    if (levels.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        for (final level in levels)
          JmaIntensityIcon(
            intensity: level,
            type: .filled,
            size: 28,
          ),
      ],
    );
  }
}

class _LpgmLegend extends StatelessWidget {
  const _LpgmLegend({required this.intensity});
  final EarthquakeIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final levels =
        intensity.lpgmIntensityTree.keys
            .where((k) => k != JmaLpgmIntensity.zero)
            .toList()
          ..sort((a, b) => b.index.compareTo(a.index));
    if (levels.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        for (final level in levels)
          JmaLpgmIntensityIcon(
            intensity: level,
            type: .filled,
            size: 28,
          ),
      ],
    );
  }
}
