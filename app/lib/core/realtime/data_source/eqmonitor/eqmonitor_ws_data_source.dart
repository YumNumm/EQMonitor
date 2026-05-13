import 'dart:async';

import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_data_source.g.dart';

@Riverpod(keepAlive: true)
Stream<RealtimeEvent> eqMonitorWsDataSource(Ref ref) {
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
