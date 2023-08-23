import 'package:collection/collection.dart';
import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqapi_schema/model/components/region_intensity.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/extension/map_to_list.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrefectureIntensityWidget extends HookConsumerWidget {
  const PrefectureIntensityWidget({
    super.key,
    required this.item,
  });

  final EarthquakeHistoryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final intensity = item.earthquake.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }
    final mergedPrefecturesFuture = useFuture(
      // 重めなので別Isolateで計算
      compute(
        (
          ({
            List<RegionIntensity>? cities,
            List<RegionIntensity> prefectures,
            List<RegionIntensity>? stations
          }) arg,
        ) {
          final result = arg.prefectures.map(
            (e) => _MergedPrefectureIntensity.fromIntensity(
              e,
              arg.cities ?? [],
              arg.stations ?? [],
            ),
          );

          // 最大震度ごとにグループ
          final intensityGroupedPrefectures =
              result.groupListsBy((e) => e.prefecture.maxInt);
          return intensityGroupedPrefectures;
        },
        (
          prefectures: intensity.prefectures,
          cities: intensity.cities,
          stations: intensity.stations,
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
              title: '各地の震度',
            ),
            // 震度一覧
            for (final kv in mergedPrefectures.toList
                .where((kv) => kv.key != null)
                .cast<
                    ({
                      JmaIntensity key,
                      List<_MergedPrefectureIntensity> value
                    })>())
              ListTile(
                leading: JmaIntensityIcon(
                  intensity: kv.key,
                  type: IntensityIconType.filled,
                  size: 16,
                ),
                title: Text(
                  '震度${kv.key.type}',
                  style: textTheme.titleMedium!.copyWith(
                    fontFamily: FontFamily.jetBrainsMono,
                    fontFamilyFallback: [FontFamily.notoSansJP],
                  ),
                ),
                subtitle: Text(
                  kv.value.map((e) => e.prefecture.name).join(', '),
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

class _MergedPrefectureIntensity {
  factory _MergedPrefectureIntensity.fromIntensity(
    RegionIntensity prefecture,
    List<RegionIntensity> allCities,
    List<RegionIntensity> allStations,
  ) {
    final prefectureCode = prefecture.code;
    final cities = allCities
        .where((e) => e.code.startsWith(prefectureCode))
        .map((e) => _MergedCityIntensity.fromIntensity(e, allStations))
        .toList();
    return _MergedPrefectureIntensity._(
      prefecture: prefecture,
      cities: cities,
    );
  }

  _MergedPrefectureIntensity._({
    required this.prefecture,
    required this.cities,
  });

  final RegionIntensity prefecture;
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
