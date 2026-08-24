import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/logic/device_id_decoder.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_id_interceptor.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceIdInterceptor> deviceIdInterceptor(Ref ref) async {
  final repository = await ref.watch(deviceAuthRepositoryProvider.future);
  return DeviceIdInterceptor(
    readToken: repository.readToken,
    decoder: ref.watch(deviceIdDecoderProvider),
  );
}

class DeviceIdInterceptor extends Interceptor {
  new({
    required Future<String?> Function() readToken,
    DeviceIdDecoder decoder = const DeviceIdDecoder(),
  }) : _readToken = readToken,
       _decoder = decoder;

  final Future<String?> Function() _readToken;
  final DeviceIdDecoder _decoder;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _readToken();
    if (token == null || token.isEmpty) {
      handler.next(options);
      return;
    }
    try {
      options.headers['x-eqmonitor-device-id'] = _decoder.decode(token: token);
    } on FormatException {
      handler.next(options);
      return;
    }
    handler.next(options);
  }
}
