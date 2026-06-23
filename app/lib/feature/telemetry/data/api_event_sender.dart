import 'package:telemetry_store/telemetry_store.dart';

class ApiEventSender extends EventSender {
  @override
  Future<bool> send(List<Map<String, dynamic>> events) async {
    // TODO(telemetry): POST /v2/device/me/telemetry/events
    // Backend endpoint not yet implemented. Accept silently for now
    // so local recording and flushing work end-to-end.
    return true;
  }
}
