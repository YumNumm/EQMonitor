import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_session_notifier.g.dart';

final class LiveMonitorSessionLease {
  LiveMonitorSessionLease._();
}

@Riverpod(keepAlive: true)
class LiveMonitorSession extends _$LiveMonitorSession {
  final leases = <LiveMonitorSessionLease>{};

  @override
  bool build() => false;

  LiveMonitorSessionLease acquire() {
    final lease = LiveMonitorSessionLease._();
    leases.add(lease);
    state = true;
    return lease;
  }

  void release({required LiveMonitorSessionLease lease}) {
    leases.remove(lease);
    state = leases.isNotEmpty;
  }
}
