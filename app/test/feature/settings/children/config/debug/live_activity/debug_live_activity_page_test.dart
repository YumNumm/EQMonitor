import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/ui/page/debug_live_activity_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const activeSession = DebugLiveActivitySession(
    activityId: 'activity-active',
    logicalId: 'logical-active',
    eventId: 'event-active',
  );
  const startedSession = DebugLiveActivitySession(
    activityId: 'activity-started',
    logicalId: 'logical-started',
    eventId: null,
  );

  Future<void> pumpPage(
    WidgetTester tester,
    FakeLiveActivityLocalController controller,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          liveActivityLocalControllerProvider.overrideWithValue(controller),
        ],
        child: const MaterialApp(home: DebugLiveActivityPage()),
      ),
    );
    await tester.pumpAndSettle();
  }

  TextEditingController fieldController(WidgetTester tester, int index) {
    final field = tester
        .widgetList<TextField>(find.byType(TextField))
        .elementAt(
          index,
        );
    final controller = field.controller;
    if (controller == null) {
      throw StateError('TextField controller is required');
    }
    return controller;
  }

  testWidgets('scenario switch keeps the selected OS and logical session IDs', (
    tester,
  ) async {
    final controller = FakeLiveActivityLocalController(
      listResponses: const [
        <DebugLiveActivitySession>[activeSession],
      ],
    );
    await pumpPage(tester, controller);
    await tester.ensureVisible(find.text('activity-active'));
    await tester.tap(find.text('activity-active'));
    await tester.pump();

    await tester.ensureVisible(find.text('緊急地震速報'));
    await tester.tap(find.text('緊急地震速報'));
    await tester.pump();

    expect(fieldController(tester, 0).text, 'activity-active');
    final contentState =
        jsonDecode(fieldController(tester, 1).text) as Map<String, dynamic>;
    expect(contentState['id'], 'logical-active');
    expect(contentState['primary'], 'eew');
    expect(controller.listCallCount, 1);
  });

  testWidgets('JSON and native failures preserve editor text and selection', (
    tester,
  ) async {
    final controller = FakeLiveActivityLocalController(
      listResponses: const [
        <DebugLiveActivitySession>[activeSession],
      ],
    );
    await pumpPage(tester, controller);
    await tester.ensureVisible(find.text('activity-active'));
    await tester.tap(find.text('activity-active'));
    await tester.pump();

    final jsonField = find.byType(TextField).last;
    await tester.enterText(jsonField, '{ invalid json');
    await tester.ensureVisible(find.text('更新'));
    await tester.tap(find.text('更新'));
    await tester.pumpAndSettle();

    expect(fieldController(tester, 1).text, '{ invalid json');
    expect(fieldController(tester, 0).text, 'activity-active');
    expect(controller.updateCallCount, 0);

    const validJson = '''
{
  "schemaVersion": 2,
  "id": "logical-active",
  "updatedAt": "2026-09-12T00:00:00Z",
  "primary": "shake_detection",
  "shakeDetection": {
    "headline": "shake",
    "detectedAt": "2026-09-12T00:00:00Z",
    "updatedAt": "2026-09-12T00:00:00Z",
    "level": "Weak",
    "status": "active",
    "location": null
  },
  "eew": null,
  "earthquake": null
}
''';
    controller.updateException = const LiveActivityLocalException(
      'Live Activity の操作に失敗しました',
      code: 'live_activity_error',
    );
    await tester.enterText(jsonField, validJson);
    await tester.tap(find.text('更新'));
    await tester.pumpAndSettle();

    expect(fieldController(tester, 1).text, validJson);
    expect(fieldController(tester, 0).text, 'activity-active');
    expect(controller.updateCallCount, 1);
  });

  testWidgets(
    'update, resume, and reload reconcile selection with the OS list',
    (
      tester,
    ) async {
      final controller = FakeLiveActivityLocalController(
        listResponses: const [
          <DebugLiveActivitySession>[activeSession],
          <DebugLiveActivitySession>[activeSession],
          <DebugLiveActivitySession>[activeSession],
          <DebugLiveActivitySession>[],
        ],
      );
      await pumpPage(tester, controller);
      await tester.ensureVisible(find.text('activity-active'));
      await tester.tap(find.text('activity-active'));
      await tester.pump();

      await tester.ensureVisible(find.text('更新'));
      await tester.tap(find.text('更新'));
      await tester.pumpAndSettle();

      expect(controller.updateCallCount, 1);
      expect(controller.listCallCount, 2);
      expect(fieldController(tester, 0).text, 'activity-active');

      for (final state in <AppLifecycleState>[
        .inactive,
        .hidden,
        .paused,
        .hidden,
        .inactive,
        .resumed,
      ]) {
        tester.binding.handleAppLifecycleStateChanged(state);
      }
      await tester.pumpAndSettle();

      expect(controller.listCallCount, 3);
      expect(fieldController(tester, 0).text, 'activity-active');

      final refresh = find.byTooltip('一覧を再読み込み');
      await tester.ensureVisible(refresh);
      await tester.tap(refresh);
      await tester.pumpAndSettle();

      expect(controller.listCallCount, 4);
      expect(fieldController(tester, 0).text, isEmpty);
      expect(find.text('activity-active'), findsNothing);
      expect(find.text('実行中の Live Activity はありません'), findsOneWidget);
    },
  );

  testWidgets('an older in-flight list does not clear a newly started session', (
    tester,
  ) async {
    final pendingList = Completer<List<DebugLiveActivitySession>>();
    final controller = FakeLiveActivityLocalController(
      listResponses: [
        const <DebugLiveActivitySession>[activeSession],
        pendingList.future,
        const <DebugLiveActivitySession>[startedSession],
      ],
    );
    await pumpPage(tester, controller);

    final refresh = find.byTooltip('一覧を再読み込み');
    await tester.ensureVisible(refresh);
    await tester.tap(refresh);
    await tester.pump();
    expect(controller.listCallCount, 2);

    await tester.ensureVisible(find.text('開始'));
    await tester.tap(find.text('開始'));
    await tester.pumpAndSettle();
    expect(controller.listCallCount, 3);
    expect(fieldController(tester, 0).text, 'activity-started');

    pendingList.complete(const <DebugLiveActivitySession>[]);
    await tester.pumpAndSettle();

    expect(fieldController(tester, 0).text, 'activity-started');
  });
}

class FakeLiveActivityLocalController implements LiveActivityLocalController {
  new({required this.listResponses});

  final List<FutureOr<List<DebugLiveActivitySession>>> listResponses;
  int listCallCount = 0;
  int updateCallCount = 0;
  LiveActivityLocalException? updateException;

  @override
  Future<bool> isSupported() async => true;

  @override
  Future<DebugLiveActivitySession> start({
    required UnifiedLiveActivityContentState state,
  }) async => const DebugLiveActivitySession(
    activityId: 'activity-started',
    logicalId: 'logical-started',
    eventId: null,
  );

  @override
  Future<void> update({
    required String activityId,
    required UnifiedLiveActivityContentState state,
  }) async {
    updateCallCount++;
    if (updateException case final exception?) {
      throw exception;
    }
  }

  @override
  Future<void> end({
    required String activityId,
    UnifiedLiveActivityContentState? state,
  }) async {}

  @override
  Future<List<DebugLiveActivitySession>> list() async {
    final index = listCallCount < listResponses.length
        ? listCallCount
        : listResponses.length - 1;
    listCallCount++;
    return listResponses[index];
  }
}
