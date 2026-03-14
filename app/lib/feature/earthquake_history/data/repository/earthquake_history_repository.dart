import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
EarthquakeHistoryRepository earthquakeHistoryRepository(Ref ref) =>
    EarthquakeHistoryRepository(api: ref.watch(apiClientProvider));

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({required api.ApiClient api}) : _api = api;

  final api.ApiClient _api;

  Future<api.EarthquakeListResponse> fetchEarthquakeList({
    int? limit,
  }) async {
    final response = await _api.earthquake.getV2Earthquake(
      limit: limit?.toString(),
    );
    return response.data;
  }

  Future<EarthquakeDetailResponse> fetchEarthquakeDetail({
    required String eventId,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEventId(
      eventId: eventId,
    );
    return response.data;
  }

  Future<IntensityRegionSearchResponse> searchByRegion({
    required String code,
    int? limit,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityRegionCode(
      code: code,
      limit: limit?.toString(),
    );
    return response.data;
  }

  Future<IntensityPrefectureSearchResponse> searchByPrefecture({
    required String code,
    int? limit,
  }) async {
    final response =
        await _api.earthquake.getV2EarthquakeIntensityPrefectureCode(
      code: code,
      limit: limit?.toString(),
    );
    return response.data;
  }

  Future<IntensityCitySearchResponse> searchByCity({
    required String code,
    int? limit,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityCityCode(
      code: code,
      limit: limit?.toString(),
    );
    return response.data;
  }

  Future<IntensityStationSearchResponse> searchByStation({
    required String code,
    int? limit,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityStationCode(
      code: code,
      limit: limit?.toString(),
    );
    return response.data;
  }

  Future<EpicenterSearchResponse> searchByEpicenter({
    required int code,
    int? limit,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEpicenterCode(
      code: code.toString(),
      limit: limit?.toString(),
    );
    return response.data;
  }
}
