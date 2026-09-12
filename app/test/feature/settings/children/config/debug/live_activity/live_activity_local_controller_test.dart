import 'dart:convert';

import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('net.yumnumm.eqmonitor/live_activity_debug');
  const controller = MethodChannelLiveActivityLocalController();
  const builder = DebugLiveActivityContentBuilder();
  final calls = <MethodCall>[];
  final now = DateTime.utc(2026, 9, 12, 1);

  UnifiedLiveActivityContentState state({
    DebugUnifiedPreset preset = DebugUnifiedPreset.eew,
  }) => builder.unifiedFromPreset(
    preset: preset,
    id: 'logical-1',
    now: now,
  );

  void handle(Future<dynamic> Function(MethodCall call) handler) {
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

  test(
    'start sends attributes and unified content without legacy top-level keys',
    () async {
      handle(
        (call) async => <String, dynamic>{
          'activityId': 'activity-123',
          'logicalId': 'logical-1',
          'eventId': 'debug-event-logical-1',
        },
      );

      final session = await controller.start(state: state());

      expect(
        session,
        const DebugLiveActivitySession(
          activityId: 'activity-123',
          logicalId: 'logical-1',
          eventId: 'debug-event-logical-1',
        ),
      );
      expect(calls.single.method, 'start');
      final arguments = jsonDecode(
        jsonEncode(calls.single.arguments),
      ) as Map<String, dynamic>;
      expect(arguments.keys, <String>['attributes', 'contentState']);
      expect(arguments['attributes'], <String, dynamic>{'id': 'logical-1'});
      final content = jsonDecode(
        arguments['contentState'] as String,
      ) as Map<String, dynamic>;
      expect(content['id'], 'logical-1');
      expect(content, isNot(contains('kind')));
      expect(arguments, isNot(contains('eventId')));
    },
  );

  test('update sends only activityId and complete contentState', () async {
    handle((call) async => null);

    await controller.update(activityId: 'activity-9', state: state());

    final arguments =
        jsonDecode(jsonEncode(calls.single.arguments)) as Map<String, dynamic>;
    expect(calls.single.method, 'update');
    expect(arguments.keys, <String>['activityId', 'contentState']);
    expect(arguments['activityId'], 'activity-9');
    expect(jsonDecode(arguments['contentState'] as String), state().toJson());
  });

  test('end can omit contentState', () async {
    handle((call) async => null);

    await controller.end(activityId: 'activity-9');

    final arguments =
        jsonDecode(jsonEncode(calls.single.arguments)) as Map<String, dynamic>;
    expect(calls.single.method, 'end');
    expect(arguments, <String, dynamic>{'activityId': 'activity-9'});
  });

  test(
    'end sends a validated snapshot when contentState is supplied',
    () async {
      handle((call) async => null);

      await controller.end(activityId: 'activity-9', state: state());

      final arguments = jsonDecode(
        jsonEncode(calls.single.arguments),
      ) as Map<String, dynamic>;
      expect(arguments.keys, <String>['activityId', 'contentState']);
      expect(jsonDecode(arguments['contentState'] as String), state().toJson());
    },
  );

  test(
    'list decodes every native session without fabricating eventId',
    () async {
      handle(
        (call) async => <Map<String, dynamic>>[
          <String, dynamic>{
            'activityId': 'activity-eew',
            'logicalId': 'logical-eew',
            'eventId': 'event-eew',
          },
          <String, dynamic>{
            'activityId': 'activity-shake',
            'logicalId': 'logical-shake',
          },
        ],
      );

      final sessions = await controller.list();

      expect(calls.single.method, 'list');
      expect(calls.single.arguments, isNull);
      expect(sessions, <DebugLiveActivitySession>[
        const DebugLiveActivitySession(
          activityId: 'activity-eew',
          logicalId: 'logical-eew',
          eventId: 'event-eew',
        ),
        const DebugLiveActivitySession(
          activityId: 'activity-shake',
          logicalId: 'logical-shake',
          eventId: null,
        ),
      ]);
    },
  );

  test('malformed native response fails with a short checked error', () async {
    handle(
      (call) async => <String, dynamic>{
        'activityId': '',
        'logicalId': 'logical-1',
      },
    );

    expect(
      () => controller.start(state: state()),
      throwsA(
        isA<LiveActivityLocalException>()
            .having((error) => error.code, 'code', 'invalid_response')
            .having(
              (error) => error.message,
              'message',
              'ネイティブ応答が不正です',
            ),
      ),
    );
  });

  test(
    'invalid directly constructed DTO fails before invoking native code',
    () async {
      handle((call) async => null);
      final invalid = state().copyWith(schemaVersion: 1);

      expect(
        () => controller.update(activityId: 'activity-1', state: invalid),
        throwsA(
          isA<LiveActivityLocalException>().having(
            (error) => error.code,
            'code',
            'invalid_content_state',
          ),
        ),
      );
      expect(calls, isEmpty);
    },
  );

  test('platform errors are mapped to short Japanese messages', () async {
    handle(
      (call) async => throw PlatformException(
        code: 'activity_not_found',
        message: 'raw native details must stay hidden',
      ),
    );

    expect(
      () => controller.update(activityId: 'missing', state: state()),
      throwsA(
        isA<LiveActivityLocalException>()
            .having((error) => error.code, 'code', 'activity_not_found')
            .having(
              (error) => error.message,
              'message',
              'Live Activity が見つかりません',
            )
            .having(
              (error) => error.toString(),
              'toString',
              isNot(contains('raw native details')),
            ),
      ),
    );
  });
}
