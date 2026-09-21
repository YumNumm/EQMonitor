import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/region_intensity_result.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

final class const EarthquakeRegionSelection() {
  RegionKind kind(RegionSearchType type) => switch (type) {
    .prefecture => .prefecture,
    .region => .region,
    .city => .city,
    .station => .station,
  };

  RegionIntensityResult result({
    required RegionOption option,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
  }) => (
    searchType: switch (option.kind) {
      .prefecture => .prefecture,
      .region => .region,
      .city => .city,
      .station => .station,
      _ => throw ArgumentError.value(option.kind),
    },
    code: option.code,
    name: option.name,
    intensityGte: intensityGte,
    intensityLte: intensityLte,
  );

  List<RegionOption> initial(EarthquakeHistoryParameter? parameter) {
    final value = parameter?.regionSelection;
    return value == null
        ? const []
        : [RegionOption(kind: kind(value.$1), code: value.$2, name: value.$2)];
  }

  EarthquakeHistoryParameter parameter(RegionOption? option) {
    const initial = EarthquakeHistoryParameter.all(
      sortBy: .eventId,
      sortOrder: .desc,
    );
    if (option == null) {
      return initial;
    }
    if (option.kind == .epicenter) {
      return initial.copyWith(epicenterCodes: [int.parse(option.code)]);
    }
    return initial.withRegion(result(option: option));
  }
}
