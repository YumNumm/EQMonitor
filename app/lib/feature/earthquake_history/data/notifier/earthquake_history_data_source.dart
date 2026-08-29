import 'dart:async';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_realtime_list_reconciler.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:material_ui/material_ui.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_data_source.g.dart';

@riverpod
Future<EarthquakeHistoryDataSource> earthquakeHistoryDataSource(
  Ref ref,
  EarthquakeHistoryParameter parameter,
) async {
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final dataSource = EarthquakeHistoryDataSource(
    repository: repository,
    parameter: parameter,
    onRefreshStarted: () =>
        ref.invalidate(earthquakeHistoryDetailsProvider, asReload: true),
  );

  ref.onDispose(dataSource.dispose);

  ref.listen(realtimeEventsProvider, (_, next) async {
    if (next case AsyncData(:final value)) {
      switch (value) {
        case RealtimeEarthquakeUpsertEvent(:final record):
          if (dataSource.applyRealtimeRecord(record)) {
            ref.invalidateSelf();
          }
        case RealtimeEarthquakeDeleteEvent(:final eventId):
          dataSource.applyRealtimeDelete(eventId);
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
          await dataSource.revalidateLatest();
        }
      });
  }

  return dataSource;
}

class EarthquakeHistoryDataSource
    extends GroupedDataSource<String?, String, EarthquakePartial> {
  new({
    required EarthquakeHistoryRepository repository,
    required EarthquakeHistoryParameter parameter,
    VoidCallback? onRefreshStarted,
  }) : _repository = repository,
       _parameter = parameter {
    onLoadStarted = (action) {
      if (action is Refresh) {
        onRefreshStarted?.call();
      }
    };
  }

  final EarthquakeHistoryRepository _repository;
  final EarthquakeHistoryParameter _parameter;
  final List<_RealtimeListMutation> _mutations = [];
  var _mutationSequence = 0;
  var _hasCompletedInitialLoad = false;

  final ValueNotifier<bool> isRevalidating = ValueNotifier(false);
  @override
  void dispose() {
    isRevalidating.dispose();
    super.dispose();
  }

  @override
  String groupBy(EarthquakePartial value) {
    final dateTime =
        value.earthquake.originTime ?? value.earthquake.arrivalTime;
    return dateTime?.formatWithTz(DateTimeFormat.yearMonthDay) ?? '不明';
  }

  @override
  Future<LoadResult<String?, EarthquakePartial>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() when _parameter.isDefaultAll => await _load(
      limit: 10,
      cursor: null,
    ),
    Refresh() => await _load(
      limit: _parameter is EarthquakeHistoryParameterAll ? 10 : 50,
      cursor: null,
    ),
    Append(:final key) => await _load(limit: 50, cursor: key),
    Prepend() => const None(),
  };

  Future<void> revalidateLatest() async {
    talker.debug('revalidateLatest');
    final startedAt = _mutationSequence;
    final latest = await _fetch(limit: 10, cursor: null);
    final reconciled = _reconcileMutations(
      items: latest.items,
      afterSequence: startedAt,
    );
    if (reconciled.isNotEmpty) {
      upsertItems(reconciled);
    }
  }

  Future<LoadResult<String?, EarthquakePartial>> _load({
    required int limit,
    required String? cursor,
  }) async {
    try {
      final startedAt = _hasCompletedInitialLoad ? _mutationSequence : 0;
      final page = await _fetch(limit: limit, cursor: cursor);
      final items = _reconcileMutations(
        items: page.items,
        afterSequence: startedAt,
        allowAbsentUpsert: cursor == null,
      );
      _hasCompletedInitialLoad = true;
      return Success(
        page: PageData(data: items, appendKey: page.nextToken),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }

  Future<PaginatedResponse<EarthquakePartial>> _fetch({
    required int limit,
    required String? cursor,
  }) async {
    final parameter = _parameter;

    return switch (parameter) {
      EarthquakeHistoryParameterAll() => _repository.fetchEarthquakeList(
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
        _repository.searchByRegion(
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
        _repository.searchByPrefecture(
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
        _repository.searchByCity(
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
        _repository.searchByStation(
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

  void upsertItems(List<EarthquakePartial> newItems) {
    final isDesc = _parameter.sortOrder == .desc;
    for (final item in newItems) {
      final currentItems = [...notifier.values];
      final index = currentItems.indexWhere(
        (e) => e.earthquake.eventId == item.earthquake.eventId,
      );
      if (index != -1) {
        updateItem(index, (_) => item);
        continue;
      }
      if (_parameter.sortBy != .eventId) {
        continue;
      }
      // eventId 比較で挿入位置を決める(desc: 大きい順 / asc: 小さい順)
      final insertAt = currentItems.indexWhere(
        (e) => isDesc
            ? e.earthquake.eventId.compareTo(item.earthquake.eventId) < 0
            : e.earthquake.eventId.compareTo(item.earthquake.eventId) > 0,
      );
      insertItem(insertAt == -1 ? currentItems.length : insertAt, item);
    }
  }

  bool applyRealtimeRecord(api.Earthquake record) {
    _mutations.add(
      _RealtimeListUpsert(sequence: ++_mutationSequence, record: record),
    );
    final previous = notifier.values
        .where((item) => item.earthquake.eventId == record.eventId)
        .firstOrNull;
    final decision = EarthquakeRealtimeListReconciler(
      parameter: _parameter,
      repository: _repository,
    ).decide(record: record, previous: previous);
    _applyDecision(
      decision,
      eventId: record.eventId,
    );
    return previous == null || decision is EarthquakeRealtimeListRefetch;
  }

  void applyRealtimeDelete(String eventId) {
    _mutations.add(
      _RealtimeListDelete(sequence: ++_mutationSequence, eventId: eventId),
    );
    final index = notifier.values.indexWhere(
      (item) => item.earthquake.eventId == eventId,
    );
    if (index != -1) {
      removeItem(index);
    }
  }

  List<EarthquakePartial> _reconcileMutations({
    required List<EarthquakePartial> items,
    required int afterSequence,
    bool allowAbsentUpsert = true,
  }) {
    final result = [...items];
    final reconciler = EarthquakeRealtimeListReconciler(
      parameter: _parameter,
      repository: _repository,
    );
    for (final mutation in _mutations.where(
      (mutation) => mutation.sequence > afterSequence,
    )) {
      final eventId = mutation.eventId;
      final index = result.indexWhere(
        (item) => item.earthquake.eventId == eventId,
      );
      switch (mutation) {
        case _RealtimeListDelete():
          if (index != -1) {
            result.removeAt(index);
          }
        case _RealtimeListUpsert(:final record):
          if (index == -1 && !allowAbsentUpsert) {
            continue;
          }
          final previous = index == -1 ? null : result[index];
          _applyDecisionToListItems(
            result,
            reconciler.decide(record: record, previous: previous),
            eventId: eventId,
          );
      }
    }
    if (_parameter.sortBy == .eventId) {
      final descending = _parameter.sortOrder == .desc;
      result.sort(
        (a, b) => descending
            ? b.earthquake.eventId.compareTo(a.earthquake.eventId)
            : a.earthquake.eventId.compareTo(b.earthquake.eventId),
      );
    }
    return result;
  }

  void _applyDecision(
    EarthquakeRealtimeListDecision decision, {
    required String eventId,
  }) {
    switch (decision) {
      case EarthquakeRealtimeListUpsert(:final item):
        upsertItems([item]);
      case EarthquakeRealtimeListRemove():
        applyRealtimeDeleteWithoutMutation(eventId);
      case EarthquakeRealtimeListPreserve():
        return;
      case EarthquakeRealtimeListRefetch():
        return;
    }
  }

  void applyRealtimeDeleteWithoutMutation(String eventId) {
    final index = notifier.values.indexWhere(
      (item) => item.earthquake.eventId == eventId,
    );
    if (index != -1) {
      removeItem(index);
    }
  }

  void _applyDecisionToListItems(
    List<EarthquakePartial> items,
    EarthquakeRealtimeListDecision decision, {
    required String eventId,
  }) {
    final index = items.indexWhere(
      (item) => item.earthquake.eventId == eventId,
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
        return;
      case EarthquakeRealtimeListRefetch():
        return;
    }
  }
}

sealed class _RealtimeListMutation {
  const new({required this.sequence});

  final int sequence;
  String get eventId;
}

final class _RealtimeListUpsert extends _RealtimeListMutation {
  const new({required super.sequence, required this.record});

  final api.Earthquake record;
  @override
  String get eventId => record.eventId;
}

final class _RealtimeListDelete extends _RealtimeListMutation {
  const new({required super.sequence, required this.eventId});

  @override
  final String eventId;
}
