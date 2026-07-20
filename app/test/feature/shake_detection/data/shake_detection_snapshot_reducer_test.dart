import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart';
import 'package:flutter_test/flutter_test.dart';

ShakeDetectionSnapshot snapshot(
  int revision,
  List<ShakeDetectionEvent> events,
) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: DateTime.utc(2026, 7, 19),
  events: events,
);

void main() {
  const reducer = ShakeDetectionSnapshotReducer();

  test('currentがnullならrevision 0の空snapshotも採用すること', () {
    final incoming = snapshot(0, []);
    expect(reducer.selectNewer(current: null, incoming: incoming), incoming);
  });

  test('大きいrevisionだけを採用すること', () {
    final current = snapshot(10, []);
    final incoming = snapshot(11, []);
    expect(reducer.selectNewer(current: current, incoming: incoming), incoming);
  });

  test('同一revisionを冪等に無視すること', () {
    final current = snapshot(10, []);
    expect(
      reducer.selectNewer(current: current, incoming: snapshot(10, [])),
      current,
    );
  });

  test('古いrevisionで巻き戻さないこと', () {
    final current = snapshot(10, []);
    expect(
      reducer.selectNewer(current: current, incoming: snapshot(9, [])),
      current,
    );
  });
}
