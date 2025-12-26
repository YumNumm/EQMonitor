import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/route.dart';

class PrefectureIntensityWidget extends HookConsumerWidget {
  const PrefectureIntensityWidget({required this.item, super.key});

  final Earthquake item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensity = item.intensity;

    if (intensity == null) {
      return const SizedBox.shrink();
    }

    // maxIntensity が null でないものだけを抽出してグループ化
    final prefecturesWithIntensity = intensity.prefectures
        .where((p) => p.maxIntensity != null)
        .toList();

    final groupedByIntensity = prefecturesWithIntensity
        .groupListsBy((p) => p.maxIntensity!)
        .entries
        .sorted((a, b) => b.key.index.compareTo(a.key.index));

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          const SheetHeader(title: '各地の震度'),
          for (final kv in groupedByIntensity) ...[
            ListTile(
              visualDensity: VisualDensity.compact,
              titleAlignment: ListTileTitleAlignment.titleHeight,
              leading: IntensityValueIcon(
                intensity: kv.key,
                type: IntensityIconType.filled,
                size: 40,
              ),
              title: Text('震度${kv.key.value}', style: textTheme.titleMedium),
              subtitle: Text(
                kv.value.map((e) => e.value.name).join(', '),
                style: const TextStyle(fontFamily: FontFamily.notoSansJP),
              ),
              onTap: intensity.cities != null
                  ? () async => _PrefectureModalBottomSheet.show(
                        context: context,
                        intensityValue: kv.key,
                        prefectures: kv.value,
                        cities: intensity.cities,
                        stations: intensity.stations,
                      )
                  : null,
              trailing:
                  intensity.cities != null ? const Icon(Icons.chevron_right) : null,
            ),
          ],
        ],
      ),
    );
  }
}

class _PrefectureModalBottomSheet extends StatelessWidget {
  const _PrefectureModalBottomSheet({
    required this.intensityValue,
    required this.prefectures,
    required this.cities,
    required this.stations,
  });

  static Future<void> show({
    required BuildContext context,
    required IntensityValue intensityValue,
    required List<IntensityItem> prefectures,
    required List<IntensityItem>? cities,
    required List<IntensityStationItem>? stations,
  }) =>
      Navigator.of(context).push(
        SheetRoute(
          builder: (context) => _PrefectureModalBottomSheet(
            intensityValue: intensityValue,
            prefectures: prefectures,
            cities: cities,
            stations: stations,
          ),
        ),
      );

  final IntensityValue intensityValue;
  final List<IntensityItem> prefectures;
  final List<IntensityItem>? cities;
  final List<IntensityStationItem>? stations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('震度${intensityValue.value}の地域')),
      body: ListView(
        children: [
          for (final prefecture in prefectures)
            _PrefectureListTile(
              prefecture: prefecture,
              cities: cities,
              stations: stations,
            ),
        ],
      ),
    );
  }
}

class _PrefectureListTile extends HookWidget {
  const _PrefectureListTile({
    required this.prefecture,
    required this.cities,
    required this.stations,
  });

  final IntensityItem prefecture;
  final List<IntensityItem>? cities;
  final List<IntensityStationItem>? stations;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final prefectureCode = prefecture.value.code;

    // この都道府県に属する市区町村
    final relatedCities = cities
            ?.where((c) => c.value.code.startsWith(prefectureCode))
            .toList() ??
        [];

    final shrinked = ListTile(
      title: Text(
        prefecture.value.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: relatedCities.isNotEmpty ? const Icon(Icons.expand_more) : null,
      onTap: relatedCities.isNotEmpty ? () => isExpanded.value = true : null,
    );

    final expanded = ListTile(
      title: Text(
        prefecture.value.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final city in relatedCities)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${city.value.name} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '震度${city.maxIntensity?.value ?? '不明'}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
      onTap: () => isExpanded.value = false,
      trailing: const Icon(Icons.expand_less),
    );

    if (relatedCities.isEmpty) {
      return shrinked;
    }

    return AnimatedCrossFade(
      firstChild: shrinked,
      secondChild: expanded,
      crossFadeState:
          isExpanded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
