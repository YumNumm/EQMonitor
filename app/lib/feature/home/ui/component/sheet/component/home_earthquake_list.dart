import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';

class HomeEarthquakeList extends StatelessWidget {
  const HomeEarthquakeList({
    required this.earthquakes,
    super.key,
  });

  final List<EarthquakePartial> earthquakes;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final textColor = designSystem.textColor;
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
                  visualDensity: VisualDensity.compact,
                  item: item,
                  showBackgroundColor: false,
                  intensityIconSize: 32,
                  titleTextColor: textColor.primary,
                  descriptionTextColor: textColor.secondary,
                  magnitudeTextColor: designSystem.palette.brandPrimary,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
