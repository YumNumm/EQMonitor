// ignore_for_file: type_annotate_public_apis

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/interceptor/app_check_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  talker_lib.talker = Talker();

  test('DeviceIdInterceptor attaches device id to POST /v2/device', () {
    final interceptor = DeviceIdInterceptor(deviceId: 'device-1');
    final options = RequestOptions(path: '/v2/device', method: 'POST');
    final handler = _CapturingRequestHandler();

    interceptor.onRequest(options, handler);

    expect(options.headers['x-eqmonitor-device-id'], 'device-1');
    expect(handler.nextOptions, same(options));
  });

  test('DeviceIdInterceptor attaches device id to arbitrary requests', () {
    final interceptor = DeviceIdInterceptor(deviceId: 'device-1');
    final options = RequestOptions(
      path: '/v2/parameters/manifest',
      method: 'GET',
    );
    final handler = _CapturingRequestHandler();

    interceptor.onRequest(options, handler);

    expect(options.headers['x-eqmonitor-device-id'], 'device-1');
    expect(handler.nextOptions, same(options));
  });

  test('DeviceIdInterceptor skips device id when unavailable', () {
    final interceptor = DeviceIdInterceptor(deviceId: '');
    final options = RequestOptions(
      path: '/v2/parameters/manifest',
      method: 'GET',
    );
    final handler = _CapturingRequestHandler();

    interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('x-eqmonitor-device-id'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test(
    'AppCheckInterceptor uses limited-use token for POST /v2/device',
    () async {
      final tokenSource = _AppCheckTokenSource();
      final interceptor = AppCheckInterceptor(
        getToken: tokenSource.getToken,
        getLimitedUseToken: tokenSource.getLimitedUseToken,
      );
      final options = RequestOptions(path: '/v2/device', method: 'POST');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers['X-Firebase-AppCheck'], 'limited-token');
      expect(tokenSource.limitedUseTokenCount, 1);
      expect(tokenSource.tokenCount, 0);
      expect(handler.nextOptions, same(options));
    },
  );

  test(
    'AppCheckInterceptor uses regular token for the realtime ticket',
    () async {
      final tokenSource = _AppCheckTokenSource();
      final interceptor = AppCheckInterceptor(
        getToken: tokenSource.getToken,
        getLimitedUseToken: tokenSource.getLimitedUseToken,
      );
      final options = RequestOptions(
        path: '/v2/realtime/ticket',
        method: 'GET',
      );
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers['X-Firebase-AppCheck'], 'regular-token');
      expect(tokenSource.tokenCount, 1);
      expect(tokenSource.limitedUseTokenCount, 0);
    },
  );

  test(
    'AppCheckInterceptor skips unrelated paths without fetching a token',
    () async {
      final tokenSource = _AppCheckTokenSource();
      final interceptor = AppCheckInterceptor(
        getToken: tokenSource.getToken,
        getLimitedUseToken: tokenSource.getLimitedUseToken,
      );
      final options = RequestOptions(path: '/v2/device/me', method: 'GET');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers.containsKey('X-Firebase-AppCheck'), isFalse);
      expect(tokenSource.tokenCount, 0);
      expect(tokenSource.limitedUseTokenCount, 0);
      expect(handler.nextOptions, same(options));
    },
  );

  // interceptor 内の待ち時間は Dio の timeout の対象外なので、ここで打ち切らないと
  // デバイス登録のリクエストが永久に発行されない。
  test(
    'AppCheckInterceptor gives up on a hanging token fetch and continues',
    () async {
      final interceptor = AppCheckInterceptor(
        getToken: _never,
        getLimitedUseToken: _never,
        tokenTimeout: const Duration(milliseconds: 20),
      );
      final options = RequestOptions(path: '/v2/device', method: 'POST');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(options.headers.containsKey('X-Firebase-AppCheck'), isFalse);
      expect(handler.nextOptions, same(options));
    },
  );

  // backend は AppCheck 検証に失敗しても匿名デバイスとして登録を続行するため、
  // トークンが取れないことを理由にリクエストを落としてはいけない。
  test('AppCheckInterceptor continues when the token fetch throws', () async {
    final interceptor = AppCheckInterceptor(
      getToken: _throwing,
      getLimitedUseToken: _throwing,
    );
    final options = RequestOptions(path: '/v2/device', method: 'POST');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('X-Firebase-AppCheck'), isFalse);
    expect(handler.nextOptions, same(options));
  });
}

Future<String?> _never() => Completer<String?>().future;

Future<String?> _throwing() async =>
    throw PlatformException(code: 'app-check-unavailable');

final class _CapturingRequestHandler extends RequestInterceptorHandler {
  RequestOptions? nextOptions;

  @override
  void next(RequestOptions requestOptions) {
    nextOptions = requestOptions;
  }
}

final class _AppCheckTokenSource {
  var tokenCount = 0;
  var limitedUseTokenCount = 0;

  Future<String?> getToken() async {
    tokenCount += 1;
    return 'regular-token';
  }

  Future<String?> getLimitedUseToken() async {
    limitedUseTokenCount += 1;
    return 'limited-token';
  }
}
