import 'package:dio/dio.dart';

/// Attaches `X-eqmonitor-device-id` to authenticated device requests.
///
/// `POST /v2/device` is registration and must not carry the device-id header
/// before the server has accepted the device.
class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor({required this.deviceId});

  final String deviceId;

  static const _headerName = 'x-eqmonitor-device-id';
  static const _deviceRegistrationPath = '/v2/device';
  static const _realtimeTicketPath = '/v2/realtime/ticket';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isDeviceRegistration =
        options.method == 'POST' && options.path == _deviceRegistrationPath;
    final isDeviceRequest = options.path == _deviceRegistrationPath ||
        options.path.startsWith('$_deviceRegistrationPath/');

    if (isDeviceRequest && !isDeviceRegistration) {
      options.headers[_headerName] = deviceId;
    }
    if (options.path.contains(_realtimeTicketPath)) {
      options.headers[_headerName] = deviceId;
    }
    handler.next(options);
  }
}
