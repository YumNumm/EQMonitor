import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'realtime_event_bootstrap_provider.g.dart';

/// アプリ起動時にリアルタイムイベントの購読を開始する。
@Riverpod(keepAlive: true)
void realtimeEventBootstrap(Ref ref) {
  ref.listen(realtimeEventsProvider, (_, _) {});
}
