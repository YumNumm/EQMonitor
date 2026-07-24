import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier
    with CachedNotifier<Earthquake> {
  @override
  Future<Earthquake> build(String eventId) async {
    final repository = await ref.watch(
      earthquakeHistoryRepositoryProvider.future,
    );
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(
        value: RealtimeEarthquakeUpsertEvent(:final record),
      ) when record.eventId == eventId) {
        state = AsyncData(
          record.toEarthquake(
            parameter: repository.earthquakeParameter,
            shindoDbStations: repository.shindoDbStations,
          ),
        );
      }
    });
    return cachedBuild();
  }

  @override
  Future<Earthquake> fetch(api.ApiClient client) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    return repository.fetchEarthquakeDetail(eventId: eventId, client: client);
  }
}
