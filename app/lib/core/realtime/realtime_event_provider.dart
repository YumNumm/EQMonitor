import 'dart:async';

import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_data_source.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realtime_event_provider.g.dart';

/// 全データソースを集約し、正規化された [RealtimeEvent] を emit するプロバイダー。
///
/// 現在は EqMonitor WebSocket のみ。将来的に DMDATA 等を追加する場合は
/// ここに `ref.listen` を追加し、重複排除ロジックを実装する。
@Riverpod(keepAlive: true)
class RealtimeEvents extends _$RealtimeEvents {
  /// これは状態ではなくイベント列なので、同じ値でも必ず通知する。
  ///
  /// 既定では前回の state と `==` のとき listener に通知されない。
  /// [RealtimeEvent.ready] は値等価なので、再接続で 2 回目の ready が
  /// 来ても観測できず、切断中の取りこぼしを REST で取り直せなくなる。
  @override
  bool updateShouldNotify(
    AsyncValue<RealtimeEvent> previous,
    AsyncValue<RealtimeEvent> next,
  ) => true;

  @override
  Stream<RealtimeEvent> build() async* {
    final controller = StreamController<RealtimeEvent>();
    ref.onDispose(controller.close);

    ref.listen(eqMonitorWsDataSourceProvider, (_, next) {
      next.whenData(controller.add);
    });
    yield* controller.stream;
  }
}
