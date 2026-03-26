import 'package:dio/dio.dart';

class BearerAuthInterceptor extends Interceptor {
  BearerAuthInterceptor(this._getToken);

  /// 現在のトークンを返すゲッター。
  /// AuthNotifier の状態から同期的に読み取る。
  final String? Function() _getToken;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
