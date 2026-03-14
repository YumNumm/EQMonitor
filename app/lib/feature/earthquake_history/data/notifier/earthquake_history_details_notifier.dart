import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier {
  @override
  Future<EarthquakeDetailResponse> build(String eventId) async {
    final repository = ref.watch(earthquakeHistoryRepositoryProvider);
    return repository.fetchEarthquakeDetail(eventId: eventId);
  }
}
