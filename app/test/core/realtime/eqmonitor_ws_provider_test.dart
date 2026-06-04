import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ticket refresh delay never becomes negative', () {
    final calculator = EqmonitorWebSocketTicketRefreshDelayCalculator();
    final now = DateTime.utc(2026, 6, 4, 12);
    final expiresAt = now.add(const Duration(seconds: 10));

    final delay = calculator.calculate(now: now, expiresAt: expiresAt);

    expect(delay, Duration.zero);
  });
}
