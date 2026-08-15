import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:material_ui/material_ui.dart';

class HomeEarthquakeList extends StatelessWidget {
  const HomeEarthquakeList({
    required this.earthquakes,
    this.showCurrentLocationIntensity = false,
    super.key,
  });

  final List<EarthquakePartial> earthquakes;
  final bool showCurrentLocationIntensity;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, item) in earthquakes.take(3).indexed) ...[
          if (index != 0)
            Divider(height: 1, indent: spacing.lg, endIndent: spacing.lg),
          InkWell(
            onTap: () async =>
                EarthquakeHistoryDetailsRoute(eventId: item.earthquake.eventId)
                    .push<void>(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing.lg),
              child: EarthquakeHistoryListTile(
                visualDensity: .compact,
                item: item,
                searchParameter: EarthquakeHistoryParameter.all(
                  sortBy: .eventId,
                  sortOrder: .desc,
                ),
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
        ],
      ],
    );
  }
}
