import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
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
                  '震度${kv.key.type.replaceAll("+", "強").replaceAll("-", "弱")}',
                  style: textTheme.titleMedium!.copyWith(
                    fontFamily: FontFamily.jetBrainsMono,
                    fontFamilyFallback: [FontFamily.notoSansJP],
                  ),
                ),
                subtitle: Text(
                  kv.value.map((e) => e.prefecture.name).join(', '),
                ),
                onTap: () => _PrefectureModalBottomSheet.show(
                  context: context,
                  intensity: kv.key,
                  prefectures: kv.value,
                ),
                trailing: const Icon(Icons.chevron_right),
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

class _PrefectureModalBottomSheet extends StatelessWidget {
  const _PrefectureModalBottomSheet({
    required this.intensity,
    required this.prefectures,
  });

  static Future<void> show({
    required BuildContext context,
    required JmaIntensity intensity,
    required List<_MergedPrefectureIntensity> prefectures,
  }) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return _PrefectureModalBottomSheet(
          intensity: intensity,
          prefectures: prefectures,
        );
      },
    );
  }

  final JmaIntensity intensity;
  final List<_MergedPrefectureIntensity> prefectures;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "震度${intensity.type.replaceAll('+', '強').replaceAll('-', '弱')}"
          'の地域',
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

  final _MergedPrefectureIntensity prefecture;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final shrinked = ListTile(
      title: Text(
        prefecture.prefecture.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.expand_more),
      onTap: () => isExpanded.value = true,
    );
    final expanded = ListTile(
      title: Text(
        prefecture.prefecture.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final city in prefecture.cities)
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
