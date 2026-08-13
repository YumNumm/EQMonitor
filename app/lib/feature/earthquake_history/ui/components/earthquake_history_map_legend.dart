import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:material_ui/material_ui.dart';

/// 震度凡例オーバーレイウィジェット
///
/// 現在のデータで実際に観測されている震度範囲のみを表示する。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級を表示する。
/// [shindoDbTree] が指定された場合は震度DBモードの凡例を表示する。
class EarthquakeHistoryMapLegend extends StatelessWidget {
  const EarthquakeHistoryMapLegend({
    required this.intensity,
    this.showingLpgmIntensity = false,
    this.shindoDbTree,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final bool showingLpgmIntensity;
  final ShindoDbIntensityTree? shindoDbTree;

  @override
  Widget build(BuildContext context) {
    if (shindoDbTree != null) {
      return Card(
        color: context.designSystem.colorTheme.surface.withValues(alpha: 0.85),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: _ShindoDbLegend(tree: shindoDbTree!),
        ),
      );
    }

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
          JmaIntensityIcon(intensity: level, type: .filled, size: 28),
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
          JmaLpgmIntensityIcon(intensity: level, type: .filled, size: 28),
      ],
    );
  }
}

class _ShindoDbLegend extends StatelessWidget {
  const _ShindoDbLegend({required this.tree});
  final ShindoDbIntensityTree tree;

  @override
  Widget build(BuildContext context) {
    final classes = tree.tree.keys.toList()
      ..sort((a, b) => b.orderIndex.compareTo(a.orderIndex));
    if (classes.isEmpty) {
      return const SizedBox.shrink();
    }

    final hasHistorical = classes.any((c) => c.colorJmaIntensity == null);
    final numericClasses = classes.where((c) => c.colorJmaIntensity != null);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        for (final cls in numericClasses)
          ShindoDbIntensityClassIcon(intensityClass: cls, size: 28),
        if (hasHistorical)
          Tooltip(
            message: '不明 (グレー)',
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: context.designSystem.colorTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    color: context.designSystem.colorTheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
