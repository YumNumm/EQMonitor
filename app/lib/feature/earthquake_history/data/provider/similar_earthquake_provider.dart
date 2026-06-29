import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_earthquake_provider.g.dart';

@riverpod
Future<List<EarthquakePartial>> nearbyEarthquake(
  Ref ref,
  String excludeEventId,
  NearbyEarthquakeSearchParameter parameter,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final historyParameter = parameter.toHistoryParameter();
  final response = await repository.fetchEarthquakeList(
    latitudeGte: historyParameter.latitudeGte,
    latitudeLte: historyParameter.latitudeLte,
    longitudeGte: historyParameter.longitudeGte,
    longitudeLte: historyParameter.longitudeLte,
    depthGte: historyParameter.depthGte,
    depthLte: historyParameter.depthLte,
    sortBy: historyParameter.sortBy?.toApiEarthquakeSortBy,
    sortOrder: historyParameter.sortOrder?.toApiSortOrder,
    limit: parameter.fetchLimit,
  );
  return response.items.where((e) => e.eventId != excludeEventId).toList();
}
