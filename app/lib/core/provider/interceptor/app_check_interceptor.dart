import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/exception/app_check_rejection.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckInterceptor extends Interceptor {
  static const _headerName = 'X-Firebase-AppCheck';
  static final _deviceUpsertPattern = RegExp(r'/v2/device/[^/]+$');

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final isDeviceUpsert =
          options.method == 'PUT' &&
          _deviceUpsertPattern.hasMatch(options.path);
      final String? appCheckToken;

      if (isDeviceUpsert) {
        // Replay Protection: 毎回新しいトークンを取得
        appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
      } else if (options.path.contains('/v2/realtime/ticket') &&
          options.method == 'GET') {
        appCheckToken = await FirebaseAppCheck.instance.getToken();
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
