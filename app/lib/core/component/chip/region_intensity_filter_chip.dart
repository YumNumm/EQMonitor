import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_region_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/region_intensity_result.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:material_ui/material_ui.dart';

export 'package:eqmonitor/feature/earthquake_history/data/model/region_intensity_result.dart';

class RegionIntensityFilterChip extends StatelessWidget {
  const new({
    this.regionSearchType,
    this.regionCode,
    this.regionName,
    this.regionIntensityGte,
    this.regionIntensityLte,
    this.onChanged,
    super.key,
  });

  final RegionSearchType? regionSearchType;
  final String? regionCode;
  final String? regionName;
  final JmaIntensity? regionIntensityGte;
  final JmaIntensity? regionIntensityLte;
  final ValueChanged<RegionIntensityResult?>? onChanged;

  @override
  Widget build(BuildContext context) {
    const converter = EarthquakeRegionSelection();
    final code = regionCode;
    final type = regionSearchType;
    final range = switch ((regionIntensityGte, regionIntensityLte)) {
      (null, null) => '',
      (final min?, final max?) when min == max => '（震度${min.label}）',
      (final min?, final max?) => '（震度${min.label}〜${max.label}）',
      (final min?, null) => '（震度${min.label}以上）',
      (null, final max?) => '（震度${max.label}以下）',
    };
    return RawChip(
      selected: code != null,
      label: Text(code == null ? '地域' : '${regionName ?? code}$range'),
      onDeleted: code == null ? null : () => onChanged?.call(null),
      onSelected: (_) async {
        final result = await RegionSelectionRoute(
          $extra: RegionSelectionRequest(
            title: '観測地域を選択',
            allowEmpty: true,
            initialSelection: [
              if (code != null && type != null)
                RegionOption(
                  kind: converter.kind(type),
                  code: code,
                  name: regionName ?? code,
                ),
            ],
          ),
        ).push<List<RegionOption>>(context);
        if (result == null) {
          return;
        }
        final selected = result.firstOrNull;
        onChanged?.call(
          selected == null
              ? null
              : converter.result(
                  option: selected,
                  intensityGte: regionIntensityGte,
                  intensityLte: regionIntensityLte,
                ),
        );
      },
    );
  }
}
