import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/exception/app_check_rejection.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

typedef AppCheckTokenGetter = Future<String?> Function();

class AppCheckInterceptor extends Interceptor {
  AppCheckInterceptor({
    AppCheckTokenGetter? getToken,
    AppCheckTokenGetter? getLimitedUseToken,
  }) : _getToken = getToken ?? FirebaseAppCheck.instance.getToken,
       _getLimitedUseToken =
           getLimitedUseToken ?? FirebaseAppCheck.instance.getLimitedUseToken;

  static const _headerName = 'X-Firebase-AppCheck';
  static const _deviceRegistrationPath = '/v2/device';
  static const _realtimeTicketPath = '/v2/realtime/ticket';

  final AppCheckTokenGetter _getToken;
  final AppCheckTokenGetter _getLimitedUseToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final isDeviceRegistration =
          options.method == 'POST' && options.path == _deviceRegistrationPath;
      final String? appCheckToken;

      if (isDeviceRegistration) {
        // Replay Protection: 毎回新しいトークンを取得
        appCheckToken = await _getLimitedUseToken();
      } else if (options.path.contains(_realtimeTicketPath) &&
          options.method == 'GET') {
        appCheckToken = await _getToken();
      } else {
        handler.next(options);
        return;
      }

      if (appCheckToken != null) {
        options.headers[_headerName] = appCheckToken;
      }
      handler.next(options);
    } on FirebaseException catch (exception, stackTrace) {
      // reason が DioException.error フィールドになる。
      // AppCheckRejection を乗せることでマッパー側が文字列マッチなしに判別できる。
      handler.reject(
        DioException.requestCancelled(
          requestOptions: options,
          reason: AppCheckRejection(exception),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
