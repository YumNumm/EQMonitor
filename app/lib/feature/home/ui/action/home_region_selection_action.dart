import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_region_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:flutter/widgets.dart';

final class const HomeRegionSelectionAction() {
  Future<EarthquakeHistoryParameter?> pick({
    required BuildContext context,
    EarthquakeHistoryParameter? initialParameter,
  }) async {
    const converter = EarthquakeRegionSelection();
    final selected = await RegionSelectionRoute(
      $extra: RegionSelectionRequest(
        title: '指定地域を選択',
        initialSelection: converter.initial(initialParameter),
        allowEmpty: true,
      ),
    ).push<List<RegionOption>>(context);
    return selected == null ? null : converter.parameter(selected.firstOrNull);
  }
}
