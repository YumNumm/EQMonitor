import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_region_add_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_search.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_region_catalog_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/pro_upgrade_dialog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/city_picker_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_region_map_picker_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class RegionPickerPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchText = useState('');
    useEffect(() {
      void listener() => searchText.value = searchController.text;
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    ref.listen(NotificationSlotsNotifier.addRegionMutation, (_, next) {
      if (next is MutationError) {
        final error = next.error;
        if (error is DioException && error.response?.statusCode == 402) {
          unawaited(const ProUpgradeDialogAction().show(context));
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('地域を追加できませんでした'),
            backgroundColor: context.designSystem.colorTheme.error,
          ),
        );
      } else if (next is MutationSuccess && context.mounted) {
        Navigator.of(context).pop();
      }
    });

    final catalogAsync = ref.watch(notificationRegionCatalogProvider);
    final search = ref.watch(notificationRegionSearchProvider);
    final regions = catalogAsync.value;
    final filteredRegions = regions == null
        ? null
        : search.filter(
            items: regions.regions,
            query: searchText.value,
            name: (region) => region.name,
            kana: (region) => region.kana,
          );
    final isAdding = ref.watch(
      NotificationSlotsNotifier.addRegionMutation,
    ) is MutationPending;

    return Scaffold(
      appBar: AppBar(
        title: const Text('地域を選択'),
        actions: [
          IconButton(
            tooltip: '地図から選択',
            icon: const Icon(Icons.map_outlined),
            onPressed: isAdding
                ? null
                : () async {
                    final selection =
                        await NotificationRegionMapPickerPage.show(context);
                    if (selection == null || !context.mounted) {
                      return;
                    }
                    await ref
                        .read(notificationRegionAddActionProvider)
                        .add(ref: ref, selection: selection);
                  },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: SearchBar(
              controller: searchController,
              hintText: '地域名・ふりがなで検索',
              leading: const Icon(Icons.search),
              trailing: [
                if (searchText.value.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: searchController.clear,
                  ),
              ],
            ),
          ),
          if (isAdding) const LinearProgressIndicator(),
          Expanded(
            child: switch (catalogAsync) {
              AsyncLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              AsyncError() => _RegionCatalogError(
                onRetry: () =>
                    ref.invalidate(notificationRegionCatalogProvider),
              ),
              _ when filteredRegions != null && filteredRegions.isEmpty =>
                const Center(child: Text('該当する地域がありません')),
              _ when filteredRegions != null => ListView.builder(
                itemCount: filteredRegions.length,
                itemBuilder: (context, index) {
                  final region = filteredRegions[index];
                  return _RegionListTile(
                    region: region,
                    enabled: !isAdding,
                    onTap: () async {
                      final selection = await CityPickerPage.show(
                        context,
                        region: region,
                      );
                      if (selection == null || !context.mounted) {
                        return;
                      }
                      await ref
                          .read(notificationRegionAddActionProvider)
                          .add(ref: ref, selection: selection);
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
}

class _RegionListTile extends StatelessWidget {
  const new({
    required this.region,
    required this.enabled,
    required this.onTap,
  });

  final NotificationRegionOption region;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    enabled: enabled,
    minTileHeight: 48,
    visualDensity: VisualDensity.compact,
    title: Text(region.name),
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );
}

class _RegionCatalogError extends StatelessWidget {
  const new({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('地域情報を読み込めませんでした'),
        const SizedBox(height: 8),
        FilledButton.tonal(onPressed: onRetry, child: const Text('再試行')),
      ],
    ),
  );
}
