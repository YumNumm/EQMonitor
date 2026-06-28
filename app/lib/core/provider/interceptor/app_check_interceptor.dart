import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_app_check/firebase_app_check.dart';

typedef AppCheckTokenGetter = Future<String?> Function();

class AppCheckInterceptor extends Interceptor {
  AppCheckInterceptor({
    AppCheckTokenGetter? getToken,
    AppCheckTokenGetter? getLimitedUseToken,
  }) : _getToken = getToken ?? FirebaseAppCheck.instance.getToken,
       _getLimitedUseToken =
           getLimitedUseToken ?? FirebaseAppCheck.instance.getLimitedUseToken;

  final AppCheckTokenGetter _getToken;
  final AppCheckTokenGetter _getLimitedUseToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      const deviceRegistrationPath = api.DeviceApiClientUrls.postV2Device;
      const realtimeTicketPath = api.RealtimeApiClientUrls.getV2RealtimeTicket;
      const getMethod = 'GET';
      const postMethod = 'POST';
      final isDeviceRegistration =
          options.method == postMethod &&
          options.path == deviceRegistrationPath;
      final String? appCheckToken;

      if (isDeviceRegistration) {
        appCheckToken = await _getLimitedUseToken();
      } else if (options.path == realtimeTicketPath &&
          options.method == getMethod) {
        appCheckToken = await _getToken();
      } else {
        handler.next(options);
        return;
      }

      if (appCheckToken != null) {
        options.headers['X-Firebase-AppCheck'] = appCheckToken;
      }
      handler.next(options);
    } on FirebaseException catch (exception, stackTrace) {
      talker.info(
        'AppCheckInterceptor: AppCheck Tokenの発行に失敗しました。headerは無しで続行します',
        exception,
        stackTrace,
      );
      handler.next(options);
      // handler.reject(
      //   DioException.requestCancelled(
      //     requestOptions: options,
      //     reason: AppCheckRejection(exception),
      //     stackTrace: stackTrace,
      //   ),
      // );
    }
  }
}
