import 'package:core/core.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_bounds_calculator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_filter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_dataset.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';

class EarthquakeActivityRepository {
  const EarthquakeActivityRepository({
    required EarthquakeHistoryRepository earthquakeHistoryRepository,
    EarthquakeActivityBoundsCalculator boundsCalculator =
        const EarthquakeActivityBoundsCalculator(),
    EarthquakeActivityFilter filter = const EarthquakeActivityFilter(),
  }) : _earthquakeHistoryRepository = earthquakeHistoryRepository,
       _boundsCalculator = boundsCalculator,
       _filter = filter;

  final EarthquakeHistoryRepository _earthquakeHistoryRepository;
  final EarthquakeActivityBoundsCalculator _boundsCalculator;
  final EarthquakeActivityFilter _filter;

  Future<EarthquakeActivityDataset> fetch({
    required EarthquakeActivityQuery query,
    required DateTime now,
    required void Function(int fetchedCount) onProgress,
  }) async {
    final bounds = _boundsCalculator.calculate(
      latitude: query.latitude,
      longitude: query.longitude,
      radiusKm: query.radiusKm,
    );
    final candidates = <EarthquakePartial>[];
    final seenCursors = <String>{};
    String? cursor;

    while (true) {
      final response = await _earthquakeHistoryRepository.fetchEarthquakeList(
        limit: 100,
        cursor: cursor,
        depthGte: query.depthGte,
        depthLte: query.depthLte,
        earthquakeType: EarthquakeType.normal,
        originTimeGte: Date.fromDateTime(query.start.toUtc()),
        originTimeLte: Date.fromDateTime(query.effectiveEnd(now: now).toUtc()),
        latitudeGte: bounds.latitudeGte,
        latitudeLte: bounds.latitudeLte,
        longitudeGte: bounds.longitudeGte,
        longitudeLte: bounds.longitudeLte,
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.asc,
      );
      candidates.addAll(response.items);
      onProgress(candidates.length);

      final nextToken = response.nextToken;
      if (nextToken == null) {
        break;
      }
      if (!seenCursors.add(nextToken)) {
        throw StateError('Earthquake activity cursor repeated: $nextToken');
      }
      cursor = nextToken;
    }

    return EarthquakeActivityDataset(
      items: _filter.apply(query: query, candidates: candidates, now: now),
      fetchedAt: now,
    );
  }
}
