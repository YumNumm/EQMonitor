import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheckInterceptor extends Interceptor {
  /// Firebase / バックエンドが検証する標準ヘッダー（REST カスタムリソースと同じ）。
  static const _headerName = 'X-Firebase-AppCheck';
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
    if (options.method != 'GET') {
      return false;
    }
    final path = options.path;
    return path.contains('/v2/websocket/ticket') ||
        path.contains('/v2/realtime/stream');
  }
}
