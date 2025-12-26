import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

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
    // 検索条件を指定していないNotifierでのみ、5分ごとにデータ再取得するタイマーを設定
    if (parameter == const EarthquakeHistoryParameter()) {
      final refetchTimer = Timer.periodic(
        const Duration(minutes: 5),
        (_) => _refreshIfWebsocketNotConnected(),
      );
      ref
        ..onDispose(refetchTimer.cancel)
        ..listen(appLifecycleProvider, (_, next) async {
          if (next == AppLifecycleState.resumed) {
            await _onResumed();
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

    final result = await ref
        .read(earthquakeHistoryRepositoryProvider)
        .fetchEarthquakeList(
          depthGte: param.depthGte,
          depthLte: param.depthLte,
          intensityGte: param.intensityGte?.value,
          intensityLte: param.intensityLte?.value,
          magnitudeGte: param.magnitudeGte,
          magnitudeLte: param.magnitudeLte,
          limit: limit,
        );
    return (
      items: result.items,
      nextToken: result.nextToken,
    );
  }

  Future<void> refresh() async {
    ref.invalidate(earthquakeHistoryDetailsProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard<EarthquakeHistoryNotifierState>(
      () => _fetchInitialData(
        param: parameter,
        limit: 50,
      ),
    );
  }

  Future<void> fetchNextData() async {
    // 読み込み中の場合は何もしない
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    final currentState = state.value;
    // すでに全件取得済みの場合は何もしない
    if (currentState == null || currentState.nextToken == null) {
      return;
    }

    state = await state.guardPlus(() async {
      final repository = ref.read(earthquakeHistoryRepositoryProvider);
      final result = await repository.fetchEarthquakeList(
        depthGte: parameter.depthGte,
        depthLte: parameter.depthLte,
        intensityGte: parameter.intensityGte?.value,
        intensityLte: parameter.intensityLte?.value,
        magnitudeGte: parameter.magnitudeGte,
        magnitudeLte: parameter.magnitudeLte,
        cursor: currentState.nextToken,
        limit: 50,
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
    final repository = ref.read(earthquakeHistoryRepositoryProvider);
    final result = await repository.fetchEarthquakeList(limit: 10);
    _upsertItems(result.items);
  }

  Future<void> _refreshIfWebsocketNotConnected() async {
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      log('state is not AsyncData<EarthquakeHistoryNotifierState>');
      return;
    }
    final webSocketState = ref.read(websocketStatusProvider);
    if (webSocketState is Connected || webSocketState is Reconnected) {
      log('WebSocket is ${webSocketState.runtimeType}');
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
    log('refreshIfWebsocketNotConnected');

    final repository = ref.read(earthquakeHistoryRepositoryProvider);
    final result = await repository.fetchEarthquakeList(limit: 10);
    _upsertItems(result.items);
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
      final index = items.indexWhereOrNull(
        (e) => e.eventId == item.eventId,
      );
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
