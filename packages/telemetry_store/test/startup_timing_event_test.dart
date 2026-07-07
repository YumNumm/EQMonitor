import 'package:telemetry_store/src/models/telemetry_event.dart';
import 'package:test/test.dart';

void main() {
  test('startupTiming has correct eventType', () {
    const event = TelemetryEvent.startupTiming(phasesMicros: {'run_app': 1200});
    expect(event.eventType, 'startup_timing');
  });

  test('startupTiming toPayload nests phases_micros', () {
    const event = TelemetryEvent.startupTiming(
      phasesMicros: {'firebase_init': 1500, 'run_app': 4200},
    );
    expect(event.toPayload(), {
      'phases_micros': {'firebase_init': 1500, 'run_app': 4200},
    });
  });

  test('startupTiming eventId is null', () {
    const event = TelemetryEvent.startupTiming(phasesMicros: {});
    expect(event.eventId, isNull);
  });
}
