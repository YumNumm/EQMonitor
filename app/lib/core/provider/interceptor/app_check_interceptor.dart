import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_check_interceptor.g.dart';

typedef AppCheckTokenGetter = Future<String?> Function();

@Riverpod(keepAlive: true)
AppCheckInterceptor appCheckInterceptor(Ref ref) {
  return AppCheckInterceptor(
    getToken: FirebaseAppCheck.instance.getToken,
    getLimitedUseToken: FirebaseAppCheck.instance.getLimitedUseToken,
  );
}

class AppCheckInterceptor extends Interceptor {
  new({
    required AppCheckTokenGetter getToken,
    required AppCheckTokenGetter getLimitedUseToken,
    Duration tokenTimeout = const Duration(seconds: 10),
  }) : _getToken = getToken,
       _getLimitedUseToken = getLimitedUseToken,
       _tokenTimeout = tokenTimeout;

  final AppCheckTokenGetter _getToken;
  final AppCheckTokenGetter _getLimitedUseToken;

  /// AppCheck トークン取得の上限時間。
  ///
  /// interceptor 内の待ち時間は Dio の各種 timeout の対象外なので、ここで
  /// 明示的に打ち切らないと Play Integrity / App Attest の応答待ちで
  /// リクエストが永久に発行されないままになる。
  final Duration _tokenTimeout;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const deviceRegistrationPath = api.DeviceApiClientUrls.postV2Device;
    const realtimeTicketPath = api.RealtimeApiClientUrls.getV2RealtimeTicket;
    const getMethod = 'GET';
    const postMethod = 'POST';
    final isDeviceRegistration =
        options.method == postMethod && options.path == deviceRegistrationPath;
    final isRealtimeTicket =
        options.method == getMethod && options.path == realtimeTicketPath;

    if (!isDeviceRegistration && !isRealtimeTicket) {
      handler.next(options);
      return;
    }

    // backend は AppCheck 検証に失敗しても匿名デバイスとして登録を続行するため、
    // トークンが取れない場合はヘッダー無しで進めるのが正しい。ここで reject すると
    // 端末の Attestation が不調なだけのユーザーが登録できなくなる。
    try {
      final appCheckToken =
          await (isDeviceRegistration ? _getLimitedUseToken() : _getToken())
              .timeout(_tokenTimeout);
      if (appCheckToken != null) {
        options.headers['X-Firebase-AppCheck'] = appCheckToken;
      }
    } on TimeoutException catch (exception, stackTrace) {
      talker.info(
        'AppCheckInterceptor: AppCheck Tokenの取得が'
        '${_tokenTimeout.inSeconds}秒でタイムアウトしました。headerは無しで続行します',
        exception,
        stackTrace,
      );
    } on Object catch (exception, stackTrace) {
      // FirebaseException 以外 (PlatformException など) でもリクエスト自体を
      // 失敗させない。
      talker.info(
        'AppCheckInterceptor: AppCheck Tokenの発行に失敗しました。headerは無しで続行します',
        exception,
        stackTrace,
      );
    }
    handler.next(options);
  }
}
