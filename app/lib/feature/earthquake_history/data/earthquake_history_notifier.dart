import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history_details/data/earthquake_history_details_notifier.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'earthquake_history_notifier.g.dart';

typedef EarthquakeHistoryNotifierState = (
  List<EarthquakeV1Extended>,
  int totalCount
);

@riverpod
class EarthquakeHistoryNotifier extends _$EarthquakeHistoryNotifier {
  @override
  Future<EarthquakeHistoryNotifierState> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    // ensure earthquakeParameter has been initialized.
    final jmaParameterState = await ref.watch(jmaParameterProvider.future);

    final earthquakeParameter = jmaParameterState.earthquake;

    // 検索条件を指定していないNotifierでのみ、30秒ごとにデータ再取得するタイマーを設定
    if (parameter == const EarthquakeHistoryParameter()) {
      // 30秒ごとにデータ再取得するタイマー
      final refetchTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => _refreshIfWebsocketNotConnected(),
      );
      ref
        ..onDispose(refetchTimer.cancel)

        // アプリがバックグラウンドからフォアグラウンドに戻った際にデータを再取得する
        ..listen(
          appLifeCycleProvider,
          (_, next) async {
            if (next == AppLifecycleState.resumed) {
              await _onResumed();
            }
          },
        )
        // WebSocketからのデータを適用する
        ..listen(
          websocketTableMessagesProvider<EarthquakeV1>(),
          (_, next) {
            if (next case AsyncData(value: final value)) {
              final _ = switch (value) {
                RealtimePostgresInsertPayload<EarthquakeV1>(:final newData) =>
                  _upsertEarthquakeV1s([newData]),
                RealtimePostgresUpdatePayload<EarthquakeV1>(:final newData) =>
                  _upsertEarthquakeV1s([newData]),
                RealtimePostgresDeletePayload<EarthquakeV1>() => null,
              };
            }
          },
        );
    }

    return _fetchInitialData(
      param: parameter,
      regions: earthquakeParameter.regions,
    );
  }

  Future<(List<EarthquakeV1Extended>, int totalCount)> _fetchInitialData({
    required EarthquakeHistoryParameter param,
    required List<EarthquakeParameterRegionItem> regions,
  }) async {
    ref.invalidate(earthquakeHistoryDetailsNotifierProvider);

    final result = await ref
        .read(earthquakeHistoryRepositoryProvider)
        .fetchEarthquakeLists(
          depthGte: param.depthGte,
          depthLte: param.depthLte,
          intensityGte: param.intensityGte,
          intensityLte: param.intensityLte,
          magnitudeGte: param.magnitudeGte,
          magnitudeLte: param.magnitudeLte,
        );
    return (
      await _v1ToV1Extended(
        data: result.items,
        regions: regions,
      ),
      result.count,
    );
  }

  Future<void> refresh() async {
    ref.invalidate(earthquakeHistoryDetailsNotifierProvider);
    state = const AsyncLoading();
    state =
        await AsyncValue.guard<(List<EarthquakeV1Extended>, int totalCount)>(
            () async {
      // ensure earthquakeParameter has been initialized.
      if (ref.read(jmaParameterProvider).hasError) {
        ref.invalidate(jmaParameterProvider);
      }
      await ref.read(jmaParameterProvider.future);
      final earthquakeParameter =
          ref.watch(jmaParameterProvider).valueOrNull!.earthquake;

      return _fetchInitialData(
        param: parameter,
        regions: earthquakeParameter.regions,
      );
    });
  }

  Future<void> fetchNextData() async {
    // 読み込み中の場合は何もしない
    if (state.isRefreshing || state.isReloading) {
      return;
    }
    // すでに全件取得済みの場合は何もしない
    if (!(state.valueOrNull?.hasNext ?? false)) {
      return;
    }
    final jmaEarthquakeParameter =
        ref.read(jmaParameterProvider).valueOrNull?.earthquake;
    if (jmaEarthquakeParameter == null) {
      throw EarthquakeParameterHasNotInitializedException();
    }

    state = const AsyncLoading<(List<EarthquakeV1Extended>, int totalCount)>()
        .copyWithPrevious(state);
    state = await state.guardPlus(
      () async {
        final repository = ref.read(earthquakeHistoryRepositoryProvider);
        final currentData = state.valueOrNull;
        final result = await repository.fetchEarthquakeLists(
          depthGte: parameter.depthGte,
          depthLte: parameter.depthLte,
          intensityGte: parameter.intensityGte,
          intensityLte: parameter.intensityLte,
          magnitudeGte: parameter.magnitudeGte,
          magnitudeLte: parameter.magnitudeLte,
          offset: currentData?.$1.length ?? 0,
          limit: 50,
        );
        final extendedResult = await _v1ToV1Extended(
          data: result.items,
          regions: jmaEarthquakeParameter.regions,
        );
        return (
          <EarthquakeV1Extended>[
            ...currentData?.$1 ?? [],
            ...extendedResult,
          ].sorted(
            (a, b) => b.eventId.compareTo(a.eventId),
          ),
          result.count
        );
      },
    );
  }

  Future<void> _onResumed() async {
    // パラメータが指定されている場合は何もしない
    if (parameter != const EarthquakeHistoryParameter()) {
      return;
    }
    final repository = ref.read(earthquakeHistoryRepositoryProvider);
    final result = await repository.fetchEarthquakeLists();
    await _upsertEarthquakeV1s(result.items);
  }

  Future<void> _refreshIfWebsocketNotConnected() async {
    // AsyncData以外の場合は何もしない
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      log('state is not AsyncData<EarthquakeHistoryNotifierState>');
      return;
    }
    // WebSocketが接続されている場合は何もしない
    final webSocketState = ref.read(websocketStatusProvider);
    if (webSocketState is Connected || webSocketState is Reconnected) {
      log('WebSocket is ${webSocketState.runtimeType}');
      return;
    }
    // パラメータが指定されている場合は何もしない
    if (parameter != const EarthquakeHistoryParameter()) {
      log('parameter is not default');
      return;
    }
    log('refreshIfWebsocketNotConnected');

    // リフレッシュ処理を実行
    final repository = ref.read(earthquakeHistoryRepositoryProvider);
    final result = await repository.fetchEarthquakeLists();
    await _upsertEarthquakeV1s(result.items);
  }

  Future<void> _upsertEarthquakeV1s(List<EarthquakeV1> items) async {
    // AsyncValue以外の場合は何もしない
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      return;
    }
    final currentData = state.valueOrNull;
    if (currentData == null) {
      return;
    }
    final baseHistories = currentData.$1;
    final histories = [...baseHistories];
    final extended = await _v1ToV1Extended(
      data: items,
      regions: ref.read(jmaParameterProvider).valueOrNull!.earthquake.regions,
    );
    for (final item in extended) {
      final index = histories.indexWhereOrNull(
        (element) => element.eventId == item.eventId,
      );
      if (index == null) {
        histories.add(item);
      } else {
        histories[index] = item;
      }
    }
    // event_idで降順ソート
    histories.sort((a, b) => b.eventId.compareTo(a.eventId));
    state = AsyncData(
      (histories, currentData.$2),
    );
  }

  Future<List<EarthquakeV1Extended>> _v1ToV1Extended({
    required List<EarthquakeV1> data,
    required List<EarthquakeParameterRegionItem> regions,
  }) async {
    return <EarthquakeV1Extended>[
      for (final e in data)
        EarthquakeV1Extended(
          earthquake: e,
          maxIntensityRegionNames: e.maxIntensityRegionIds
              ?.map(
                (region) => regions
                    .firstWhereOrNull(
                      (paramRegion) => int.parse(paramRegion.code) == region,
                    )
                    ?.name,
              )
              .whereNotNull()
              .toList(),
        ),
    ];
    /* 別Isolateで処理させるならコッチ
    final stopWatch = Stopwatch()..start();
    final result = await compute(
      (param) async {
        final data = param.$1;
        final regions = param.$2;


      },
      (
        data,
        regions.map(
          (e) => (e.code, e.name),
        )
      ),
    );
    stopWatch.stop();
    log('compute time: ${stopWatch.elapsedMilliseconds}ms');
    return result;*/
  }

  /// WebSocketからのデータを適用する
  void applyWebSocketData(
    RealtimePostgresChangesPayloadTable<EarthquakeV1> payload,
  ) {
    // AsyncValue以外の場合は何もしない
    if (state is! AsyncData<EarthquakeHistoryNotifierState>) {
      return;
    }
    final currentData = state.valueOrNull;
    if (currentData == null) {
      return;
    }
    switch (payload) {
      case RealtimePostgresInsertPayload<EarthquakeV1>():
        () {
          final newData = payload.newData;
          // もしも、同一event_idのデータが既に存在していた場合は、更新する
          final index = currentData.$1.indexWhereOrNull(
            (element) => element.eventId == newData.eventId,
          );
          if (index == null) {}
        }();
      case RealtimePostgresUpdatePayload<EarthquakeV1>():
      case RealtimePostgresDeletePayload<EarthquakeV1>():
    }
  }
}

