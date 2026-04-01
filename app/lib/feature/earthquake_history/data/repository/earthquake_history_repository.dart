import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_list_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
Future<EarthquakeHistoryRepository> earthquakeHistoryRepository(
  Ref ref,
) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return EarthquakeHistoryRepository(
    api: ref.watch(apiClientProvider),
    earthquakeParameter: jmaParam.earthquake,
  );
}

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({
    required api.ApiClient api,
    required this.earthquakeParameter,
  }) : _api = api;

  final api.ApiClient _api;
  final EarthquakeParameter earthquakeParameter;

  Future<EarthquakeListResponse> fetchEarthquakeList({
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2Earthquake(
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toEarthquakeListResponse(
      parameter: earthquakeParameter,
    );
  }

  Future<EarthquakePartial> fetchEarthquakeDetail({
    required String eventId,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEventId(
      eventId: eventId,
    );
    return response.data.earthquake.toEarthquakePartial(
      parameter: earthquakeParameter,
    );
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityRegionCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByPrefecture({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake
        .getV2EarthquakeIntensityPrefectureCode(
          code: code,
          limit: limit?.toString(),
          cursor: cursor,
        );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }

  Future<PaginatedSearchResponse<IntensityAreaSearchItem>> searchByCity({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityCityCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }

  Future<PaginatedSearchResponse<StationSearchItem>> searchByStation({
    required String code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeIntensityStationCode(
      code: code,
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }

  Future<PaginatedSearchResponse<EpicenterSearchItem>> searchByEpicenter({
    required int code,
    int? limit,
    String? cursor,
  }) async {
    final response = await _api.earthquake.getV2EarthquakeEpicenterCode(
      code: code.toString(),
      limit: limit?.toString(),
      cursor: cursor,
    );
    return response.data.toAppResponse(parameter: earthquakeParameter);
  }
}
