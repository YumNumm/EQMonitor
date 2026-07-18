import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ready events refresh displayed tsunami details', () {
    expect(
      isTsunamiRealtimeEventForId(
        event: const RealtimeEvent.ready(source: RealtimeSource.eqmonitor),
        tsunamiId: 'tsunami-1',
      ),
      isTrue,
    );
  });

  test('tsunami realtime events match by tsunami eventId or groupId', () {
    expect(
      isTsunamiRealtimeEventForId(
        event: const RealtimeEvent.tsunamiUpsert(
          eventId: 'event-1',
          source: RealtimeSource.eqmonitor,
          groupId: 'tsunami-1',
        ),
        tsunamiId: 'tsunami-1',
      ),
      isTrue,
    );
    expect(
      isTsunamiRealtimeEventForId(
        event: const RealtimeEvent.tsunamiDelete(
          eventId: 'tsunami-1',
          source: RealtimeSource.eqmonitor,
        ),
        tsunamiId: 'tsunami-1',
      ),
      isTrue,
    );
    expect(
      isTsunamiRealtimeEventForId(
        event: const RealtimeEvent.tsunamiUpsert(
          eventId: 'event-2',
          source: RealtimeSource.eqmonitor,
          groupId: 'tsunami-2',
        ),
        tsunamiId: 'tsunami-1',
      ),
      isFalse,
    );
  });
}
