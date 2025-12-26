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
}
