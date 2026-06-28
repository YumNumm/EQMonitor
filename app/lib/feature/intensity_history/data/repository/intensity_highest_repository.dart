import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_highest_repository.g.dart';

@Riverpod(keepAlive: true)
Future<IntensityHighestRepository> intensityHighestRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  return IntensityHighestRepository(earthquake: apiClient.earthquake);
}

/// 最高震度 API をまとめる薄いラッパ。
class IntensityHighestRepository {
  IntensityHighestRepository({required EarthquakeApiClient earthquake})
      : _earthquake = earthquake;

  final EarthquakeApiClient _earthquake;

  /// 全都道府県の過去最高震度一覧を取得する。
  Future<List<HighestIntensityEntry>> fetchPrefectureHighest() async {
    final response =
        await _earthquake.getV2EarthquakeIntensityPrefectureHighest();
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }

  /// 指定都道府県内の市区町村ごとの過去最高震度一覧を取得する。
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode,
  ) async {
    final response = await _earthquake
        .getV2EarthquakeIntensityPrefectureCodeCityHighest(code: prefectureCode);
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }

  /// 指定市区町村の過去地震一覧を取得する（ページネーション）。
  Future<CityIntensityPage> fetchCityIntensityList({
    required String cityCode,
    required int limit,
    String? cursor,
  }) async {
    final response = await _earthquake.getV2EarthquakeIntensityCityCode(
      code: cityCode,
      limit: limit.toString(),
      cursor: cursor,
    );
    return CityIntensityPage(
      items: response.data.items,
      nextToken: response.data.nextToken,
    );
  }
}
