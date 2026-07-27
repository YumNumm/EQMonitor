import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_summary_header.dart';
import 'package:flutter/material.dart';

class EarthquakeHypocenterInformationCard extends StatelessWidget {
  const EarthquakeHypocenterInformationCard({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context) {
    final intensityColors = context.designSystem.colorTheme.intensity;
    final maxIntensity = item.intensity?.maxIntensity;
    final colorEntry = maxIntensity != null
        ? intensityColors.fromJmaIntensity(maxIntensity)
        : null;
    final cardBackgroundColor = colorEntry?.background ?? Colors.transparent;
    final cardColor = cardBackgroundColor.withValues(alpha: 0.3);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ).add(const EdgeInsets.only(bottom: 4)),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBackgroundColor, width: 0),
      ),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: EarthquakeSummaryHeader(item: item),
      ),
    );
  }
}
