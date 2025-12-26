import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier {
  @override
  Future<Earthquake> build(String eventId) async {
    final repository = ref.watch(earthquakeHistoryRepositoryProvider);
    final response = await repository.fetchEarthquakeDetail(eventId: eventId);
    return response.earthquake;
  }
}
