import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lg_intensity_icon.dart';
import 'package:eqmonitor/core/extension/map_to_list.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrefectureLpgmIntensityWidget extends HookConsumerWidget {
  const PrefectureLpgmIntensityWidget({
    super.key,
    required this.item,
  });

  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final intensity = item.earthquake.lgIntensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }
    final mergedPrefecturesFuture = useFuture(
      // 重めなので別Isolateで計算
      compute(
        (
          ({
            List<RegionIntensity> regions,
            List<RegionIntensity>? cities,
            List<RegionIntensity>? stations
          }) arg,
        ) {
          final result = arg.regions.map(
            (region) => _MergedRegionIntensity.fromIntensity(
              region,
              arg.cities ?? [],
              arg.stations ?? [],
            ),
          );

          // 最大震度ごとにグループ
          final intensityGroupedPrefectures =
              result.groupListsBy((e) => e.region.maxLgInt);
          return intensityGroupedPrefectures;
        },
        (
          cities: intensity.cities,
          stations: intensity.stations,
          regions: intensity.regions,
        ),
        debugLabel: 'prefecture',
      ),
    );
    final mergedPrefectures = mergedPrefecturesFuture.data;

    if (mergedPrefectures != null && mergedPrefectures.isNotEmpty) {
      return BorderedContainer(
        elevation: 1,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          children: [
            const SheetHeader(
              title: '各地の長周期地震動観測状況',
            ),
            // 長周期地震動階級の種別
            
            // 震度一覧
            for (final kv in mergedPrefectures.toList
                .where((kv) => kv.key != null)
                .cast<
                    ({
                      JmaLgIntensity key,
                      List<_MergedRegionIntensity> value
                    })>()
                .sorted(
                  (a, b) => a.key < b.key ? 1 : -1,
                ))
              ListTile(
                titleAlignment: ListTileTitleAlignment.titleHeight,
                leading: JmaLgIntensityIcon(
                  intensity: kv.key,
                  type: IntensityIconType.filled,
                  size: 16,
                ),
                title: Text(
                  '長周期地震動階級${kv.key.type}',
                  style: textTheme.titleMedium!.copyWith(
                    fontFamily: FontFamily.jetBrainsMono,
                    fontFamilyFallback: [FontFamily.notoSansJP],
                  ),
                ),
                subtitle: Text(
                  kv.value.map((e) => e.region.name).join(', ').toHalfWidth,
                ),
              ),
          ],
        ),
      );
    }
    return switch (mergedPrefecturesFuture.connectionState) {
      ConnectionState.waiting => const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _RegionListTile extends HookWidget {
  const _RegionListTile({
    required this.region,
  });

  final _MergedRegionIntensity region;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final shrinked = ListTile(
      title: Text(
        region.region.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.expand_more),
      onTap: () => isExpanded.value = true,
    );
    final expanded = ListTile(
      title: Text(
        region.region.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final city in region.cities)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${city.city.name}: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (final station in city.stations)
                    TextSpan(
                      text: '${station.name} ',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
      onTap: () => isExpanded.value = false,
      trailing: const Icon(Icons.expand_less),
    );
    return AnimatedCrossFade(
      firstChild: shrinked,
      secondChild: expanded,
      crossFadeState: isExpanded.value
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class _MergedRegionIntensity {
  factory _MergedRegionIntensity.fromIntensity(
    RegionIntensity region,
    List<RegionIntensity> allCities,
    List<RegionIntensity> allStations,
  ) {
    final regionCode = region.code;
    final cities = allCities
        .where((e) => e.code.startsWith(regionCode))
        .map((e) => _MergedCityIntensity.fromIntensity(e, allStations))
        .toList();
    return _MergedRegionIntensity._(
      region: region,
      cities: cities,
    );
  }

  _MergedRegionIntensity._({
    required this.region,
    required this.cities,
  });

  final RegionIntensity region;
  final List<_MergedCityIntensity> cities;
}

class _MergedCityIntensity {
  factory _MergedCityIntensity.fromIntensity(
    RegionIntensity city,
    List<RegionIntensity> allStations,
  ) {
    // ex: `0320700` -> `03207`
    final cityCode = city.code.substring(0, 5);
    final stations =
        allStations.where((e) => e.code.startsWith(cityCode)).toList();
    return _MergedCityIntensity._(city: city, stations: stations);
  }
  _MergedCityIntensity._({required this.city, required this.stations});

  final RegionIntensity city;
  final List<RegionIntensity> stations;
}
