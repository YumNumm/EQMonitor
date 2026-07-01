import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';

class HomeEarthquakeList extends StatelessWidget {
  const HomeEarthquakeList({
    required this.earthquakes,
    required this.intensityColor,
    this.showCurrentLocationIntensity = false,
    super.key,
  });

  final List<EarthquakePartial> earthquakes;
  final bool showCurrentLocationIntensity;
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Column(
      children: earthquakes
          .take(3)
          .map(
            (item) => InkWell(
              borderRadius: BorderRadius.circular(shape.md),
              onTap: () async => EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing.lg),
                child: EarthquakeHistoryListTile(
                  intensityColor: intensityColor,
                  visualDensity: .compact,
                  item: item,
                  showBackgroundColor: false,
                  intensityIconSize: 32,
                  titleTextColor: colorTheme.onSurface,
                  descriptionTextColor: colorTheme.onSurfaceVariant,
                  magnitudeTextColor: colorTheme.onSurface,
                  dense: true,
                  contentPadding: .zero,
                  showCurrentLocationIntensity: showCurrentLocationIntensity,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
