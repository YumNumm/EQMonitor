import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/route.dart';

part 'prefecture_intensity.g.dart';

typedef _Arg = ({
  List<ObservedRegionIntensity>? cities,
  List<ObservedRegionIntensity> prefectures,
  List<ObservedRegionIntensity>? stations,
});

@riverpod
Future<Map<JmaIntensity, List<_MergedRegionIntensity>>> _calculator(
  _CalculatorRef ref,
  _Arg arg,
) =>
    compute<_Arg, Map<JmaIntensity, List<_MergedRegionIntensity>>>(
      (
        _Arg arg,
      ) {
        final cities = arg.cities;
        final prefectures = arg.prefectures;
        final stations = arg.stations;

        final Map<JmaIntensity, List<_MergedRegionIntensity>> result;
        if (stations != null && cities != null) {
          final stationsGroupedByIntensity = stations
              .where((e) => e.intensity != null)
              .groupListsBy((e) => e.intensity!);
          result = stationsGroupedByIntensity.map((intensity, stations) {
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
          result = prefectures
              .where((e) => e.intensity != null)
              .groupListsBy((e) => e.intensity!)
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
        final reorderedResult = result.entries
            .sorted((a, b) => a.key.index.compareTo(b.key.index))
            .toList()
            .reversed
            .toList();
        return Map.fromEntries(reorderedResult);
      },
      arg,
    );

class PrefectureIntensityWidget extends HookConsumerWidget {
  const PrefectureIntensityWidget({
    super.key,
    required this.item,
  });

  final EarthquakeV1 item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    if (item.intensityPrefectures == null) {
      return const SizedBox.shrink();
    }

    final mergedPrefecturesFuture = ref.watch(
      _calculatorProvider(
        (
          prefectures: item.intensityPrefectures!,
          cities: item.intensityCities,
          stations: item.intensityStations,
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
                title: '各地の震度',
              ),
              // 震度一覧
              for (final kv in value.entries)
                () {
                  final intensity = kv.key;
                  final prefectures = kv.value;
                  final hasCities = prefectures.any(
                    (prefecture) =>
                        prefecture.cities
                            ?.any((city) => city.stations.isNotEmpty) ??
                        false,
                  );
                  final title = switch (intensity) {
                    JmaIntensity.fiveUpperNoInput => '震度5弱以上未入電',
                    _ => '震度$intensity'
                  };
                  return ListTile(
                    titleAlignment: ListTileTitleAlignment.titleHeight,
                    leading: JmaIntensityIcon(
                      intensity: intensity,
                      type: IntensityIconType.filled,
                    ),
                    title: Text(
                      title,
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      prefectures.map((e) => e.name).join(', '),
                      style: const TextStyle(
                        fontFamily: FontFamily.notoSansJP,
                      ),
                    ),
                    onTap: hasCities
                        ? () => _PrefectureModalBottomSheet.show(
                              context: context,
                              intensity: kv.key,
                              prefectures: kv.value,
                            )
                        : null,
                    trailing:
                        hasCities ? const Icon(Icons.chevron_right) : null,
                  );
                }(),
            ],
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _PrefectureModalBottomSheet extends StatelessWidget {
  const _PrefectureModalBottomSheet({
    required this.intensity,
    required this.prefectures,
  });

  static Future<void> show({
    required BuildContext context,
    required JmaIntensity intensity,
    required List<_MergedRegionIntensity> prefectures,
  }) =>
      Navigator.of(context).push(
        SheetRoute(
          builder: (context) {
            return _PrefectureModalBottomSheet(
              intensity: intensity,
              prefectures: prefectures,
            );
          },
        ),
      );

  final JmaIntensity intensity;
  final List<_MergedRegionIntensity> prefectures;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '震度$intensityの地域',
        ),
      ),
      body: ListView(
        children: [
          for (final prefecture in prefectures)
            _PrefectureListTile(prefecture: prefecture),
        ],
      ),
    );
  }
}

class _PrefectureListTile extends HookWidget {
  const _PrefectureListTile({
    required this.prefecture,
  });

  final _MergedRegionIntensity prefecture;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final shrinked = ListTile(
      title: Text(
        prefecture.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.expand_more),
      onTap: () => isExpanded.value = true,
    );
    final expanded = ListTile(
      title: Text(
        prefecture.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final city in prefecture.cities ?? <_CityIntensity>[])
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${city.name}: ',
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
  _MergedRegionIntensity({
    required this.code,
    required this.name,
    required this.intensity,
    required this.cities,
  });

  final String code;
  final String name;
  final JmaIntensity intensity;
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
  final JmaIntensity intensity;
  final List<ObservedRegionIntensity> stations;
}
