import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';

class EarthquakeSearchSelectionPage extends HookConsumerWidget {
  const EarthquakeSearchSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(EarthquakeSearchType.region);

    return Scaffold(
      appBar: AppBar(
        title: const Text('地域から検索'),
      ),
      body: Column(
        children: [
          _TabSelector(
            selectedTab: selectedTab.value,
            onTabSelected: (tab) => selectedTab.value = tab,
          ),
          Expanded(
            child: switch (selectedTab.value) {
              EarthquakeSearchType.region => const _RegionListView(),
              EarthquakeSearchType.prefecture => const _PrefectureListView(),
              EarthquakeSearchType.city => const _CityListView(),
              EarthquakeSearchType.station => const _StationListView(),
            },
          ),
        ],
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({
    required this.selectedTab,
    required this.onTabSelected,
  });

  final EarthquakeSearchType selectedTab;
  final ValueChanged<EarthquakeSearchType> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: EarthquakeSearchType.values.map((type) {
          final isSelected = type == selectedTab;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(type.label),
              selected: isSelected,
              onSelected: (_) => onTabSelected(type),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _RegionListView extends HookConsumerWidget {
  const _RegionListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaParameter = ref.watch(jmaParameterProvider);
    final searchQuery = useState('');

    return switch (jmaParameter) {
      AsyncData(:final value) => () {
        final regions = value.earthquake.regions;
        return SearchAnchor(
          suggestionsBuilder: (context, controller) async => regions
              .where((r) {
                final query = searchQuery.value.toLowerCase();
                return r.name.toLowerCase().contains(query) ||
                    r.nameKana.toLowerCase().contains(query) ||
                    r.code.contains(query);
              })
              .map((r) => _RegionListTile(region: r))
              .toList(),
          builder: (context, controller) => Column(
            children: [
              _SearchBar(
                hintText: '細分化地域を検索',
                searchController: controller,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: regions.length,
                  itemBuilder: (context, index) => _RegionListTile(
                    region: regions[index],
                  ),
                ),
              ),
            ],
          ),
        );
      }(),
      AsyncError(:final error) => Center(child: Text('Error: $error')),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _RegionListTile extends StatelessWidget {
  const _RegionListTile({required this.region});

  final EarthquakeParameterRegionItem region;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      title: Text(region.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => EarthquakeSearchResultRoute(
        type: EarthquakeSearchType.region.name,
        code: region.code,
        name: region.name,
      ).push<void>(context),
    );
  }
}

class _PrefectureListView extends HookConsumerWidget {
  const _PrefectureListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaCodeTable = ref.watch(jmaCodeTableProvider);

    final prefectures = jmaCodeTable.areaInformationPrefectureEarthquake.items;
    return SearchAnchor(
      suggestionsBuilder: (context, controller) async => prefectures
          .where((p) {
            final query = controller.text.toLowerCase();
            return p.name.toLowerCase().contains(query) ||
                p.code.contains(query);
          })
          .map((p) => _PrefectureListTile(prefecture: p))
          .toList(),
      builder: (context, controller) => Column(
        children: [
          _SearchBar(
            hintText: '都道府県を検索',
            searchController: controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prefectures.length,
              itemBuilder: (context, index) => _PrefectureListTile(
                prefecture: prefectures[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefectureListTile extends StatelessWidget {
  const _PrefectureListTile({required this.prefecture});

  final AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem
  prefecture;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(prefecture.name),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => EarthquakeSearchResultRoute(
        type: EarthquakeSearchType.prefecture.name,
        code: prefecture.code,
        name: prefecture.name,
      ).push<void>(context),
    );
  }
}

class _CityListView extends HookConsumerWidget {
  const _CityListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaParameter = ref.watch(jmaParameterProvider);
    final searchQuery = useState('');
    final selectedRegion = useState<EarthquakeParameterRegionItem?>(null);

    return switch (jmaParameter) {
      AsyncData(:final value) => () {
        final regions = value.earthquake.regions;

        if (selectedRegion.value != null) {
          final cities = selectedRegion.value!.cities;

          return SearchAnchor(
            suggestionsBuilder: (context, controller) async => cities
                .where((c) {
                  final query = controller.text.toLowerCase();
                  return c.name.toLowerCase().contains(query) ||
                      c.nameKana.toLowerCase().contains(query) ||
                      c.code.contains(query);
                })
                .map((c) => _CityListTile(city: c))
                .toList(),
            builder: (context, controller) => Column(
              children: [
                _SearchBar(
                  searchController: controller,
                  hintText: '市区町村を検索',
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: Text('${selectedRegion.value!.name} の市区町村'),
                  onTap: () {
                    selectedRegion.value = null;
                    searchQuery.value = '';
                  },
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) => _CityListTile(
                      city: cities[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SearchAnchor(
          suggestionsBuilder: (context, controller) async => regions
              .where((r) {
                final query = controller.text.toLowerCase();
                return r.name.toLowerCase().contains(query) ||
                    r.nameKana.toLowerCase().contains(query) ||
                    r.cities.any(
                      (c) =>
                          c.name.toLowerCase().contains(query) ||
                          c.nameKana.toLowerCase().contains(query),
                    );
              })
              .map((r) => _RegionListTile(region: r)),
          builder: (context, controller) => Column(
            children: [
              _SearchBar(
                hintText: '地域または市区町村を検索',
                searchController: controller,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: regions.length,
                  itemBuilder: (context, index) => _RegionListTile(
                    region: regions[index],
                  ),
                ),
              ),
            ],
          ),
        );
      }(),
      AsyncError(:final error) => Center(child: Text('Error: $error')),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _CityListTile extends StatelessWidget {
  const _CityListTile({required this.city});

  final EarthquakeParameterCityItem city;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(city.name),
      subtitle: Text(city.nameKana),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => EarthquakeSearchResultRoute(
        type: EarthquakeSearchType.city.name,
        code: city.code,
        name: city.name,
      ).push<void>(context),
    );
  }
}

class _StationListView extends HookConsumerWidget {
  const _StationListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaParameter = ref.watch(jmaParameterProvider);
    final searchQuery = useState('');
    final selectedRegion = useState<EarthquakeParameterRegionItem?>(null);
    final selectedCity = useState<EarthquakeParameterCityItem?>(null);

    return switch (jmaParameter) {
      AsyncData(:final value) => () {
        final regions = value.earthquake.regions;

        // 観測点選択中
        if (selectedCity.value != null) {
          return SearchAnchor(
            suggestionsBuilder: (context, controller) async => selectedCity
                .value!
                .stations
                .where((s) {
                  final query = controller.text.toLowerCase();
                  return s.name.toLowerCase().contains(query) ||
                      s.nameKana.toLowerCase().contains(query) ||
                      s.code.contains(query);
                })
                .map((s) => _StationListTile(station: s))
                .toList(),
            builder: (context, controller) => Column(
              children: [
                _SearchBar(
                  searchController: controller,
                  hintText: '観測点を検索',
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: Text('${selectedCity.value!.name} の観測点'),
                  onTap: () {
                    selectedCity.value = null;
                    searchQuery.value = '';
                  },
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedCity.value!.stations.length,
                    itemBuilder: (context, index) => _StationListTile(
                      station: selectedCity.value!.stations[index],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // 市区町村選択中
        if (selectedRegion.value != null) {
          final cities = selectedRegion.value!.cities;

          return SearchAnchor(
            suggestionsBuilder: (context, controller) async => cities
                .where((c) {
                  final query = controller.text.toLowerCase();
                  return c.name.toLowerCase().contains(query) ||
                      c.nameKana.toLowerCase().contains(query) ||
                      c.code.contains(query);
                })
                .map((c) => _CityListTile(city: c))
                .toList(),
            builder: (context, controller) => Column(
              children: [
                _SearchBar(
                  searchController: controller,
                  hintText: '市区町村または観測点を検索',
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: Text('${selectedRegion.value!.name} の市区町村'),
                  onTap: () {
                    selectedRegion.value = null;
                    searchQuery.value = '';
                  },
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      return ListTile(
                        title: Text(city.name),
                        subtitle: Text('${city.stations.length}件の観測点'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => selectedCity.value = city,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        // 地域選択
        final filteredRegions = searchQuery.value.isEmpty
            ? regions
            : regions.where((r) {
                final query = searchQuery.value.toLowerCase();
                return r.name.toLowerCase().contains(query) ||
                    r.nameKana.toLowerCase().contains(query) ||
                    r.cities.any(
                      (c) =>
                          c.name.toLowerCase().contains(query) ||
                          c.stations.any(
                            (s) => s.name.toLowerCase().contains(query),
                          ),
                    );
              }).toList();

        return SearchAnchor(
          suggestionsBuilder: (context, controller) async =>
              filteredRegions.map((r) => _RegionListTile(region: r)).toList(),
          builder: (context, controller) => Column(
            children: [
              _SearchBar(
                searchController: controller,
                hintText: '地域・市区町村・観測点を検索',
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredRegions.length,
                  itemBuilder: (context, index) {
                    final region = filteredRegions[index];
                    final stationCount = region.cities.fold<int>(
                      0,
                      (sum, c) => sum + c.stations.length,
                    );
                    return ListTile(
                      title: Text(region.name),
                      subtitle: Text('$stationCount件の観測点'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => selectedRegion.value = region,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }(),
      AsyncError(:final error) => Center(child: Text('Error: $error')),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _StationListTile extends StatelessWidget {
  const _StationListTile({required this.station});

  final EarthquakeParameterStationItem station;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(station.name),
      subtitle: Text(station.nameKana),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => EarthquakeSearchResultRoute(
        type: EarthquakeSearchType.station.name,
        code: station.code,
        name: station.name,
      ).push<void>(context),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.hintText,
    required this.searchController,
  });

  final String hintText;
  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: searchController,
        hintText: hintText,
        onTap: searchController.openView,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
