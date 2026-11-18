import 'package:dio/dio.dart';
import 'package:telemetry_store/telemetry_store.dart';

class ApiEventSender(final Future<Dio> _dioFuture) extends EventSender {
  @override
  Future<bool> send(List<Map<String, dynamic>> events) async {
    try {
      final dio = await _dioFuture;
      await dio.post<void>(
        '/v2/device/me/telemetry/events',
        data: {'events': events},
      );
      return true;
    } on DioException {
      return false;
    }
  }
}
