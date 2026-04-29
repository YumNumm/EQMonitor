import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_notifier.g.dart';

typedef EarthquakeHistoryNotifierState = ({
  List<EarthquakePartial> items,
  String? nextToken,
});

@riverpod
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<EarthquakeHistoryNotifierState> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    if (parameter == const EarthquakeHistoryParameter()) {
      final refetchTimer = Timer.periodic(
        const Duration(minutes: 5),
        (_) => _refreshIfWsNotConnected(),
      );
      ref
        ..onDispose(refetchTimer.cancel)
        ..listen(appLifecycleProvider, (_, next) async {
          if (next == AppLifecycleState.resumed) {
            await _onResumed();
          }
        })
        ..listen(realtimeEventsProvider, (_, next) async {
          if (next case AsyncData(:final value)) {
            await _onRealtimeEvent(value);
          }
        });
    }

    return _fetchInitialData(
      param: parameter,
      limit: parameter == const EarthquakeHistoryParameter() ? 10 : 50,
    );
  }

  Future<EarthquakeHistoryNotifierState> _fetchInitialData({
    required EarthquakeHistoryParameter param,
    required int limit,
  }) async {
    ref.invalidate(earthquakeHistoryDetailsProvider);
    return _fetchData(param: param, limit: limit, cursor: null);
  }

  Future<EarthquakeHistoryNotifierState> _fetchData({
    required EarthquakeHistoryParameter param,
    required int limit,
    required String? cursor,
  }) async {
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );

    if (param.epicenterCode != null) {
      final result = await repository.searchByEpicenter(
        code: param.epicenterCode!,
        limit: limit,
        cursor: cursor,
      );
      return (
        items: result.items.map((e) => e.earthquake).toList(),
        nextToken: result.nextToken,
      );
    }

    if (param.regionCode != null &&
        param.regionCode != null &&
        param.regionSearchType == RegionSearchType.prefecture) {
      final result = await repository.searchByPrefecture(
        code: param.regionCode!,
        limit: limit,
        cursor: cursor,
      );
      return (
        items: result.items.map((e) => e.earthquake).toList(),
        nextToken: result.nextToken,
      );
    }

    if (param.regionCode != null &&
        param.regionCode != null &&
        param.regionSearchType == RegionSearchType.city) {
      final result = await repository.searchByCity(
        code: param.regionCode!,
        limit: limit,
        cursor: cursor,
      );
      return (
        items: result.items.map((e) => e.earthquake).toList(),
        nextToken: result.nextToken,
      );
    }

    final result = await repository.fetchEarthquakeList(
      limit: limit,
      cursor: cursor,
    );
    return (
      items: result.items,
      nextToken: result.nextToken,
    );
  }

  static final fetchNextDataMutation = Mutation<void>();
  Future<void> fetchNextData() async {
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    final currentState = state.value;
    if (currentState == null || currentState.nextToken == null) {
      return;
    }

    state = await state.guardPlus(() async {
      final result = await _fetchData(
        param: parameter,
        limit: 50,
        cursor: currentState.nextToken,
      );
      final mergedItems = <EarthquakePartial>[
        ...currentState.items,
        ...result.items,
      ].sorted((a, b) => b.eventId.compareTo(a.eventId));
      return (
        items: mergedItems,
        nextToken: result.nextToken,
      );
    });
  }

  Future<void> _onResumed() async {
    if (parameter != const EarthquakeHistoryParameter()) {
      return;
    }
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    final result = await repository.fetchEarthquakeList(limit: 10);
    _upsertItems(result.items);
  }

  Future<void> _refreshIfWsNotConnected() async {
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      log('state is not AsyncData<EarthquakeHistoryNotifierState>');
      return;
    }
    final wsPhase = ref.read(eqMonitorWsStatusProvider).phase;
    if (wsPhase == WsPhase.connected) {
      log('WS is connected');
      return;
    }
    if (parameter != const EarthquakeHistoryParameter()) {
      log('parameter is not default');
      return;
    }
    if (ref.read(appLifecycleProvider) != AppLifecycleState.resumed) {
      log('app is not resumed');
      return;
    }
    log('refreshIfWsNotConnected');

    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    final result = await repository.fetchEarthquakeList(limit: 10);
    _upsertItems(result.items);
  }

  Future<void> _onRealtimeEvent(RealtimeEvent event) async {
    switch (event) {
      case RealtimeEarthquakeUpsertEvent():
        await _refreshFromEarthquakeUpsert();
      case RealtimeEarthquakeDeleteEvent(:final eventId):
        _deleteItem(eventId);
      case RealtimeEstimatedIntensityUpsertEvent(
        :final eventId,
        :final estimatedIntensityTile,
      ):
        _updateEstimatedIntensityTile(eventId, estimatedIntensityTile);
      default:
        return;
    }
  }

  void _updateEstimatedIntensityTile(
    String eventId,
    String estimatedIntensityTile,
  ) {
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      return;
    }
    final currentState = state.value;
    if (currentState == null) {
      return;
    }
    final items = [
      for (final item in currentState.items)
        if (item.eventId == eventId)
          item.copyWith(estimatedIntensityTileUrl: estimatedIntensityTile)
        else
          item,
    ];
    state = AsyncData((items: items, nextToken: currentState.nextToken));
  }

  Future<void> _refreshFromEarthquakeUpsert() async {
    if (parameter != const EarthquakeHistoryParameter()) {
      return;
    }
    final repository = await ref.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    final result = await repository.fetchEarthquakeList(limit: 10);
    _upsertItems(result.items);
  }

  void _deleteItem(String eventId) {
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      return;
    }
    final currentState = state.value;
    if (currentState == null) {
      return;
    }
    final items = [
      ...currentState.items.where((e) => e.eventId != eventId),
    ];
    state = AsyncData((items: items, nextToken: currentState.nextToken));
  }

  void _upsertItems(List<EarthquakePartial> newItems) {
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      return;
    }
    final currentState = state.value;
    if (currentState == null) {
      return;
    }
    final items = [...currentState.items];
    for (final item in newItems) {
      final rawIndex = items.indexWhere((e) => e.eventId == item.eventId);
      final index = rawIndex == -1 ? null : rawIndex;
      if (index == null) {
        items.add(item);
      } else {
        items[index] = item;
      }
    }
    items.sort((a, b) => b.eventId.compareTo(a.eventId));
    state = AsyncData((items: items, nextToken: currentState.nextToken));
  }
}

class EarthquakeParameterHasNotInitializedException implements Exception {}

extension EarthquakeHistoryStateEx on EarthquakeHistoryNotifierState {
  bool get hasNext => nextToken != null;
}
