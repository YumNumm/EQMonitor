import 'package:dio/dio.dart';

/// api-stub の Admin API (`/__stub__/api/*`) をテストから制御するヘルパ。
///
/// 各テストの tearDown で [resetAll] を呼び、モードを default に戻して独立性を保つ。
class StubAdmin {
  StubAdmin(this._dio);

  final Dio _dio;

  /// 指定 endpoint key を error モードにする（[status] を返すようになる）。
  Future<void> setError(
    String key,
    int status, {
    Object? body,
  }) async {
    await _dio.put<void>(
      '/__stub__/api/mocks',
      data: {
        'kind': 'error',
        'key': key,
        'status': status,
        'body': body ?? {'code': 'INTERNAL', 'message': 'stub error'},
      },
    );
  }

  /// 指定 endpoint key を named fixture モードにする。
  Future<void> setFixture(String key, String fixtureName) async {
    await _dio.put<void>(
      '/__stub__/api/mocks',
      data: {'kind': 'fixture', 'key': key, 'fixtureName': fixtureName},
    );
  }

  /// 全モードを default に戻す。
  Future<void> resetAll() async {
    await _dio.delete<void>('/__stub__/api/mocks/all');
  }
}
