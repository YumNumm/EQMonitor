import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_deleted_exception.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_details_notifier.g.dart';

@riverpod
class EarthquakeHistoryDetailsNotifier
    extends _$EarthquakeHistoryDetailsNotifier
    with CachedNotifier<Earthquake> {
  api.Earthquake? _pendingRealtimeRecord;
  EarthquakeHistoryRepository? _repository;
  Earthquake? _baseEarthquake;
  var _isDeleted = false;

  @override
  Future<Earthquake> build(String eventId) async {
    ref.listen(earthquakeDebugOverrideProvider(eventId), (_, override) {
      final base = _baseEarthquake;
      if (override != null) {
        state = AsyncData(override);
      } else if (base != null) {
        state = AsyncData(base);
      }
    });
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(:final value)) {
        switch (value) {
          case RealtimeEarthquakeUpsertEvent(:final record)
              when record.eventId == eventId:
            advanceCachedAuthority();
            _isDeleted = false;
            _pendingRealtimeRecord = record;
            final repository = _repository;
            if (repository != null) {
              final base = repository.toEarthquakeFromRealtimeRecord(record);
              _baseEarthquake = base;
              if (ref.read(earthquakeDebugOverrideProvider(eventId)) == null) {
                state = AsyncData(base);
              }
            }
          case RealtimeEarthquakeDeleteEvent(:final eventId)
              when eventId == this.eventId:
            advanceCachedAuthority();
            _isDeleted = true;
            _pendingRealtimeRecord = null;
            _baseEarthquake = null;
            ref.read(earthquakeDebugOverrideProvider(eventId).notifier).reset();
            state = AsyncError<Earthquake>(
              EarthquakeDeletedException(eventId: eventId),
              StackTrace.current,
            ).unwrapPrevious();
          case RealtimeEstimatedIntensityUpsertEvent(:final eventId)
              when eventId == this.eventId:
            advanceCachedAuthority();
            ref.invalidateSelf();
          case _:
            break;
        }
      }
    });
    if (_isDeleted) {
      throw EarthquakeDeletedException(eventId: eventId);
    }
    final operation = beginCachedOperation();
    final repository = await ref.watch(
      earthquakeHistoryRepositoryProvider.future,
    );
    _repository = repository;
    final pendingRecord = _pendingRealtimeRecord;
    if (pendingRecord != null) {
      final base = repository.toEarthquakeFromRealtimeRecord(pendingRecord);
      _baseEarthquake = base;
      final override = ref.read(earthquakeDebugOverrideProvider(eventId));
      state = AsyncData(override ?? base);
    }
    return cachedBuild(operation: operation);
  }

  @override
  Earthquake reconcile(
    Earthquake value, {
    required CachedOperationToken operation,
    required CachedResultSource source,
  }) {
    if (_isDeleted) {
      throw EarthquakeDeletedException(eventId: eventId);
    }
    final record = _pendingRealtimeRecord;
    final repository = _repository;
    final override = ref.read(earthquakeDebugOverrideProvider(eventId));
    final currentBase = _baseEarthquake;
    late final Earthquake base;
    if (source == CachedResultSource.cache) {
      if (record != null && repository != null) {
        base = repository.toEarthquakeFromRealtimeRecord(record);
      } else if (override != null && currentBase != null) {
        base = currentBase;
      } else {
        base = value;
      }
    } else if (isCachedOperationCurrent(operation)) {
      _pendingRealtimeRecord = null;
      base = value;
    } else if (record == null || repository == null) {
      base = value;
    } else {
      base = repository.toEarthquakeFromRealtimeRecord(record);
    }
    _baseEarthquake = base;
    return override ?? base;
  }

  @override
  bool preserveValueOnBackgroundError(CachedOperationToken operation) =>
      _pendingRealtimeRecord != null ||
      ref.read(earthquakeDebugOverrideProvider(eventId)) != null;

  @override
  Future<Earthquake> fetch(api.ApiClient client) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    return repository.fetchEarthquakeDetail(eventId: eventId, client: client);
  }
}
