import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_id_interceptor.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceIdInterceptor> deviceIdInterceptor(Ref ref) async {
  final deviceId = await ref.watch(deviceIdProvider.future);
  return DeviceIdInterceptor(deviceId: deviceId);
}

class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor({required this.deviceId});

  final String deviceId;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (deviceId.isNotEmpty) {
      options.headers['x-eqmonitor-device-id'] = deviceId;
    }
    handler.next(options);
  }
}
