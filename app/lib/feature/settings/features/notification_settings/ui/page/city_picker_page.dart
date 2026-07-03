import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class CityPickerPage extends HookConsumerWidget {
  const CityPickerPage({
    required this.regionCode,
    required this.regionName,
    super.key,
  });

  final String regionCode;
  final String regionName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchText = useState('');

    useEffect(
      () {
        void listener() => searchText.value = searchController.text;
        searchController.addListener(listener);
        return () => searchController.removeListener(listener);
      },
      [searchController],
    );

    final jmaCodeTableAsync = ref.watch(jmaCodeTableProvider);
    final cities = jmaCodeTableAsync.value?.codeTables.areaInformationCity;

    final filteredCities =
        _filterCities(cities, regionCode, searchText.value);

    ref.listen(NotificationSlotsNotifier.addRegionMutation, (_, next) {
      if (next is MutationError) {
        final error = next.error;
        if (error is DioException && error.response?.statusCode == 402) {
          unawaited(showProUpgradeDialog(context));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('地域の追加に失敗しました: $error'),
              backgroundColor: context.designSystem.colorTheme.error,
            ),
          );
        }
      }
      if (next is MutationSuccess) {
        Navigator.of(context)
          ..pop()
          ..pop();
      }
    });

    final isAdding =
        ref.watch(NotificationSlotsNotifier.addRegionMutation)
            is MutationPending;

    return Scaffold(
      appBar: AppBar(title: Text('$regionName - 市区町村を選択')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: searchController,
              hintText: '市区町村名で検索',
              leading: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.search),
              ),
              trailing: [
                if (searchText.value.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      searchText.value = '';
                    },
                  ),
              ],
            ),
          ),
          if (isAdding) const LinearProgressIndicator(),
          Expanded(
            child: switch (jmaCodeTableAsync) {
              AsyncLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              AsyncError(:final error) => Center(
                child: Text('読み込みに失敗しました: $error'),
              ),
              _ when filteredCities != null => ListView.builder(
                itemCount: filteredCities.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _WholeRegionTile(
                      regionCode: regionCode,
                      regionName: regionName,
                      enabled: !isAdding,
                    );
                  }
                  final city = filteredCities[index - 1];
                  return _CityListTile(
                    city: city,
                    regionCode: regionCode,
                    enabled: !isAdding,
                  );
                },
              ),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }

  static List<JmaCodeTableCityItem>? _filterCities(
    List<JmaCodeTableCityItem>? cities,
    String regionCode,
    String query,
  ) {
    if (cities == null) {
      return null;
    }
    final regionCities = cities
        .where((c) => c.parentAreaForecastLocalEewCode == regionCode)
        .toList();
    if (query.isEmpty) {
      return regionCities;
    }
    final lowerQuery = query.toLowerCase();
    return regionCities.where((item) {
      return item.name.ja.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}

class _WholeRegionTile extends ConsumerWidget {
  const _WholeRegionTile({
    required this.regionCode,
    required this.regionName,
    required this.enabled,
  });

  final String regionCode;
  final String regionName;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      enabled: enabled,
      leading: const Icon(Icons.select_all),
      title: Text('$regionName 全域'),
      subtitle: const Text('この地域全体の通知を受け取ります'),
      trailing: const Icon(Icons.add),
      onTap: enabled
          ? () async {
              await NotificationSlotsNotifier.addRegionMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(notificationSlotsProvider.notifier)
                      .addRegion(
                        regionId: int.parse(regionCode),
                        regionName: regionName,
                      );
                },
              );
            }
          : null,
    );
  }
}

class _CityListTile extends ConsumerWidget {
  const _CityListTile({
    required this.city,
    required this.regionCode,
    required this.enabled,
  });

  final JmaCodeTableCityItem city;
  final String regionCode;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      enabled: enabled,
      title: Text(city.name.ja),
      subtitle: Text(city.code),
      trailing: const Icon(Icons.add),
      onTap: enabled
          ? () async {
              await NotificationSlotsNotifier.addRegionMutation.run(
                ref,
                (tsx) async {
                  await tsx
                      .get(notificationSlotsProvider.notifier)
                      .addRegion(
                        regionId: int.parse(regionCode),
                        cityCode: city.code,
                        cityName: city.name.ja,
                      );
                },
              );
            }
          : null,
    );
  }
}
