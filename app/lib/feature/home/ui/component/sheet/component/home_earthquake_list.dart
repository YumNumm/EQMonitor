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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: earthquakes
          .take(3)
          .map(
            (item) => InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async => EarthquakeHistoryDetailsRoute(
                eventId: item.eventId,
              ).push<void>(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EarthquakeHistoryListTile(
                  visualDensity: VisualDensity.compact,
                  item: item,
                  showBackgroundColor: false,
                  intensityIconSize: 32,
                  titleTextColor: colorScheme.onSurfaceVariant,
                  descriptionTextColor: colorScheme.onSurfaceVariant,
                  magnitudeTextColor: colorScheme.onPrimaryContainer,
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
