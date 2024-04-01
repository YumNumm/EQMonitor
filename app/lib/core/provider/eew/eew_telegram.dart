import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'eew_telegram.g.dart';

@riverpod
class Eew extends _$Eew {
  @override
  AsyncValue<List<EewV1>> build() {
    final restResult = ref.watch(_eewRestProvider);
    // AsyncData以外の場合は、そのまま返す
    // ^ AsyncError, AsyncLoading
    if (restResult is! AsyncData) {
      return restResult;
    }

    // WebSocketのListen開始

    final refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _refetchRestApi(),
    );
    ref.onDispose(refreshTimer.cancel);
    return restResult;
  }

  void _refetchRestApi() {
    // WebSocketが接続されている場合は、パス
    final webSocketState = ref.read(websocketStatusProvider);
    if (webSocketState is Connected || webSocketState is Reconnected) {
      return;
    }
    ref.invalidate(_eewRestProvider);
  }
}

@riverpod
Future<List<EewV1>> _eewRest(_EewRestRef ref) async {
  final api = ref.watch(eqApiProvider);
  final result = await api.v1.getEewLatest();
  return result.data;
}



/*
class EewTelegram extends _$EewTelegram {
  @override
  List<EarthquakeHistoryItem> build() {
    /*
    ref.listen(earthquakeHistoryViewModelProvider, (previous, next) {
      for (final item in (next?.value ?? <EarthquakeHistoryItem>[])
          .where((e) => e.latestEew != null)) {
        if (_shouldShow(item)) {
          upsert(item);
        }
      }
    });

    /// 古くなったEEWを棄却するタイマー
    Timer.periodic(const Duration(seconds: 2), (_) {
      final result = state.where(_shouldShow).toList();
      if (result.length != state.length) {
        log('UPDATE EEW LIST(${result.length})');

        state = result;
      }
    });

    ref.listenSelf((previous, next) {
      log(next.toString());
    });
*/
    return [];
  }
}
*/
