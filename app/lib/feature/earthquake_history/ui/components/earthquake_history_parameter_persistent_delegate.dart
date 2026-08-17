import 'package:core/core.dart' show Date;
import 'package:eqmonitor/core/component/chip/datasource_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/earthquake_type_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/lat_lng_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/lpgm_intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/region_intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/sort_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/telegram_type_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/region_name_resolver.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryParameterPersistentDelegate
    extends SliverPersistentHeaderDelegate {
  const new({
    required this.parameter,
    required this.onChanged,
  });

  static const double height = 48;

  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: context.designSystem.colorTheme.surface,
      child: _FilterChipBar(parameter: parameter, onChanged: onChanged),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(
    covariant EarthquakeHistoryParameterPersistentDelegate oldDelegate,
  ) => parameter != oldDelegate.parameter;
}

class _FilterChipBar extends ConsumerWidget {
  const new({required this.parameter, required this.onChanged});

  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = context.designSystem.spacing;
    final isDebugEnabled = ref.watch(debugProvider).value ?? false;

    // 地域絞り込み中かどうか
    final isRegionFiltered = parameter is! EarthquakeHistoryParameterAll;

    // 現在の地域コード/種別を取得し、表示名を解決する
    final regionSel = parameter.regionSelection;
    final regionName = regionSel != null
        ? ref
                  .watch(regionNameProvider(regionSel.$1, regionSel.$2))
                  .whenOrNull(data: (name) => name) ??
              regionSel.$2
        : null;

