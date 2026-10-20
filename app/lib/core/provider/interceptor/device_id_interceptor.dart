import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/logic/device_id_decoder.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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
    try {
      final token = await _readToken();
      if (token != null && token.isNotEmpty) {
        options.headers['x-eqmonitor-device-id'] = _decoder.decode(
          token: token,
        );
        handler.next(options);
        return;
      }
    } on Exception {
      // 読み取り・解析失敗時も、端末 ID が任意の API は利用できる。
    }

    // ticket は端末 ID が必須。未登録・一時的な読み取り失敗では通信せず、
    // WebSocket のバックオフ後に保存済みトークンを読み直す。
    const ticketPath = api.RealtimeApiClientUrls.getV2RealtimeTicket;
    if (options.method == 'GET' &&
        (options.path == ticketPath || options.uri.path == ticketPath)) {
      handler.reject(
        DioException(
          requestOptions: options,
          message: 'A device ID is required to request a realtime ticket.',
        ),
      );
      return;
    }
    handler.next(options);
  }
}
