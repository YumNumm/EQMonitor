import 'package:eqapi_client/eqapi_client.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_repository.g.dart';

@Riverpod(keepAlive: true)
EarthquakeHistoryRepository earthquakeHistoryRepository(
  EarthquakeHistoryRepositoryRef ref,
) =>
    EarthquakeHistoryRepository(
      api: ref.watch(eqApiProvider),
    );

class EarthquakeHistoryRepository {
  EarthquakeHistoryRepository({required EqApi api}) : _api = api;

  final EqApi _api;

  Future<EqApiV1Response<EarthquakeV1>> fetchEarthquakeLists({
    int limit = 25,
    int offset = 0,
    double? magnitudeLte,
    double? magnitudeGte,
    double? depthLte,
    double? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
  }) async {
    final result = await _api.v1.getEarthquakes(
      limit: limit,
      offset: offset,
      magnitudeLte: magnitudeLte,
      magnitudeGte: magnitudeGte,
      depthLte: depthLte,
      depthGte: depthGte,
      intensityLte: intensityLte,
      intensityGte: intensityGte,
    );
    return (
      count: result.response.count,
      items: result.data,
    );
  }
}
