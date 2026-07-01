import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:flutter/material.dart';

class EarthquakeLpgmIntensityCard extends StatelessWidget {
  const EarthquakeLpgmIntensityCard({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final maxLpgmIntensity = item.intensity?.maxLpgmIntensity;
    if (maxLpgmIntensity == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return BorderedContainer(
      elevation: 1,
      child: Row(
        children: [
          JmaLpgmIntensityIcon(
            intensity: maxLpgmIntensity,
            type: .filled,
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '最大長周期地震動階級',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.designSystem.colorTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '階級${maxLpgmIntensity.label}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
