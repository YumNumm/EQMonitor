import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 市区町村選択結果
typedef CitySelection = ({String code, String name, String prefectureName});

/// 市区町村選択（都道府県→市区町村の2段階選択）
class CitySelector extends HookConsumerWidget {
  const CitySelector({
    required this.selectedCode,
    required this.selectedName,
    required this.onChanged,
    super.key,
  });

  final String? selectedCode;
  final String? selectedName;
  final ValueChanged<CitySelection?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterSet = ref.watch(parameterSetProvider);

    final selectedPrefectureCode = useState<String?>(null);
    final theme = Theme.of(context);

    return switch (parameterSet) {
      AsyncData(:final value) => _CitySelectionBody(
        parameterSet: value,
        selectedCode: selectedCode,
        selectedPrefectureCode: selectedPrefectureCode,
        theme: theme,
        onChanged: onChanged,
      ),
      AsyncError(:final error) => Text('エラー: $error'),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _CitySelectionBody extends HookWidget {
  const _CitySelectionBody({
    required this.parameterSet,
    required this.selectedCode,
    required this.selectedPrefectureCode,
    required this.theme,
    required this.onChanged,
  });

  final ParameterSet parameterSet;
  final String? selectedCode;
  final ValueNotifier<String?> selectedPrefectureCode;
  final ThemeData theme;
  final ValueChanged<CitySelection?> onChanged;

  @override
  Widget build(BuildContext context) {
    final prefectures =
        parameterSet.jmaCodeTable.codeTables.areaInformationPrefectureEarthquake;
    final allRegions = parameterSet.earthquake.prefectures
        .expand((p) => p.regions)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '都道府県',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        DropdownMenu<String>(
          expandedInsets: EdgeInsets.zero,
          initialSelection: selectedPrefectureCode.value,
          hintText: '都道府県を選択',
          onSelected: (code) {
            selectedPrefectureCode.value = code;
            onChanged(null);
          },
          dropdownMenuEntries: [
            const DropdownMenuEntry<String>(
              value: '',
              label: '選択してください',
            ),
            ...prefectures.map(
              (e) => DropdownMenuEntry(value: e.code, label: e.name.ja),
            ),
          ],
        ),
        if (selectedPrefectureCode.value case final prefCode?
            when prefCode.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            '市区町村',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          _CityDropdown(
            prefectureCode: prefCode,
            selectedCode: selectedCode,
            regions: allRegions,
            prefectures: prefectures,
            onChanged: onChanged,
          ),
        ],
      ],
    );
  }
}

class _CityDropdown extends StatelessWidget {
  const _CityDropdown({
    required this.prefectureCode,
    required this.selectedCode,
    required this.regions,
    required this.prefectures,
    required this.onChanged,
  });

  final String prefectureCode;
  final String? selectedCode;
  final List<EarthquakeParameterRegionItem> regions;
  final List<JmaCodeTableItem> prefectures;
  final ValueChanged<CitySelection?> onChanged;

  @override
  Widget build(BuildContext context) {
    final prefecturePrefix = prefectureCode.substring(0, 2);

    final cities = <({String code, String name, String regionName})>[];
    for (final region in regions) {
      for (final city in region.cities) {
        if (city.code.startsWith(prefecturePrefix)) {
          cities.add((
            code: city.code,
            name: city.name.ja,
            regionName: region.name.ja,
          ));
        }
      }
    }

    final prefectureName =
        prefectures.where((p) => p.code == prefectureCode).firstOrNull?.name.ja
        ?? '';

    if (cities.isEmpty) {
      return const Text('該当する市区町村がありません');
    }

    return DropdownMenu<String>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: selectedCode,
      hintText: '市区町村を選択',
      enableFilter: true,
      onSelected: (code) {
        if (code != null && code.isNotEmpty) {
          final city = cities.firstWhereOrNull((c) => c.code == code);
          if (city == null) {
            return;
          }
          onChanged((
            code: code,
            name: city.name,
            prefectureName: prefectureName,
          ));
        } else {
          onChanged(null);
        }
      },
      dropdownMenuEntries: [
        const DropdownMenuEntry<String>(
          value: '',
          label: '選択してください',
        ),
        ...cities.map(
          (e) => DropdownMenuEntry(value: e.code, label: e.name),
        ),
      ],
    );
  }
}
