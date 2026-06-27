import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_earthquake_provider.g.dart';

@riverpod
Future<List<EarthquakePartial>> nearbyEarthquake(
  Ref ref,
  String excludeEventId,
  double latitude,
  double longitude,
  int? depth,
  api.EarthquakeSortBy sortBy,
  api.SortOrder sortOrder,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final response = await repository.fetchEarthquakeList(
    latitudeGte: latitude - 0.5,
    latitudeLte: latitude + 0.5,
    longitudeGte: longitude - 0.5,
    longitudeLte: longitude + 0.5,
    depthGte: depth != null ? (depth - 50).clamp(0, 9999) : null,
    depthLte: depth != null ? depth + 50 : null,
    sortBy: sortBy,
    sortOrder: sortOrder,
    limit: 50,
  );
  return response.items
      .where((e) => e.eventId != excludeEventId)
      .toList();
}
