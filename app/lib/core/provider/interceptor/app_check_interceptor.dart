import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckInterceptor extends Interceptor {
  static const _headerName = 'X-EQMonitor-Device-Check';
  static final _deviceUpsertPattern = RegExp(r'/v2/device/[^/]+$');

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isDeviceUpsert =
        options.method == 'PUT' && _deviceUpsertPattern.hasMatch(options.path);
    final String? appCheckToken;

    if (isDeviceUpsert) {
      // Replay Protection: 毎回新しいトークンを取得
      appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
    } else if (_requiresAppCheck(options)) {
      appCheckToken = await FirebaseAppCheck.instance.getToken();
    } else {
      appCheckToken = null;
    }

    if (appCheckToken != null) {
      options.headers[_headerName] = appCheckToken;
    }
    handler.next(options);
  }

  bool _requiresAppCheck(RequestOptions options) {
    return options.method == 'GET' &&
        options.path.contains('/v2/websocket/ticket');
  }
}
