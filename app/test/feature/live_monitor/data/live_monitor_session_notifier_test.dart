import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('複数leaseの一方をreleaseしてもsessionを維持する', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(liveMonitorSessionProvider.notifier);

    expect(container.read(liveMonitorSessionProvider), isFalse);

    final firstLease = notifier.acquire();
    final secondLease = notifier.acquire();

    expect(container.read(liveMonitorSessionProvider), isTrue);

    notifier.release(lease: firstLease);

    expect(container.read(liveMonitorSessionProvider), isTrue);

    notifier.release(lease: secondLease);

    expect(container.read(liveMonitorSessionProvider), isFalse);

    notifier.release(lease: secondLease);

    expect(container.read(liveMonitorSessionProvider), isFalse);
  });
}
