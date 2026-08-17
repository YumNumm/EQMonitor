import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth_token_interceptor.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceAuthTokenInterceptor> deviceAuthTokenInterceptor(Ref ref) async {
  final repository = await ref.watch(deviceAuthRepositoryProvider.future);
  return DeviceAuthTokenInterceptor(readToken: repository.readToken);
}

class DeviceAuthTokenInterceptor extends Interceptor {
  new({required Future<String?> Function() readToken})
    : _readToken = readToken;

  final Future<String?> Function() _readToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const deviceMePath = api.DeviceApiClientUrls.getV2DeviceMe;
    final isDeviceMePath =
        options.path == deviceMePath ||
        options.path.startsWith('$deviceMePath/');
    if (!isDeviceMePath) {
      handler.next(options);
      return;
    }

    final token = await _readToken();
    if (token != null && token.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }
}
