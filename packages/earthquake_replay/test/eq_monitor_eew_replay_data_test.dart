import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:test/test.dart';

void main() {
  group('ReplayData.fromMsgPack - EqMonitorEewReplayData (type 1003)', () {
    final time = DateTime.utc(2024, 1, 1, 7, 10, 8);
    const json = '{"event_id":"20240101161010","serial_no":1}';

    test('type 1003 が EqMonitorEewReplayData にデコードされること', () {
      final result = ReplayData.fromMsgPack([
        1003,
        [time, json],
      ]);

      expect(result, isA<EqMonitorEewReplayData>());
      final data = result as EqMonitorEewReplayData;
      expect(data.type, ReplayDataType.eqMonitorEew);
      expect(data.time, time);
      expect(data.json, json);
    });

    test('ReplayDataType.eqMonitorEew の value が 1003 であること', () {
      expect(ReplayDataType.eqMonitorEew.value, 1003);
    });

    test('fromMsgPack ファクトリが時刻と JSON を保持すること', () {
      final data = EqMonitorEewReplayData.fromMsgPack([time, json]);

      expect(data.type, ReplayDataType.eqMonitorEew);
      expect(data.time, time);
      expect(data.json, json);
    });
  });
}
