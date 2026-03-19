import 'package:dio/dio.dart';
import 'package:eqmonitor/core/auth/secure_storage_token_store.dart';

/// [AuthTokenStore] からセッショントークンを読み取り
/// `Authorization: Bearer` ヘッダに付与する。
class BearerAuthInterceptor extends Interceptor {
  BearerAuthInterceptor(this._tokenStore);

  final AuthTokenStore _tokenStore;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStore.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
