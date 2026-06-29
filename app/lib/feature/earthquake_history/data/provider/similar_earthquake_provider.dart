import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
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
  NearbyEarthquakeParameter parameter,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final response = await repository.fetchEarthquakeList(
    latitudeGte: latitude - parameter.latitudeOffset,
    latitudeLte: latitude + parameter.latitudeOffset,
    longitudeGte: longitude - parameter.longitudeOffset,
    longitudeLte: longitude + parameter.longitudeOffset,
    depthGte: depth != null
        ? (depth - parameter.depthOffset).clamp(0, 9999)
        : null,
    depthLte: depth != null ? depth + parameter.depthOffset : null,
    sortBy: sortBy,
    sortOrder: sortOrder,
    limit: 5,
  );
  return response.items
      .where((e) => e.eventId != excludeEventId)
      .toList();
}
