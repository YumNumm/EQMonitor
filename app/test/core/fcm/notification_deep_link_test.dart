import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationDeepLink.fromData', () {
    test('eqmonitor スキームの link は内部遷移になる', () {
      final link = NotificationDeepLink.fromData({
        'link': 'eqmonitor:///earthquake-history-details/20260703123456',
        'eventId': '20260703123456',
      });
      expect(
        link,
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/earthquake-history-details/20260703123456',
        ),
      );
    });

    test('feed/source への link も内部遷移になる', () {
      final link = NotificationDeepLink.fromData({
        'link': 'eqmonitor:///feed/source/hash-abc',
      });
      expect(
        link,
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/feed/source/hash-abc',
        ),
      );
    });

    test('https の link は外部 URL になる', () {
      final link = NotificationDeepLink.fromData({
        'link': 'https://status.eqmonitor.app/',
      });
      expect(
        link,
        isA<NotificationUrlLink>().having(
          (l) => l.uri.toString(),
          'uri',
          'https://status.eqmonitor.app/',
        ),
      );
    });

    test('allowlist 外の内部パスは無視して eventId フォールバックする', () {
      final link = NotificationDeepLink.fromData({
        'link': 'eqmonitor:///settings/debug',
        'eventId': '20260703123456',
      });
      expect(
        link,
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/earthquake-history-details/20260703123456',
        ),
      );
    });

    test('link 無しは eventId フォールバック', () {
      final link = NotificationDeepLink.fromData({'eventId': 'ev1'});
      expect(
        link,
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/earthquake-history-details/ev1',
        ),
      );
    });

    test('link も eventId も無ければ null', () {
      expect(NotificationDeepLink.fromData({'type': 'EEW'}), isNull);
    });

    test('不正な URI は eventId フォールバック', () {
      final link = NotificationDeepLink.fromData({
        'link': '::not a uri::',
        'eventId': 'ev1',
      });
      expect(
        link,
        isA<NotificationRouteLink>().having(
          (l) => l.location,
          'location',
          '/earthquake-history-details/ev1',
        ),
      );
    });
  });
}
