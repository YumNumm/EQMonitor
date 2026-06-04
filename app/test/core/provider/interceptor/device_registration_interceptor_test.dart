// ignore_for_file: type_annotate_public_apis

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/interceptor/app_check_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}

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
