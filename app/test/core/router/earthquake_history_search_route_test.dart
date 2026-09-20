import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('検索語の日本語とURL特殊文字がディープリンクで保持される', () {
    const query = '東京 & 千代田区+沿岸/#';
    final incoming = Uri(
      scheme: 'eqmonitor',
      host: '',
      path: '/earthquake-history/search',
      queryParameters: {'query': query},
    );
    final link = NotificationDeepLink.fromUri(incoming);
    expect(link, isA<NotificationRouteLink>());
    final location = (link as NotificationRouteLink).location;
    expect(Uri.parse(location).queryParameters['query'], query);
    expect(location, const EarthquakeHistorySearchRoute(query: query).location);
  });
  test('Swiftが出力するURLのプラス記号を空白に変えない', () {
    final link = NotificationDeepLink.fromUri(
      Uri.parse('eqmonitor:///earthquake-history/search?query=Tokyo%2BChiyoda'),
    );
    expect(link, isA<NotificationRouteLink>());
    expect(
      Uri.parse((link as NotificationRouteLink).location)
          .queryParameters['query'],
      'Tokyo+Chiyoda',
    );
  });
  test('検索の未指定は空の検索画面を開く', () {
    expect(
      const EarthquakeHistorySearchRoute().location,
      '/earthquake-history/search',
    );
  });
  test('検索画面より深い未知のパスを許可しない', () {
    expect(
      NotificationDeepLink.fromUri(
        Uri.parse('eqmonitor:///earthquake-history/search/admin'),
      ),
      isNull,
    );
  });
}
