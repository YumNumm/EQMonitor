import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:flutter/material.dart';

/// 類似度を5セルのゲージ + グレード文字で表示する。
///
/// 類似度が高い(グレードA)ほど多くのセルが点灯する。
class SimilarEarthquakeGauge extends StatelessWidget {
  const SimilarEarthquakeGauge({required this.grade, super.key});

  final SimilarityGrade grade;

  static const _cellCount = 5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '類似度',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 6),
        for (var i = 0; i < _cellCount; i++)
          SimilarityGaugeCell(
            key: ValueKey('gauge-cell-$i'),
            lit: i < grade.litCells,
            color: grade.color,
          ),
        const SizedBox(width: 6),
        Text(
          grade.label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: grade.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// ゲージの1セル。点灯時は[color]、消灯時は薄いグレーで塗る。
@visibleForTesting
class SimilarityGaugeCell extends StatelessWidget {
  const SimilarityGaugeCell({
    required this.lit,
    required this.color,
    super.key,
  });

  final bool lit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final unlitColor = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.12);
    return Container(
      width: 10,
      height: 14,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: lit ? color : unlitColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
