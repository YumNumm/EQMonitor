import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_search_result.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_region_search.g.dart';

@riverpod
EarthquakeRegionSearch earthquakeRegionSearch(Ref ref) =>
    const EarthquakeRegionSearch();

class EarthquakeRegionSearch {
  const new();

  List<EarthquakeHistorySearchResult> search({
    required EarthquakeParameter parameter,
    required String query,
  }) {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) {
      return const [];
    }
    return [
      for (final prefecture in parameter.prefectures) ...[
        if (prefecture.name.ja.contains(term) ||
            (prefecture.name.en?.toLowerCase().contains(term) ?? false))
          EarthquakeHistorySearchResult(
            name: prefecture.name.ja,
            areaDescription: '都道府県',
            parameter: EarthquakeHistoryParameter.prefecture(
              sortBy: .eventId,
              sortOrder: .desc,
              prefectureCode: prefecture.code,
            ),
          ),
        for (final region in prefecture.regions) ...[
          if (region.name.ja.contains(term) ||
              (region.name.en?.toLowerCase().contains(term) ?? false) ||
              (region.kana?.contains(term) ?? false))
            EarthquakeHistorySearchResult(
              name: region.name.ja,
              areaDescription: '${prefecture.name.ja}・地域',
              parameter: EarthquakeHistoryParameter.region(
                sortBy: .eventId,
                sortOrder: .desc,
                regionCode: region.code,
              ),
            ),
          for (final city in region.cities)
            if (city.name.ja.contains(term) ||
                (city.name.en?.toLowerCase().contains(term) ?? false) ||
                (city.kana?.contains(term) ?? false))
              EarthquakeHistorySearchResult(
                name: city.name.ja,
                areaDescription: '${prefecture.name.ja}・${region.name.ja}',
                parameter: EarthquakeHistoryParameter.city(
                  sortBy: .eventId,
                  sortOrder: .desc,
                  cityCode: city.code,
                ),
              ),
        ],
      ],
    ];
  }
}
