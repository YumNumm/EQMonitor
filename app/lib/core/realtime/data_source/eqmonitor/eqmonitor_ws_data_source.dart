import 'dart:async';

import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_data_source.g.dart';

@Riverpod(keepAlive: true)
class EqMonitorWsDataSource extends _$EqMonitorWsDataSource {
  /// これは状態ではなくイベント列なので、同じ値でも必ず通知する。
  ///
  /// 既定では前回の state と `==` のとき listener に通知されない。
  /// 再接続時の [RealtimeEvent.ready] が直前の ready と等価になり、
  /// 下流に届かなくなるのを防ぐ。
  @override
  bool updateShouldNotify(
    AsyncValue<RealtimeEvent> previous,
    AsyncValue<RealtimeEvent> next,
  ) => true;

  @override
  Stream<RealtimeEvent> build() {
    final controller = StreamController<RealtimeEvent>();

    final mapper = ref.watch(eqMonitorRealtimeEventMapperProvider);
    ref.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
      next.whenData((message) {
        final events = mapper.map(message);
        events.forEach(controller.add);
      });
    });
    ref.onDispose(controller.close);
    return controller.stream;
  }
}
