import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('activate/deactivateでsession状態を公開する', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(liveMonitorSessionProvider.notifier).activate();

    expect(container.read(liveMonitorSessionProvider), isTrue);

    container.read(liveMonitorSessionProvider.notifier).deactivate();

    expect(container.read(liveMonitorSessionProvider), isFalse);
  });
}
