import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_search.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_selection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class CityPickerPage extends HookConsumerWidget {
  const CityPickerPage({required this.region, super.key});

  final NotificationRegionOption region;

  static Future<NotificationRegionSelection?> show(
    BuildContext context, {
    required NotificationRegionOption region,
  }) => Navigator.of(context).push<NotificationRegionSelection>(
    MaterialPageRoute(builder: (_) => CityPickerPage(region: region)),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchText = useState('');
    useEffect(() {
      void listener() => searchText.value = searchController.text;
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

    final search = ref.watch(notificationRegionSearchProvider);
    final filteredCities = search.filter(
      items: region.cities,
      query: searchText.value,
      name: (city) => city.name,
      kana: (city) => city.kana,
    );

    return Scaffold(
      appBar: AppBar(title: Text('${region.name} - 市区町村を選択')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: SearchBar(
              controller: searchController,
              hintText: '市区町村名・ふりがなで検索',
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.isEmpty ? 2 : filteredCities.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _WholeRegionTile(region: region);
                }
                if (filteredCities.isEmpty) {
                  final message = searchText.value.isEmpty
                      ? '選択できる市区町村がありません'
                      : '該当する市区町村がありません';
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(child: Text(message)),
                  );
                }
                return _CityListTile(
                  region: region,
                  city: filteredCities[index - 1],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WholeRegionTile extends StatelessWidget {
  const _WholeRegionTile({required this.region});

  final NotificationRegionOption region;

  @override
  Widget build(BuildContext context) => ListTile(
    minTileHeight: 48,
    visualDensity: VisualDensity.compact,
    leading: const Icon(Icons.select_all),
    title: Text('${region.name} 全域'),
    subtitle: const Text('この地域全体の通知を受け取ります'),
    trailing: const Icon(Icons.add),
    onTap: () => Navigator.of(context).pop(
      NotificationRegionSelection(
        regionCode: region.code,
        regionName: region.name,
      ),
    ),
  );
}

class _CityListTile extends StatelessWidget {
  const _CityListTile({required this.region, required this.city});

  final NotificationRegionOption region;
  final NotificationCityOption city;

  @override
  Widget build(BuildContext context) => ListTile(
    minTileHeight: 48,
    visualDensity: VisualDensity.compact,
    title: Text(city.name),
    trailing: const Icon(Icons.add),
    onTap: () => Navigator.of(context).pop(
      NotificationRegionSelection(
        regionCode: region.code,
        regionName: region.name,
        cityCode: city.code,
        cityName: city.name,
      ),
    ),
  );
}
