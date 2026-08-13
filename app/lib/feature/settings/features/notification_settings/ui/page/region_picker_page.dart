import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/city_picker_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => CityPickerPage(
                            regionCode: region.code,
                            regionName: region.name.ja,
                          ),
                        ),
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
    required this.onTap,
  });

  final JmaCodeTableItem region;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(region.name.ja),
      subtitle: Text(region.code),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
