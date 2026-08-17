import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const codec = DebugLiveActivityJsonCodec();

  test('encode → parse でオブジェクトが往復する', () {
    final source = <String, dynamic>{
      'eventId': 'ev-1',
      'serialNo': 3,
      'isWarning': true,
      'location': <String, dynamic>{'regionName': '東京都23区'},
    };

    final encoded = codec.encode(source);
    final result = codec.parse(encoded);

    expect(result, isA<Success<Map<String, dynamic>, FormatException>>());
    final parsed = (result as Success).value as Map<String, dynamic>;
    expect(parsed['eventId'], 'ev-1');
    expect(parsed['serialNo'], 3);
    expect((parsed['location'] as Map)['regionName'], '東京都23区');
  });

  test('空文字は Failure', () {
    expect(codec.parse('   '), isA<Failure<Map<String, dynamic>, FormatException>>());
  });

  test('不正な JSON は Failure', () {
    expect(codec.parse('{ not json '), isA<Failure<Map<String, dynamic>, FormatException>>());
  });

  test('オブジェクト以外（配列）は Failure', () {
    expect(codec.parse('[1, 2, 3]'), isA<Failure<Map<String, dynamic>, FormatException>>());
  });
}
