import 'dart:async';

import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

void main() {
  test('full EEW recordを反映し古いserialを無視すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        eewRestProvider.overrideWith((ref) async => []),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(eewProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.pump();

    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 2, zoneName: 'new'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    controller.add(
      RealtimeEvent.eewUpsert(
        record: _eew(serialNo: 1, zoneName: 'old'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();

    final item = container.read(eewProvider).value?.single;
    expect(item?.serialNo, 2);
    expect(item?.warning?.zones.single.name, 'new');
  });
}

api.EewItemWithRelations _eew({
  required int serialNo,
  required String zoneName,
}) => api.EewItemWithRelations(
  eventId: 'event-1',
  type: api.TelegramType.vxse45,
  status: api.TelegramStatus.normal,
  infoType: api.InfoType.publication,
  serialNo: serialNo,
  headline: null,
  isCanceled: false,
  isWarning: true,
  isLastInfo: false,
  originTime: null,
  arrivalTime: null,
  accuracy: null,
  isPlum: false,
  editorialOffice: '気象庁',
  reportTime: DateTime.utc(2026, 5, 1, 9),
  warning: api.EewWarning(
    zones: [
      api.EewWarningZoneItem(code: '9011', name: zoneName, hadWarning: false),
    ],
    prefectures: const [],
    regions: const [],
  ),
);
