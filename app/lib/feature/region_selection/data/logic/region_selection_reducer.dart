import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';

final class const RegionSelectionReducer() {
  List<RegionOption> select({
    required List<RegionOption> selected,
    required RegionOption option,
    required RegionSelectionMode mode,
  }) => switch (mode) {
    .single => [option],
    .multiple =>
      selected.any((item) => item.identity == option.identity)
          ? remove(selected: selected, option: option)
          : [...selected, option],
  };

  List<RegionOption> remove({
    required List<RegionOption> selected,
    required RegionOption option,
  }) => selected.where((item) => item.identity != option.identity).toList();

  List<RegionOption> restore({
    required List<RegionOption> selected,
    required List<RegionOption> catalog,
    required RegionSelectionMode mode,
  }) {
    final byIdentity = {for (final item in catalog) item.identity: item};
    final restored = <String, RegionOption>{};
    for (final item in selected) {
      restored[item.identity] = byIdentity[item.identity] ?? item;
      if (mode == .single) {
        break;
      }
    }
    return restored.values.toList();
  }
}
