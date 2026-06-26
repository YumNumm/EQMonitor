import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_group.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_earthquakes_notifier.g.dart';

@riverpod
Future<List<SimilarEarthquakeGroup>> similarEarthquakes(
  Ref ref,
  String eventId,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  return repository.fetchSimilarEarthquakes(eventId: eventId);
}
