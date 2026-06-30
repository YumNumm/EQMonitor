import 'dart:ui';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';

/// 震度色の凡例ウィジェット。
///
/// 震度0〜7（降順）を横に並べて表示する。
class IntensityHistoryLegend extends StatelessWidget {
  const IntensityHistoryLegend({super.key});

  static const List<JmaIntensity> _levels = [
    JmaIntensity.seven,
    JmaIntensity.sixUpper,
    JmaIntensity.sixLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.fiveLower,
    JmaIntensity.four,
    JmaIntensity.three,
    JmaIntensity.two,
    JmaIntensity.one,
    JmaIntensity.zero,
  ];

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: .antiAlias,
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
          tileMode: .decal,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            alignment: .end,
            children: _levels
                .map(
                  (level) => JmaIntensityIcon(
                    intensity: level,
                    type: IntensityIconType.filled,
                    size: 28,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
