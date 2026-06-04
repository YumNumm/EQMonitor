import 'package:dio/dio.dart';

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
