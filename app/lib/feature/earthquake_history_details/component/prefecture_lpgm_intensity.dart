import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lg_intensity_icon.dart';
import 'package:eqmonitor/core/extension/map_to_list.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_lpgm_intensity.g.dart';

typedef _Arg = ({
  List<ObservedRegionLpgmIntensity> prefectures,
  List<ObservedRegionLpgmIntensity>? cities,
  List<ObservedRegionLpgmIntensity>? stations,
});

@riverpod
Future<Map<JmaLgIntensity, List<_MergedRegionIntensity>>> _lpgmCalculator(
  _LpgmCalculatorRef ref,
  _Arg arg,
) =>
    compute<_Arg, Map<JmaLgIntensity, List<_MergedRegionIntensity>>>(
      (
        _Arg arg,
      ) {
        final cities = arg.cities;
        final prefectures = arg.prefectures;
        final stations = arg.stations;

        if (stations != null && cities != null) {
          final stationsGroupedByIntensity = stations
              .where((e) => e.lpgmIntensity != null)
              .groupListsBy((e) => e.lpgmIntensity!);
          return stationsGroupedByIntensity.map((intensity, stations) {
            final stationsGroupedByCity =
                stations.groupListsBy((e) => '${e.code.substring(0, 5)}00');
            // マージ
            final mergedCity = stationsGroupedByCity.entries
                .map((e) {
                  final cityCode = e.key;
                  final cityStations = e.value;
                  final city =
                      cities.firstWhereOrNull((e) => e.code == cityCode);
                  if (city == null) {
                    return null;
                  }
                  return _CityIntensity(
                    code: city.code,
                    name: city.name,
                    intensity: intensity,
                    stations: cityStations,
                  );
                })
                .whereType<_CityIntensity>()
                .toList();

            // 都道府県ごとにまとめる
            final citiesGroupedByPrefecture =
                mergedCity.groupListsBy((e) => e.code.substring(0, 2));
            // マージ
            final mergedPrefecture = citiesGroupedByPrefecture.entries
                .map((e) {
                  final prefectureCode = e.key;
                  final prefectureCities = e.value;
                  final prefecture = prefectures
                      .firstWhereOrNull((e) => e.code == prefectureCode);
                  if (prefecture == null) {
                    return null;
                  }
                  return _MergedRegionIntensity(
                    code: prefecture.code,
                    name: prefecture.name,
                    intensity: intensity,
                    cities: prefectureCities,
                  );
                })
                .whereType<_MergedRegionIntensity>()
                .toList();
            return MapEntry(intensity, mergedPrefecture);
          });
        } else {
          return prefectures
              .where((e) => e.lpgmIntensity != null)
              .groupListsBy((e) => e.lpgmIntensity!)
              .map(
                (intensity, prefectures) => MapEntry(
                  intensity,
                  prefectures
                      .map(
                        (e) => _MergedRegionIntensity(
                          code: e.code,
                          name: e.name,
                          intensity: intensity,
                          cities: null,
                        ),
                      )
                      .toList(),
                ),
              );
        }
      },
      arg,
    );

class PrefectureLpgmIntensityWidget extends HookConsumerWidget {
  const PrefectureLpgmIntensityWidget({
    super.key,
    required this.item,
  });

  final EarthquakeV1 item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final mergedPrefecturesFuture = ref.watch(
      _LpgmCalculatorProvider(
        (
          prefectures: item.lpgmIntensityPrefectures ?? [],
          // FIXME(YumNumm)
          cities: item.lpgmIntensityPrefectures,
          stations: item.lpgmIntenstiyStations,
        ),
      ),
    );

    return switch (mergedPrefecturesFuture) {
      AsyncLoading() => const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      AsyncData(:final value) => BorderedContainer(
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
              for (final kv in value.toList.sorted(
                (a, b) => a.key < b.key ? 1 : -1,
              ))
                ListTile(
                  titleAlignment: ListTileTitleAlignment.titleHeight,
                  leading: JmaLgIntensityIcon(
                    intensity: kv.key,
                    type: IntensityIconType.filled,
                  ),
                  title: Text(
                    '長周期地震動階級${kv.key.type}',
                    style: textTheme.titleMedium!.copyWith(
                      fontFamily: FontFamily.jetBrainsMono,
                      fontFamilyFallback: [FontFamily.notoSansJP],
                    ),
                  ),
                  subtitle: Text(
                    kv.value.map((e) => e.name).join(', ').toHalfWidth,
                  ),
                ),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _MergedRegionIntensity {
  _MergedRegionIntensity({
    required this.code,
    required this.name,
    required this.intensity,
    required this.cities,
  });

  final String code;
  final String name;
  final JmaLgIntensity intensity;
  final List<_CityIntensity>? cities;
}

class _CityIntensity {
  _CityIntensity({
    required this.code,
    required this.name,
    required this.intensity,
    required this.stations,
  });

  final String code;
  final String name;
  final JmaLgIntensity intensity;
  final List<ObservedRegionLpgmIntensity> stations;
}
