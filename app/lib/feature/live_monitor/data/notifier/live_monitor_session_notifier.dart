import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_session_notifier.g.dart';

@Riverpod(keepAlive: true)
class LiveMonitorSession extends _$LiveMonitorSession {
  @override
  bool build() => false;

  void activate() => state = true;

  void deactivate() => state = false;
}
