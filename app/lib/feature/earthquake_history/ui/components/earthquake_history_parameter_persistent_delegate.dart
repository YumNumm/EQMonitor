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
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter/material.dart';

class EarthquakeHistoryParameterPersistentDelegate
    extends SliverPersistentHeaderDelegate {
  const EarthquakeHistoryParameterPersistentDelegate({
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
      color: Theme.of(context).colorScheme.surface,
      child: _FilterChipBar(
        parameter: parameter,
        onChanged: onChanged,
      ),
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

class _FilterChipBar extends StatelessWidget {
  const _FilterChipBar({required this.parameter, required this.onChanged});

  final EarthquakeHistoryParameter parameter;
  final void Function(EarthquakeHistoryParameter) onChanged;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).designSystemThemeExtension.spacing;

    final chips = <({int order, bool isActive, Widget chip})>[
      (
        order: 0,
        isActive: parameter.sortBy != null || parameter.sortOrder != null,
        chip: SortFilterChip(
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
          onChanged: (sortBy, sortOrder) =>
              onChanged(parameter.updateSort(sortBy, sortOrder)),
        ),
      ),
      (
        order: 1,
        isActive:
            parameter.intensityGte != null || parameter.intensityLte != null,
        chip: IntensityFilterChip(
          min: parameter.intensityGte,
          max: parameter.intensityLte,
          onChanged: (min, max) =>
              onChanged(parameter.updateIntensity(min, max)),
        ),
      ),
      (
        order: 2,
        isActive:
            parameter.magnitudeGte != null || parameter.magnitudeLte != null,
        chip: MagnitudeFilterChip(
          min: parameter.magnitudeGte,
          max: parameter.magnitudeLte,
          onChanged: (min, max) =>
              onChanged(parameter.updateMagnitude(min, max)),
        ),
      ),
      (
        order: 3,
        isActive: parameter.depthGte != null || parameter.depthLte != null,
        chip: DepthFilterChip(
          min: parameter.depthGte,
          max: parameter.depthLte,
          onChanged: (min, max) => onChanged(parameter.updateDepth(min, max)),
        ),
      ),
      (
        order: 4,
        isActive: parameter.earthquakeType != null,
        chip: EarthquakeTypeFilterChip(
          earthquakeType: parameter.earthquakeType,
          onChanged: (type) => onChanged(parameter.updateEarthquakeType(type)),
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
            parameter.updateOriginTimeRange(
              min != null ? Date.fromDateTime(min) : null,
              max != null ? Date.fromDateTime(max) : null,
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
          onChanged: (min, max) =>
              onChanged(parameter.updateLpgmIntensity(min, max)),
        ),
      ),
      (
        order: 7,
        isActive: parameter.statuses != null,
        chip: StatusFilterChip(
          statuses: parameter.statuses,
          onChanged: (statuses) =>
              onChanged(parameter.updateStatuses(statuses)),
        ),
      ),
      (
        order: 8,
        isActive: parameter.regionCode != null,
        chip: RegionIntensityFilterChip(
          regionSearchType: parameter.regionSearchType,
          regionCode: parameter.regionCode,
          regionName: parameter.regionName,
          regionIntensityGte: parameter.regionIntensityGte,
          regionIntensityLte: parameter.regionIntensityLte,
          onChanged: (result) {
            if (result == null) {
              onChanged(
                parameter.updateRegion(
                  regionSearchType: null,
                  regionCode: null,
                  regionName: null,
                ),
              );
            } else {
              onChanged(
                parameter.updateRegion(
                  regionSearchType: result.searchType,
                  regionCode: result.code,
                  regionName: result.name,
                  regionIntensityGte: result.intensityGte,
                  regionIntensityLte: result.intensityLte,
                ),
              );
            }
          },
        ),
      ),
      (
        order: 9,
        isActive: parameter.datasource != null,
        chip: DatasourceFilterChip(
          datasource: parameter.datasource,
          onChanged: (ds) => onChanged(parameter.updateDatasource(ds)),
        ),
      ),
      (
        order: 10,
        isActive: parameter.telegramTypes != null,
        chip: TelegramTypeFilterChip(
          telegramTypes: parameter.telegramTypes,
          onChanged: (types) => onChanged(parameter.updateTelegramTypes(types)),
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
                parameter.updateLatLngRange(),
              );
            } else {
              onChanged(
                parameter.updateLatLngRange(
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
          children: [
            for (final entry in chips) entry.chip,
          ],
        ),
      ),
    );
  }
}
