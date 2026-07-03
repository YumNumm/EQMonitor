import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/prefecture_intensity_page.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
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
  Future<List<HighestIntensityEntry>> fetchPrefectureHighest({
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureHighest();
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }

  /// 指定都道府県内の市区町村ごとの過去最高震度一覧を取得する。
  Future<List<HighestIntensityEntry>> fetchCityHighest(
    String prefectureCode, {
    ApiClient? client,
  }) async {
    final response = await (client?.earthquake ?? _earthquake)
        .getV2EarthquakeIntensityPrefectureCodeCityHighest(
          code: prefectureCode,
        );
    return response.data.items.map(HighestIntensityEntry.fromApi).toList();
  }

  /// 指定市区町村の過去地震一覧を取得する（ページネーション）。
  Future<CityIntensityPage> fetchCityIntensityList({
    required String cityCode,
    required String cityName,
    required EarthquakeParameter parameter,
    required int limit,
    String? cursor,
  }) async {
    final response = await _earthquake.getV2EarthquakeIntensityCityCode(
      code: cityCode,
      sortBy: EarthquakeSortBy.maxIntensity,
      limit: limit.toString(),
      cursor: cursor,
    );
    final appResponse = response.data.toAppResponse(
      parameter: parameter,
      areaCode: cityCode,
      areaName: cityName,
    );
    return CityIntensityPage(
      items: appResponse.items,
      nextToken: appResponse.nextToken,
    );
  }

  /// 指定都道府県の過去地震一覧を取得する（ページネーション）。
  Future<PrefectureIntensityPage> fetchPrefectureIntensityList({
    required String prefectureCode,
    required String prefectureName,
    required EarthquakeParameter parameter,
    required int limit,
    String? cursor,
  }) async {
    final response = await _earthquake.getV2EarthquakeIntensityPrefectureCode(
      code: prefectureCode,
      sortBy: EarthquakeSortBy.maxIntensity,
      limit: limit.toString(),
      cursor: cursor,
    );
    final appResponse = response.data.toAppResponse(
      parameter: parameter,
      areaCode: prefectureCode,
      areaName: prefectureName,
    );
    return PrefectureIntensityPage(
      items: appResponse.items,
      nextToken: appResponse.nextToken,
    );
  }
}
