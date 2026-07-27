import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = EqMonitorRealtimeEventMapper();

  test('推計震度の生成時刻と識別値を正規化する', () {
    final envelope = api.RealtimeEventEnvelope.fromJson({
      'type': 'estimated_intensity',
      'operation': 'upsert',
      'event_id': '202607270001',
      'record': {
        'eventId': '202607270001',
        'estimatedIntensityKey': 'estimated/key.pmtiles',
        'createdAt': '2026-07-27T01:02:03Z',
      },
    });

    final events = mapper.map(WsMessage.realtime(data: envelope));

    expect(
      events.single,
      RealtimeEvent.estimatedIntensityUpsert(
        eventId: '202607270001',
        estimatedIntensityTile: 'estimated/key.pmtiles',
        generatedAt: DateTime.utc(2026, 7, 27, 1, 2, 3),
        source: RealtimeSource.eqmonitor,
      ),
    );
  });

  test('推計震度の不正な生成時刻はnullのまま正規化する', () {
    final envelope = api.RealtimeEventEnvelope.fromJson({
      'type': 'estimated_intensity',
      'operation': 'upsert',
      'event_id': '202607270002',
      'record': {
        'eventId': '202607270002',
        'estimatedIntensityKey': 'estimated/invalid-time.pmtiles',
        'createdAt': 'invalid-timestamp',
      },
    });

    final events = mapper.map(WsMessage.realtime(data: envelope));

    expect(
      events.single,
      const RealtimeEvent.estimatedIntensityUpsert(
        eventId: '202607270002',
        estimatedIntensityTile: 'estimated/invalid-time.pmtiles',
        generatedAt: null,
        source: RealtimeSource.eqmonitor,
      ),
    );
  });
}
