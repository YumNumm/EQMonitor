import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_level.dart';
import 'package:flutter/material.dart';

class SimilarityScoreIndicator extends StatelessWidget {
  const SimilarityScoreIndicator({
    required this.level,
    super.key,
  });

  final SimilarityLevel level;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;
    final filledCount = level.filledCount;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(left: i > 0 ? 2 : 0),
            child: SizedBox(
              width: 8,
              height: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: i < filledCount
                      ? colorTheme.primary
                      : colorTheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        const SizedBox(width: 4),
        Text(
          level.name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
