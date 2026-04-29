import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_ws_data_source.g.dart';

@Riverpod(keepAlive: true)
Stream<RealtimeEvent> eqMonitorWsDataSource(Ref ref) {
  return ref.read(eqMonitorWsStatusProvider.notifier).eventStream;
}
