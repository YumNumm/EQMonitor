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
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

@riverpod
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
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
        })
        ..listen(realtimeEventsProvider, (_, next) async {
          if (next case AsyncData(:final value)) {
            final repository = await ref.read(
              earthquakeHistoryRepositoryProvider.future,
            );
            switch (value) {
              case RealtimeEarthquakeUpsertEvent(:final record):
                applyRealtimeRecord(record, repository);
              case _:
                {}
            }
          }
        });
    }

    return _fetch(
      parameter: parameter,
      limit: parameter is EarthquakeHistoryParameterAll ? 10 : 50,
      cursor: null,
    );
  }

  Future<void> _revalidateLatest() async {
    talker.debug('revalidateLatest');
    final latest = await _fetch(parameter: parameter, limit: 10, cursor: null);
    if (latest.items.isNotEmpty) {
      _upsertItems(latest.items);
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
        epicenterCodes: parameter.epicenterCodes,
        earthquakeType: parameter.earthquakeType,
        originTimeGte: parameter.originTimeGte,
        originTimeLte: parameter.originTimeLte,
        maxLpgmIntensityGte: parameter.maxLpgmIntensityGte,
        maxLpgmIntensityLte: parameter.maxLpgmIntensityLte,
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
      final result = await _fetch(
        parameter: parameter,
        limit: 50,
        cursor: currentState.nextToken,
      );
      final mergedItems = <EarthquakePartial>[
        ...currentState.items,
        ...result.items,
      ].sorted((a, b) => b.earthquake.eventId.compareTo(a.earthquake.eventId));
      return .new(items: mergedItems, nextToken: result.nextToken);
    });
  }

  void _upsertItems(List<EarthquakePartial> newItems) {
    final value = state.value;
    if (value == null ||
        parameter.sortBy != .eventId ||
        parameter.sortOrder != .desc) {
      return;
    }
    var items = [...value.items];
    for (final item in newItems) {
      final rawIndex = items.indexWhere(
        (e) => e.earthquake.eventId == item.earthquake.eventId,
      );
      final index = rawIndex == -1 ? null : rawIndex;
      if (index == null) {
        items.add(item);
      } else {
        items[index] = item;
      }
    }
    items.sort((a, b) => b.earthquake.eventId.compareTo(a.earthquake.eventId));
    state = AsyncData(
      PaginatedResponse(items: items, nextToken: value.nextToken),
    );
  }

  void applyRealtimeRecord(
    api.Earthquake record,
    EarthquakeHistoryRepository repository,
  ) {
    final value = state.value;
    if (value == null) {
      return;
    }
    final previous = value.items
        .where((item) => item.earthquake.eventId == record.eventId)
        .firstOrNull;
    if (previous == null) {
      return;
    }
    _upsertItems([
      earthquakePartialFromRealtimeRecord(
        record: record,
        previous: previous.earthquake,
        repository: repository,
      ),
    ]);
  }
}

class EarthquakeParameterHasNotInitializedException implements Exception {}

extension EarthquakeHistoryStateEx on PaginatedResponse<EarthquakePartial> {
  bool get hasNext => nextToken != null;
}
