import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_realtime_list_reconciler.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

@riverpod
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  final List<_NotifierRealtimeMutation> _mutations = [];
  EarthquakeHistoryRepository? _repository;
  var _mutationSequence = 0;
  var _hasCompletedInitialLoad = false;

  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(:final value)) {
        switch (value) {
          case RealtimeEarthquakeUpsertEvent(:final record):
            if (applyRealtimeRecord(record)) {
              ref.invalidateSelf();
            }
          case RealtimeEarthquakeDeleteEvent(:final eventId):
            applyRealtimeDelete(eventId);
          case _:
            {}
        }
      }
    });
    if (parameter is EarthquakeHistoryParameterAll) {
      final refetchTimer = Timer.periodic(
        const Duration(minutes: 5),
        (_) => ref.invalidateSelf(),
      );
      ref
        ..onDispose(refetchTimer.cancel)
        ..listen(appLifecycleProvider, (_, next) async {
          if (next == AppLifecycleState.resumed) {
            await _revalidateLatest();
          }
        });
    }

    final startedAt = _hasCompletedInitialLoad ? _mutationSequence : 0;
    final result = await _fetch(
      parameter: parameter,
      limit: parameter is EarthquakeHistoryParameterAll ? 10 : 50,
      cursor: null,
    );
    _hasCompletedInitialLoad = true;
    return _reconcileMutations(result, afterSequence: startedAt);
  }

  Future<void> _revalidateLatest() async {
    talker.debug('revalidateLatest');
    final startedAt = _mutationSequence;
    final latest = await _fetch(parameter: parameter, limit: 10, cursor: null);
    final reconciled = _reconcileMutations(latest, afterSequence: startedAt);
    if (reconciled.items.isNotEmpty) {
      _upsertItems(reconciled.items);
    }
  }

  Future<PaginatedResponse<EarthquakePartial>> _fetch({
    required EarthquakeHistoryParameter parameter,
    required int limit,
    required String? cursor,
  }) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    _repository = repository;

    return switch (parameter) {
      EarthquakeHistoryParameterAll() => repository.fetchEarthquakeList(
        limit: limit,
        cursor: cursor,
        magnitudeGte: parameter.magnitudeGte,
        magnitudeLte: parameter.magnitudeLte,
        depthGte: parameter.depthGte,
        depthLte: parameter.depthLte,
        intensityGte: parameter.intensityGte,
        intensityLte: parameter.intensityLte,
        statuses: parameter.statuses,
        epicenterCodes: parameter.epicenterCodes,
        earthquakeType: parameter.earthquakeType,
        datasource: parameter.datasource,
        telegramTypes: parameter.telegramTypes,
        originTimeGte: parameter.originTimeGte,
        originTimeLte: parameter.originTimeLte,
        maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
        maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
        latitudeGte: parameter.latitudeGte,
        latitudeLte: parameter.latitudeLte,
        longitudeGte: parameter.longitudeGte,
        longitudeLte: parameter.longitudeLte,
        sortBy: parameter.sortBy,
        sortOrder: parameter.sortOrder,
      ),
      EarthquakeHistoryParameterRegion(:final String regionCode) =>
        repository.searchByRegion(
          code: regionCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterPrefecture(:final String prefectureCode) =>
        repository.searchByPrefecture(
          code: prefectureCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterCity(:final String cityCode) =>
        repository.searchByCity(
          code: cityCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
      EarthquakeHistoryParameterStation(:final String stationCode) =>
        repository.searchByStation(
          code: stationCode,
          limit: limit,
          cursor: cursor,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          statuses: parameter.statuses,
          epicenterCodes: parameter.epicenterCodes,
          earthquakeType: parameter.earthquakeType,
          originTimeGte: parameter.originTimeGte,
          originTimeLte: parameter.originTimeLte,
          maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
          maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
          sortBy: parameter.sortBy,
          sortOrder: parameter.sortOrder,
        ),
    };
  }

  Future<void> fetchNextData() async {
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    final currentState = state.value;
    if (currentState == null || currentState.nextToken == null) {
      return;
    }

    state = await state.guardPlus(() async {
      final startedAt = _mutationSequence;
      final result = await _fetch(
        parameter: parameter,
        limit: 50,
        cursor: currentState.nextToken,
      );
      final merged = PaginatedResponse(
        items: <EarthquakePartial>[...currentState.items, ...result.items],
        nextToken: result.nextToken,
      );
      return _reconcileMutations(
        merged,
        afterSequence: startedAt,
        allowAbsentUpsert: false,
      );
    });
  }

  void _upsertItems(List<EarthquakePartial> newItems) {
    final value = state.value;
    if (value == null) {
      return;
    }
    var items = [...value.items];
    for (final item in newItems) {
      final rawIndex = items.indexWhere(
        (e) => e.earthquake.eventId == item.earthquake.eventId,
      );
      final index = rawIndex == -1 ? null : rawIndex;
      if (index == null) {
        if (parameter.sortBy != .eventId) {
          continue;
        }
        items.add(item);
      } else {
        items[index] = item;
      }
    }
    if (parameter.sortBy == .eventId) {
      final descending = parameter.sortOrder == .desc;
      items.sort(
        (a, b) => descending
            ? b.earthquake.eventId.compareTo(a.earthquake.eventId)
            : a.earthquake.eventId.compareTo(b.earthquake.eventId),
      );
    }
    state = AsyncData(
      PaginatedResponse(items: items, nextToken: value.nextToken),
    );
  }

  bool applyRealtimeRecord(api.Earthquake record) {
    _mutations.add(
      _NotifierRealtimeUpsert(sequence: ++_mutationSequence, record: record),
    );
    final repository = _repository;
    final value = state.value;
    if (value == null || repository == null) {
      return true;
    }
    final previous = value.items
        .where((item) => item.earthquake.eventId == record.eventId)
        .firstOrNull;
    final decision = EarthquakeRealtimeListReconciler(
      parameter: parameter,
      repository: repository,
    ).decide(record: record, previous: previous);
    switch (decision) {
      case EarthquakeRealtimeListUpsert(:final item):
        _upsertItems([item]);
      case EarthquakeRealtimeListRemove():
        _removeItem(record.eventId);
      case EarthquakeRealtimeListPreserve():
        break;
      case EarthquakeRealtimeListRefetch():
        break;
    }
    return previous == null || decision is EarthquakeRealtimeListRefetch;
  }

  void applyRealtimeDelete(String eventId) {
    _mutations.add(
      _NotifierRealtimeDelete(sequence: ++_mutationSequence, eventId: eventId),
    );
    _removeItem(eventId);
  }

  void _removeItem(String eventId) {
    final value = state.value;
    if (value == null) {
      return;
    }
    state = AsyncData(
      PaginatedResponse(
        items: value.items
            .where((item) => item.earthquake.eventId != eventId)
            .toList(),
        nextToken: value.nextToken,
      ),
    );
  }

  PaginatedResponse<EarthquakePartial> _reconcileMutations(
    PaginatedResponse<EarthquakePartial> page, {
    required int afterSequence,
    bool allowAbsentUpsert = true,
  }) {
    final repository = _repository;
    if (repository == null) {
      return page;
    }
    final items = [...page.items];
    final reconciler = EarthquakeRealtimeListReconciler(
      parameter: parameter,
      repository: repository,
    );
    for (final mutation in _mutations.where(
      (mutation) => mutation.sequence > afterSequence,
    )) {
      final index = items.indexWhere(
        (item) => item.earthquake.eventId == mutation.eventId,
      );
      switch (mutation) {
        case _NotifierRealtimeDelete():
          if (index != -1) {
            items.removeAt(index);
          }
        case _NotifierRealtimeUpsert(:final record):
          if (index == -1 && !allowAbsentUpsert) {
            continue;
          }
          final decision = reconciler.decide(
            record: record,
            previous: index == -1 ? null : items[index],
          );
          switch (decision) {
            case EarthquakeRealtimeListUpsert(:final item):
              if (index == -1) {
                items.add(item);
              } else {
                items[index] = item;
              }
            case EarthquakeRealtimeListRemove():
              if (index != -1) {
                items.removeAt(index);
              }
            case EarthquakeRealtimeListPreserve():
              break;
            case EarthquakeRealtimeListRefetch():
              break;
          }
      }
    }
    if (parameter.sortBy == .eventId) {
      final descending = parameter.sortOrder == .desc;
      items.sort(
        (a, b) => descending
            ? b.earthquake.eventId.compareTo(a.earthquake.eventId)
            : a.earthquake.eventId.compareTo(b.earthquake.eventId),
      );
    }
    return PaginatedResponse(items: items, nextToken: page.nextToken);
  }
}

sealed class _NotifierRealtimeMutation {
  const new({required this.sequence});

  final int sequence;
  String get eventId;
}

final class _NotifierRealtimeUpsert extends _NotifierRealtimeMutation {
  const new({
    required super.sequence,
    required this.record,
  });

  final api.Earthquake record;
  @override
  String get eventId => record.eventId;
}

final class _NotifierRealtimeDelete extends _NotifierRealtimeMutation {
  const new({
    required super.sequence,
    required this.eventId,
  });

  @override
  final String eventId;
}

class EarthquakeParameterHasNotInitializedException implements Exception;

extension EarthquakeHistoryStateEx on PaginatedResponse<EarthquakePartial> {
  bool get hasNext => nextToken != null;
}
