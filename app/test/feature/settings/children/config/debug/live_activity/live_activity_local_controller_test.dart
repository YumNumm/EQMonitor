import 'dart:convert';

import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('net.yumnumm.eqmonitor/live_activity_debug');
  const controller = MethodChannelLiveActivityLocalController();
  final calls = <MethodCall>[];

  void mock(Future<Object?>? Function(MethodCall call) handler) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return handler(call);
        });
  }

  setUp(calls.clear);

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('start は kind / eventId / contentState(JSON) を送り activityId を返す', () async {
    mock((call) async => call.method == 'start' ? 'activity-123' : null);

    final activityId = await controller.start(
      kind: DebugLiveActivityKind.eew,
      eventId: 'ev-1',
      contentState: <String, dynamic>{'eventId': 'ev-1', 'type': 'eew'},
    );

    expect(activityId, 'activity-123');
    final args = calls.single.arguments as Map;
    expect(calls.single.method, 'start');
    expect(args['kind'], 'eew');
    expect(args['eventId'], 'ev-1');
    final decoded = jsonDecode(args['contentState'] as String) as Map;
    expect(decoded['type'], 'eew');
  });

  test('start で activityId が空なら例外', () async {
    mock((call) async => '');

    expect(
      () => controller.start(
        kind: DebugLiveActivityKind.eew,
        eventId: 'ev-1',
        contentState: const <String, dynamic>{},
      ),
      throwsA(isA<LiveActivityLocalException>()),
    );
  });

  test('update は activityId と contentState を送る', () async {
    mock((call) async => null);

    await controller.update(
      kind: DebugLiveActivityKind.shakeDetection,
      activityId: 'activity-9',
      contentState: <String, dynamic>{'eventId': 'ev-2'},
    );

    final args = calls.single.arguments as Map;
    expect(calls.single.method, 'update');
    expect(args['kind'], 'shake_detection');
    expect(args['activityId'], 'activity-9');
  });

  test('end は contentState を省略できる', () async {
    mock((call) async => null);

    await controller.end(
      kind: DebugLiveActivityKind.eew,
      activityId: 'activity-9',
    );

    final args = calls.single.arguments as Map;
    expect(calls.single.method, 'end');
    expect(args['contentState'], isNull);
  });

  test('PlatformException は LiveActivityLocalException に変換される', () async {
    mock((call) async => throw PlatformException(code: 'boom', message: '失敗'));

    expect(
      () => controller.update(
        kind: DebugLiveActivityKind.eew,
        activityId: 'a',
        contentState: const <String, dynamic>{},
      ),
      throwsA(
        isA<LiveActivityLocalException>().having(
          (e) => e.code,
          'code',
          'boom',
        ),
      ),
    );
  });
}
