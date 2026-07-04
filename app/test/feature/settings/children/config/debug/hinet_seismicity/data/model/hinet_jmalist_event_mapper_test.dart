import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/model/hinet_jmalist_event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nied_api_client/nied_api_client.dart';

void main() {
  test('M2がある場合は magnitude2 を優先する', () {
    final event = HinetJmalistEvent(
      originTime: DateTime.utc(2026, 6, 2, 11, 8, 33, 990),
      timeError: 0.07,
      latitude: 36.571,
      latitudeError: 0.18,
      longitude: 137.868,
      longitudeError: 0.29,
      depthKm: 7.7,
      magnitude1: 1,
      magnitude2: 1.6,
      magnitudeFlag: 'V',
      regionNameEn: 'NORTHERN NAGANO PREF',
      qualityCode: 'k',
    );

    final mapped = event.toSeismicityEvent;

    expect(mapped.magnitude, 1.6);
    expect(mapped.depth, 7.7);
    expect(mapped.latitude, 36.571);
    expect(mapped.longitude, 137.868);
    expect(mapped.maxIntensity, isNull);
    expect(mapped.eventId, isNotEmpty);
  });

  test('M2欠測時は magnitude1 を使う', () {
    final event = HinetJmalistEvent(
      originTime: DateTime.utc(2026, 6, 2),
      timeError: 0.1,
      latitude: 24.443,
      latitudeError: 0.34,
      longitude: 123.876,
      longitudeError: 0.34,
      depthKm: 8.7,
      magnitude1: 1.5,
      magnitude2: null,
      magnitudeFlag: null,
      regionNameEn: 'NEAR ISHIGAKIJIMA ISLAND',
      qualityCode: 'k',
    );

    expect(event.toSeismicityEvent.magnitude, 1.5);
  });
}
