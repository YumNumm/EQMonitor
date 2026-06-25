@Tags(['integration'])
library;

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:test/test.dart';

import 'stub_admin.dart';

/// Dart クライアント↔起動中 api-stub の結合テスト（Spec ②）。
///
/// 前提: api-stub が `STUB_BASE_URL`（既定 http://localhost:8790）で起動していること。
/// ローカル: `cd backend/api/api-stub && pnpm build && node dist/index.mjs`
/// 実行: `dart test --run-skipped --tags integration`
void main() {
  final baseUrl =
      Platform.environment['STUB_BASE_URL'] ?? 'http://localhost:8790';

  late Dio dio;
  late ApiClient api;
  late StubAdmin admin;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    api = ApiClient(dio);
    admin = StubAdmin(Dio(BaseOptions(baseUrl: baseUrl)));
  });

  tearDown(() async {
    await admin.resetAll();
    dio.close();
  });

  group('default モード: 実HTTP往復でモデルにデシリアライズできる', () {
    test('GET /v2/earthquake → EarthquakeListResponse', () async {
      final res = await api.earthquake.getV2Earthquake();
      expect(res.response.statusCode, 200);
      expect(res.data.items, isNotEmpty);
    });

    test('GET /v2/eew/latest → EewLatestResponse', () async {
      final res = await api.eew.getV2EewLatest();
      expect(res.response.statusCode, 200);
    });

    test('GET /v2/tsunami → TsunamiListResponse', () async {
      final res = await api.tsunami.getV2Tsunami();
      expect(res.response.statusCode, 200);
    });

    test('GET /v2/telegram → TelegramListResponse', () async {
      final res = await api.telegram.getV2Telegram();
      expect(res.response.statusCode, 200);
    });
  });

  group('error モード: クライアントが DioException を投げる', () {
    test('GET /v2/earthquake を 500 にすると DioException(500)', () async {
      await admin.setError('GET /v2/earthquake', 500);
      await expectLater(
        api.earthquake.getV2Earthquake(),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });
  });

  group('query parameters: 直列化されて 200 が返る', () {
    test('limit クエリ', () async {
      final res = await api.earthquake.getV2Earthquake(limit: '1');
      expect(res.response.statusCode, 200);
    });

    test('statuses(List<TelegramStatus>) クエリ', () async {
      final res = await api.telegram.getV2Telegram(
        statuses: const [TelegramStatus.normal],
      );
      expect(res.response.statusCode, 200);
    });
  });
}
