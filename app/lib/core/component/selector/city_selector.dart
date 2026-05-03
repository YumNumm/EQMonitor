import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';

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
    final jmaCodeTable = ref.watch(jmaCodeTableProvider);
    final jmaParameter = ref.watch(jmaParameterProvider);
    final prefectures = jmaCodeTable.areaInformationPrefectureEarthquake.items;

    // 選択中の都道府県コード
    final selectedPrefectureCode = useState<String?>(null);

    final theme = Theme.of(context);

    return switch (jmaParameter) {
      AsyncData(:final value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step 1: 都道府県選択
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
              // 都道府県が変更されたら市区町村の選択をリセット
              onChanged(null);
            },
            dropdownMenuEntries: [
              const DropdownMenuEntry<String>(
                value: '',
                label: '選択してください',
              ),
              ...prefectures.map(
                (e) => DropdownMenuEntry(
                  value: e.code,
                  label: e.name,
                ),
              ),
            ],
          ),

          // Step 2: 市区町村選択（都道府県が選択されている場合のみ）
          if (selectedPrefectureCode.value != null &&
              selectedPrefectureCode.value!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '市区町村',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            _CityDropdown(
              prefectureCode: selectedPrefectureCode.value!,
              selectedCode: selectedCode,
              regions: value.earthquake.regions,
              prefectures: prefectures,
              onChanged: onChanged,
            ),
          ],
        ],
      ),
      AsyncError(:final error) => Text('エラー: $error'),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
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
  final List<
    AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
  >
  prefectures;
  final ValueChanged<CitySelection?> onChanged;

  @override
  Widget build(BuildContext context) {
    // 選択された都道府県に属する市区町村を抽出
    // 都道府県コードの先頭2桁と地域コードを照合
    final prefecturePrefix = prefectureCode.substring(0, 2);

    final cities = <({String code, String name, String regionName})>[];
    for (final region in regions) {
      for (final city in region.cities) {
        // 市区町村コードの先頭2桁が都道府県コードと一致するか確認
        if (city.code.startsWith(prefecturePrefix)) {
          cities.add((
            code: city.code,
            name: city.name,
            regionName: region.name,
          ));
        }
      }
    }

    // 都道府県名を取得
    final prefectureName =
        prefectures.where((p) => p.code == prefectureCode).firstOrNull?.name ??
        '';

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
          (e) => DropdownMenuEntry(
            value: e.code,
            label: e.name,
          ),
        ),
      ],
    );
  }
}
