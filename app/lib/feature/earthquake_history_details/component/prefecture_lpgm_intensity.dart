import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lg_intensity_icon.dart';
import 'package:eqmonitor/core/extension/map_to_list.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/route.dart';

part 'prefecture_lpgm_intensity.g.dart';

typedef _Arg = ({
  List<ObservedRegionLpgmIntensity>? prefectures,
  List<ObservedRegionLpgmIntensity>? stations,
});

@riverpod
Future<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> _lpgmCalculator(
  _LpgmCalculatorRef ref,
  _Arg arg,
) =>
    compute<_Arg, Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>(
      (
        _Arg arg,
      ) {
        final prefectures = arg.prefectures;
        final stations = arg.stations;
        if (prefectures == null || stations == null) {
          return {};
        }
        // 最大長周期地震動階級でグルーピング
        final prefecturesGroupedByLpgmIntensity = prefectures
            .where((pref) => pref.lpgmIntensity != null)
            .groupListsBy(
              (pref) => pref.lpgmIntensity!,
            );
        // それぞれの階級ごとに、都道府県を舐める
        final result = <JmaLgIntensity, List<_MergedPrefectureIntensity>>{};
        for (final entry in prefecturesGroupedByLpgmIntensity.entries) {
          final intensity = entry.key;
          final prefectures = entry.value;
          for (final pref in prefectures) {
            // 観測点が所属していて、階級が同じものを取得
            // idの上2桁が都道府県コード
            final stationsInPrefAndIntensitySame = stations.where(
              (sta) =>
                  sta.code.startsWith(pref.code.substring(0, 2)) &&
                  sta.lpgmIntensity == intensity,
            );
            result.putIfAbsent(
              intensity,
              () => [],
            );
            result[intensity]!.add(
              _MergedPrefectureIntensity(
                code: pref.code,
                name: pref.name,
                intensity: intensity,
                stations: stationsInPrefAndIntensitySame.toList(),
              ),
            );
          }
        }
        return result;
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
          prefectures: item.lpgmIntensityPrefectures,
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
      AsyncData(:final value) when value.isEmpty => const SizedBox.shrink(),
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
              for (final kv in value.toList.sorted(
                (a, b) => a.key < b.key ? 1 : -1,
              ))
                () {
                  final hasStations =
                      kv.value.any((e) => e.stations.isNotEmpty);
                  return ListTile(
                    titleAlignment: ListTileTitleAlignment.titleHeight,
                    leading: JmaLgIntensityIcon(
                      intensity: kv.key,
                      type: IntensityIconType.filled,
                    ),
                    title: Text(
                      '長周期地震動階級${kv.key.type}',
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      kv.value.map((e) => e.name).join(', ').toHalfWidth,
                    ),
                    onTap: hasStations
                        ? () => _PrefectureModalBottomSheet.show(
                              context: context,
                              intensity: kv.key,
                              prefectures: kv.value,
                            )
                        : null,
                    trailing:
                        hasStations ? const Icon(Icons.chevron_right) : null,
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
    required JmaLgIntensity intensity,
    required List<_MergedPrefectureIntensity> prefectures,
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

  final JmaLgIntensity intensity;
  final List<_MergedPrefectureIntensity> prefectures;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '長周期地震動階級$intensityの観測点',
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
      subtitle: Text(
        prefecture.stations
            .map(
              (e) => e.name,
            )
            .join(', '),
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
  _MergedPrefectureIntensity({
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
