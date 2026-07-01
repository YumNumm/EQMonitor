import 'dart:async';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class RegionPickerPage extends HookConsumerWidget {
  const RegionPickerPage({super.key});

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
    final regions = jmaCodeTableAsync.value?.codeTables.areaForecastLocalEew;

    final filteredRegions = _filterRegions(regions, searchText.value);

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
        Navigator.of(context).pop();
      }
    });

    final isAdding =
        ref.watch(NotificationSlotsNotifier.addRegionMutation)
            is MutationPending;

    return Scaffold(
      appBar: AppBar(title: const Text('地域を選択')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: SearchBar(
              controller: searchController,
              hintText: '地域名で検索',
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
              _ when filteredRegions != null => ListView.builder(
                itemCount: filteredRegions.length,
                itemBuilder: (context, index) {
                  final region = filteredRegions[index];
                  return _RegionListTile(
                    region: region,
                    enabled: !isAdding,
                    onTap: () async {
                      await NotificationSlotsNotifier.addRegionMutation.run(
                        ref,
                        (tsx) async {
                          await tsx
                              .get(notificationSlotsProvider.notifier)
                              .addRegion(
                                regionId: int.parse(region.code),
                                regionName: region.name.ja,
                              );
                        },
                      );
                    },
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

  static List<JmaCodeTableItem>? _filterRegions(
    List<JmaCodeTableItem>? regions,
    String query,
  ) {
    if (regions == null) {
      return null;
    }
    if (query.isEmpty) {
      return regions;
    }
    final lowerQuery = query.toLowerCase();
    return regions.where((item) {
      final nameMatch = item.name.ja.toLowerCase().contains(lowerQuery);
      final kanaMatch = item.kana?.toLowerCase().contains(lowerQuery) ?? false;
      return nameMatch || kanaMatch;
    }).toList();
  }
}

class _RegionListTile extends StatelessWidget {
  const _RegionListTile({
    required this.region,
    required this.enabled,
    required this.onTap,
  });

  final JmaCodeTableItem region;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(region.name.ja),
      subtitle: Text(region.code),
      trailing: const Icon(Icons.add),
      onTap: enabled ? onTap : null,
    );
  }
}
