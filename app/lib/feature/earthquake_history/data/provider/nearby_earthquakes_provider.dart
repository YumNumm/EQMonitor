import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nearby_earthquakes_provider.g.dart';

@riverpod
Future<List<EarthquakePartial>> nearbyEarthquakes(
  Ref ref,
  NearbyEarthquakeQuery query,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final response = await repository.fetchEarthquakeList(
    limit: 6,
    latitudeGte: query.latitudeGte,
    latitudeLte: query.latitudeLte,
    longitudeGte: query.longitudeGte,
    longitudeLte: query.longitudeLte,
    depthGte: query.depthGte,
    depthLte: query.depthLte,
    sortBy: query.sortBy,
    sortOrder: query.sortOrder,
  );
  return response.items
      .where((item) => item.earthquake.eventId != query.excludeEventId)
      .take(5)
      .toList();
}
