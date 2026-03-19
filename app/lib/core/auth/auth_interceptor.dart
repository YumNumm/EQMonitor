import 'package:better_auth_client/better_auth_client.dart';
import 'package:dio/dio.dart';

/// Better Auth のセッショントークンを `Authorization: Bearer` ヘッダに付与する。
class BearerAuthInterceptor extends Interceptor {
  BearerAuthInterceptor(this._tokenStore);

  final TokenStore _tokenStore;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStore.getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
