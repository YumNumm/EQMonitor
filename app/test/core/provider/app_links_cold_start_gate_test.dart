import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/app_links_cold_start_gate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLinksColdStartGate', () {
    test('resolveInitial 完了前に whenResolved を待つと、完了後に進む', () async {
      final gate = AppLinksColdStartGate();
      var resolved = false;

      final waiter = gate.whenResolved.then((_) {
        resolved = true;
      });
      expect(resolved, isFalse);

      gate.resolveInitial(
        Uri.parse('eqmonitor:///earthquake-history-details/202607160001'),
      );
      await waiter;

      expect(resolved, isTrue);
    });

    test('resolveInitial(null) でも whenResolved は完了する', () async {
      final gate = AppLinksColdStartGate();
      gate.resolveInitial(null);
      await gate.whenResolved;
      expect(gate.consumePending(), isNull);
    });

    test('Widget URL を resolve すると pending に詳細画面 location が入る', () {
      final gate = AppLinksColdStartGate();
      gate.resolveInitial(
        Uri.parse('eqmonitor:///earthquake-history-details/202607160001'),
      );

      expect(
        gate.consumePending(),
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/earthquake-history-details/202607160001',
        ),
      );
      expect(gate.consumePending(), isNull);
    });

    test('uriLinkStream の initial 重複は navigate しない', () {
      final gate = AppLinksColdStartGate();
      final initial = Uri.parse(
        'eqmonitor:///earthquake-history-details/202607160001',
      );
      gate.resolveInitial(initial);

      expect(gate.shouldNavigateForStreamUri(initial), isFalse);
      expect(gate.shouldNavigateForStreamUri(initial), isTrue);
    });

    test('initial 以外の stream URI は常に navigate する', () {
      final gate = AppLinksColdStartGate();
      gate.resolveInitial(
        Uri.parse('eqmonitor:///earthquake-history-details/202607160001'),
      );

      expect(
        gate.shouldNavigateForStreamUri(
          Uri.parse('eqmonitor:///earthquake-history'),
        ),
        isTrue,
      );
    });
  });
}
