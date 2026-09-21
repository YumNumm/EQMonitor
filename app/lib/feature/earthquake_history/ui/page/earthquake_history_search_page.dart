import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_region_selection.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/ui/page/region_selection_page.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeHistorySearchPage extends StatelessWidget {
  const new({required this.initialQuery, super.key});

  final String initialQuery;

  @override
  Widget build(BuildContext context) => RegionSelectionPage(
    request: RegionSelectionRequest(
      title: '地域名で地震を検索',
      initialQuery: initialQuery,
      kinds: const [.prefecture, .region, .city, .epicenter],
    ),
    onConfirmed: (selected) {
      final option = selected.firstOrNull;
      if (option != null) {
        EarthquakeHistoryRoute(
          $extra: const EarthquakeRegionSelection().parameter(option),
        ).push<void>(context);
      }
    },
  );
}