@riverpod
Future<EarthquakeV1Extended> earthquakeV1Extended(
  EarthquakeV1ExtendedRef ref,
  EarthquakeV1 data,
) async {
  // ensure earthquakeParameter has been initialized.
  await ref.read(jmaParameterProvider.future);

  final earthquakeParameter =
      ref.watch(jmaParameterProvider).valueOrNull?.earthquake;

  if (earthquakeParameter == null) {
    throw EarthquakeParameterHasNotInitializedException();
  }
  final regions = earthquakeParameter.regions;

  return EarthquakeV1Extended(
    earthquake: data,
    maxIntensityRegionNames: data.maxIntensityRegionIds
        ?.map(
          (region) => regions
              .firstWhereOrNull(
                (paramRegion) => int.parse(paramRegion.code) == region,
              )
              ?.name,
        )
        .whereNotNull()
        .toList(),
  );
}

class EarthquakeParameterHasNotInitializedException implements Exception {}

extension EarthquakeHistoryState on (
  List<EarthquakeV1Extended>,
  int totalCount
) {
  bool get hasNext => $1.length < $2;
}

extension EarthquakeHistoryParameterMatch on EarthquakeHistoryParameter {
  bool isRealtimeDataMatch(
    RealtimePostgresChangesPayloadTable<EarthquakeV1> payload,
  ) {
    return switch (payload) {
      RealtimePostgresInsertPayload<EarthquakeV1>() =>
        isEarthquakeV1Match(payload.newData),
      RealtimePostgresUpdatePayload<EarthquakeV1>() =>
        isEarthquakeV1Match(payload.newData),
      RealtimePostgresDeletePayload<EarthquakeV1>() => false,
    };
  }

  bool isEarthquakeV1Match(EarthquakeV1 data) {
    // intensity
    final intensity = data.maxIntensity;
    if (intensity == null) {
      return false;
    }
    // intensityGte
    if (intensityGte != null && intensity < intensityGte!) {
      return false;
    }
    // intensityLte
    if (intensityLte != null && intensity > intensityLte!) {
      return false;
    }

    // magnitude
    final magnitude = data.magnitude;
    if (magnitude == null) {
      return false;
    }
    // magnitudeGte
    if (magnitudeGte != null && magnitude < magnitudeGte!) {
      return false;
    }
    // magnitudeLte
    if (magnitudeLte != null && magnitude > magnitudeLte!) {
      return false;
    }

    // depth
    final depth = data.depth;
    if (depth == null) {
      return false;
    }
    // depthGte
    if (depthGte != null && depth < depthGte!) {
      return false;
    }
    // depthLte
    if (depthLte != null && depth > depthLte!) {
      return false;
    }

    return true;
  }
}