    final chips = <({int order, bool isActive, Widget chip})>[
      (
        order: 0,
        isActive: true,
        chip: SortFilterChip(
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
          sortByLocked: isRegionFiltered,
          onChanged: (sortBy, sortOrder) => onChanged(
            parameter.copyWith(sortBy: sortBy, sortOrder: sortOrder),
          ),
        ),
      ),
      (
        order: 1,
        isActive:
            parameter.intensityGte != null || parameter.intensityLte != null,
        chip: IntensityFilterChip(
          min: parameter.intensityGte,
          max: parameter.intensityLte,
          onChanged: (min, max) => onChanged(
            parameter.copyWith(intensityGte: min, intensityLte: max),
          ),
        ),
      ),
      (
        order: 2,
        isActive:
            parameter.magnitudeGte != null || parameter.magnitudeLte != null,
        chip: MagnitudeFilterChip(
          min: parameter.magnitudeGte,
          max: parameter.magnitudeLte,
          onChanged: (min, max) => onChanged(
            parameter.copyWith(magnitudeGte: min, magnitudeLte: max),
          ),
        ),
      ),
      (
        order: 3,
        isActive: parameter.depthGte != null || parameter.depthLte != null,
        chip: DepthFilterChip(
          min: parameter.depthGte,
          max: parameter.depthLte,
          onChanged: (min, max) =>
              onChanged(parameter.copyWith(depthGte: min, depthLte: max)),
        ),
      ),
      (
        order: 4,
        isActive: parameter.earthquakeType != null,
        chip: EarthquakeTypeFilterChip(
          earthquakeType: parameter.earthquakeType,
          onChanged: (type) =>
              onChanged(parameter.copyWith(earthquakeType: type)),
        ),
      ),
      (
        order: 5,
        isActive:
            parameter.originTimeGte != null || parameter.originTimeLte != null,
        chip: DateRangeFilterChip(
          min: parameter.originTimeGte?.toDateTime(),
          max: parameter.originTimeLte?.toDateTime(),
          onChanged: (min, max) => onChanged(
            parameter.copyWith(
              originTimeGte: min != null ? Date.fromDateTime(min) : null,
              originTimeLte: max != null ? Date.fromDateTime(max) : null,
            ),
          ),
        ),
      ),
      (
        order: 6,
        isActive:
            parameter.maxLpgmIntensityGte != null ||
            parameter.maxLpgmIntensityLte != null,
        chip: LpgmIntensityFilterChip(
          min: parameter.maxLpgmIntensityGte,
          max: parameter.maxLpgmIntensityLte,
          onChanged: (min, max) => onChanged(
            parameter.copyWith(
              maxLpgmIntensityGte: min,
              maxLpgmIntensityLte: max,
            ),
          ),
        ),
      ),
      if (isDebugEnabled)
        (
          order: 7,
          isActive: parameter.statuses != null,
          chip: StatusFilterChip(
            statuses: parameter.statuses,
            onChanged: (statuses) {
              if (statuses == null) {
                onChanged(parameter.copyWith(statuses: null));
              } else {
                onChanged(parameter.copyWith(statuses: statuses));
              }
            },
          ),
        ),
      (
        order: 8,
        isActive: isRegionFiltered,
        chip: RegionIntensityFilterChip(
          regionSearchType: switch (parameter) {
            EarthquakeHistoryParameterRegion() => RegionSearchType.region,
            EarthquakeHistoryParameterPrefecture() =>
              RegionSearchType.prefecture,
            EarthquakeHistoryParameterCity() => RegionSearchType.city,
            EarthquakeHistoryParameterStation() => RegionSearchType.station,
            _ => null,
          },
          regionCode: switch (parameter) {
            EarthquakeHistoryParameterRegion(:final regionCode) => regionCode,
            EarthquakeHistoryParameterPrefecture(:final prefectureCode) =>
              prefectureCode,
            EarthquakeHistoryParameterCity(:final cityCode) => cityCode,
            EarthquakeHistoryParameterStation(:final stationCode) =>
              stationCode,
            _ => null,
          },
          regionName: regionName,
          regionIntensityGte: parameter.intensityGte,
          regionIntensityLte: parameter.intensityLte,
          onChanged: (result) {
            onChanged(
              result == null ? parameter.toAll() : parameter.withRegion(result),
            );
          },
        ),
      ),
      // 地域絞り込み中は Datasource(9)/TelegramType(10)/LatLng(11) を含めない
      if (!isRegionFiltered) ...[
        (
          order: 9,
          isActive: parameter.datasource != null,
          chip: DatasourceFilterChip(
            datasource: parameter.datasource,
            onChanged: (dataSource) =>
                onChanged(parameter.copyWith(datasource: dataSource)),
          ),
        ),
        if (isDebugEnabled)
          (
            order: 10,
            isActive: parameter.telegramTypes != null,
            chip: TelegramTypeFilterChip(
              telegramTypes: parameter.telegramTypes,
              onChanged: (types) =>
                  onChanged(parameter.copyWith(telegramTypes: types)),
            ),
          ),
        (
          order: 11,
          isActive:
              parameter.latitudeGte != null ||
              parameter.latitudeLte != null ||
              parameter.longitudeGte != null ||
              parameter.longitudeLte != null,
          chip: LatLngFilterChip(
            latitudeGte: parameter.latitudeGte,
            latitudeLte: parameter.latitudeLte,
            longitudeGte: parameter.longitudeGte,
            longitudeLte: parameter.longitudeLte,
            onChanged: (range) {
              if (range == null) {
                onChanged(
                  parameter.copyWith(
                    latitudeGte: null,
                    latitudeLte: null,
                    longitudeGte: null,
                    longitudeLte: null,
                  ),
                );
              } else {
                onChanged(
                  parameter.copyWith(
                    latitudeGte: range.latitudeGte,
                    latitudeLte: range.latitudeLte,
                    longitudeGte: range.longitudeGte,
                    longitudeLte: range.longitudeLte,
                  ),
                );
              }
            },
          ),
        ),
      ],
    ];

    chips.sort((a, b) {
      final aActive = a.isActive ? 0 : 1;
      final bActive = b.isActive ? 0 : 1;
      if (aActive != bActive) {
        return aActive.compareTo(bActive);
      }
      return a.order.compareTo(b.order);
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          spacing: spacing.sm,
          children: [for (final entry in chips) entry.chip],
        ),
      ),
    );
  }
}
