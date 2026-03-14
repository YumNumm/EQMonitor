import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier {
  @override
  Future<EarthquakePartial> build(String eventId) async {
    final repository =
        await ref.watch(earthquakeHistoryRepositoryProvider.future);
    return repository.fetchEarthquakeDetail(eventId: eventId);
  }
}
