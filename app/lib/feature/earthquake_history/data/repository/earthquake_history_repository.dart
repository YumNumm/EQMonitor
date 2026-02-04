import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
EarthquakeHistoryRepository earthquakeHistoryRepository(Ref ref) =>
    EarthquakeHistoryRepository(api: ref.watch(eqApiProvider));

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({required EqApi api}) : _api = api;

  final EqApi _api;

  Future<EarthquakeListResponse> fetchEarthquakeList({
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.getList(
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }

  Future<EarthquakeDetailResponse> fetchEarthquakeDetail({
    required String eventId,
  }) async {
    return _api.earthquake.getDetail(eventId: eventId);
  }

  /// 震度細分区域から地震検索
  Future<IntensityRegionSearchResponse> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.searchByRegion(
      code: code,
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }

  /// 都道府県から地震検索
  Future<IntensityPrefectureSearchResponse> searchByPrefecture({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.searchByPrefecture(
      code: code,
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }

  /// 市区町村から地震検索
  Future<IntensityCitySearchResponse> searchByCity({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.searchByCity(
      code: code,
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }

  /// 観測点から地震検索
  Future<IntensityStationSearchResponse> searchByStation({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.searchByStation(
      code: code,
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }

  /// 震源地から地震検索
  Future<EpicenterSearchResponse> searchByEpicenter({
    required int code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    return _api.earthquake.searchByEpicenter(
      code: code,
      limit: limit,
      cursor: cursor,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
      statuses: statuses,
    );
  }
}
