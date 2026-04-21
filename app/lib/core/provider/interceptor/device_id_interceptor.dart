import 'package:dio/dio.dart';

/// Attaches `X-eqmonitor-device-id` to all `/v2/device/` requests
/// **except** `PUT /v2/device/{deviceId}` (device registration).
///
/// The PUT endpoint uses Firebase App Check for auth and must not carry
/// the device-id header before the device exists in the DB.
class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor({required this.deviceId});

  final String deviceId;

  static const _headerName = 'x-eqmonitor-device-id';
  static final _devicePathPattern = RegExp('^/v2/device/[^/]');
  static const _realtimeTicketPath = '/v2/realtime/ticket';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isPutRegistration =
        options.method == 'PUT' && _devicePathPattern.hasMatch(options.path);

    if (!isPutRegistration && _devicePathPattern.hasMatch(options.path)) {
      options.headers[_headerName] = deviceId;
    }
    if (options.path.contains(_realtimeTicketPath)) {
      options.headers[_headerName] = deviceId;
    }
    handler.next(options);
  }
}
