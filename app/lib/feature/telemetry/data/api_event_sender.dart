import 'package:telemetry_store/telemetry_store.dart';

class ApiEventSender extends EventSender {
  @override
  Future<bool> send(List<Map<String, dynamic>> events) async {
    // TODO(telemetry): POST /v2/device/me/telemetry/events
    // Backend endpoint not yet implemented. Return false so events remain
    // in the local DB (unsynced) until the endpoint is ready, preventing
    // data loss.
    return false;
  }
}
