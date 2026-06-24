import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  final url = Uri.parse('https://v2.api.eqmonitor.app/v2/earthquake?limit=10');

  test('同一リクエストは同一キー (決定的)', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: url),
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: url),
    );
  });

  test('schemaVersion が変わるとキーが変わる', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: url),
      isNot(
        buildHttpCacheKey(schemaVersion: 2, appBuild: '3.0.0+100', url: url),
      ),
    );
  });

  test('appBuild が変わるとキーが変わる', () {
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: url),
      isNot(
        buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+101', url: url),
      ),
    );
  });

  test('クエリが変わるとキーが変わる', () {
    final other = Uri.parse(
      'https://v2.api.eqmonitor.app/v2/earthquake?limit=50',
    );
    expect(
      buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: url),
      isNot(
        buildHttpCacheKey(schemaVersion: 1, appBuild: '3.0.0+100', url: other),
      ),
    );
  });

  test('キーは名前空間 prefix を含む', () {
    final key = buildHttpCacheKey(
      schemaVersion: 7,
      appBuild: '3.0.0+100',
      url: url,
    );
    expect(key, startsWith('v7:3.0.0+100:'));
  });
}
