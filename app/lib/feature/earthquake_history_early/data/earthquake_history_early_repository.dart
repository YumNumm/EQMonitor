import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_early_repository.g.dart';

@Riverpod(keepAlive: true)
EarthquakeHistoryEarlyRepository earthquakeHistoryEarlyRepository(
  EarthquakeHistoryEarlyRepositoryRef ref,
) =>
    EarthquakeHistoryEarlyRepository(
      api: ref.watch(eqApiProvider),
    );

class EarthquakeHistoryEarlyRepository {
  EarthquakeHistoryEarlyRepository({
    required EqApi api,
  }) : _api = api;

  final EqApi _api;

  Future<EqApiV1Response<EarthquakeEarly>> fetchEarthquakeEarlyLists({
    int limit = 100,
    int offset = 0,
    double? magnitudeLte,
    double? magnitudeGte,
    double? depthLte,
    double? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeLte,
    DateTime? originTimeGte,
    EarthquakeEarlySortType sort = EarthquakeEarlySortType.origin_time,
    bool ascending = false,
  }) async {
    final response = await _api.v1.getEarthquakeEarlies(
      limit: limit,
      offset: offset,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte?.type,
      intensityGte: intensityGte?.type,
      originTimeLte: originTimeLte,
      originTimeGte: originTimeGte,
      sort: sort,
      ascending: ascending,
    );

    return (
      count: response.response.count,
      items: response.data,
    );
  }
}
