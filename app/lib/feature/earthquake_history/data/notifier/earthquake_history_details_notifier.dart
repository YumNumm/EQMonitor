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
  api.Earthquake? _latestRealtimeRecord;
  EarthquakeHistoryRepository? _repository;

  @override
  Future<Earthquake> build(String eventId) async {
    final repository = await ref.watch(
      earthquakeHistoryRepositoryProvider.future,
    );
    _repository = repository;
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(
        value: RealtimeEarthquakeUpsertEvent(:final record),
      ) when record.eventId == eventId) {
        _latestRealtimeRecord = record;
        state = AsyncData(
          earthquakeFromRealtimeRecord(record: record, repository: repository),
        );
      }
    });
    return cachedBuild();
  }

  @override
  Earthquake reconcile(Earthquake value) {
    final record = _latestRealtimeRecord;
    final repository = _repository;
    if (record == null || repository == null) {
      return value;
    }
    return earthquakeFromRealtimeRecord(record: record, repository: repository);
  }

  @override
  Future<Earthquake> fetch(api.ApiClient client) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    return repository.fetchEarthquakeDetail(eventId: eventId, client: client);
  }
}

Earthquake earthquakeFromRealtimeRecord({
  required api.Earthquake record,
  required EarthquakeHistoryRepository repository,
}) => record.toEarthquake(
  parameter: repository.earthquakeParameter,
  shindoDbStations: repository.shindoDbStations,
);
