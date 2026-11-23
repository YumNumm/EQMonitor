import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_status_card.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:patrol/patrol.dart';

import 'capture_channel.dart';

const storeScreenshotFixtureDirectory = 'assets/store_screenshot_fixtures';

class StoreScreenshotScenes({
  required final PatrolIntegrationTester $,
  required final ProviderContainer container,
  required final StoreScreenshotCaptureChannel channel,
}) {
  GoRouter get _router => container.read(goRouterProvider);

  Future<void> waitForHome() => _waitUntil(
    () =>
        _router.routerDelegate.currentConfiguration.uri.path ==
        const HomeRoute().location,
    timeout: const Duration(minutes: 3),
    description: 'home',
  );

  Future<void> grantPermissionDialogs() async {
    while (await $.platform.mobile.isPermissionDialogVisible(
      timeout: const Duration(seconds: 2),
    )) {
      await $.platform.mobile.grantPermissionWhenInUse();
    }
  }

  // EEW カードの現在地の予想震度と到達までの時間は、位置情報が取れるときだけ出る。
  Future<void> allowLocation() async {
    var isAnswered = false;
    final request = Geolocator.requestPermission().whenComplete(
      () => isAnswered = true,
    );
    // 高負荷の runner ではダイアログが出るまで時間がかかる。出る前に待ちへ入ると終わらない。
    final stopwatch = Stopwatch()..start();
    while (!isAnswered) {
      if (stopwatch.elapsed > const Duration(minutes: 3)) {
        fail('timed out waiting for the location permission dialog');
      }
      await grantPermissionDialogs();
    }
    await request;
  }

  Future<bool> hasFixture(String name) async {
    try {
      await rootBundle.load('$storeScreenshotFixtureDirectory/$name');
      return true;
    } on FlutterError {
      return false;
    }
  }

  Future<void> replay({
    required String scene,
    required String fixture,
    required DateTime time,
    required bool expectEew,
    ({double latitude, double longitude})? location,
  }) async {
    if (location != null) {
      await $.platform.mobile.setMockLocation(
        location.latitude,
        location.longitude,
      );
    }
    final replay = container.read(replayProvider.notifier);
    if (container.read(replayProvider)?.source.title != fixture) {
      final data = await rootBundle.load(
        '$storeScreenshotFixtureDirectory/$fixture',
      );
      final file = File(p.join((await getTemporaryDirectory()).path, fixture));
      await file.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
      await replay.open(source: Uri.file(file.path));
    }
    replay.pause();
    final loaded = container.read(replayProvider);
    if (loaded == null ||
        time.isBefore(loaded.startTime) ||
        time.isAfter(loaded.endTime)) {
      fail('$fixture does not cover $time');
    }
    await replay.seek(time);
    _router.go(const HomeRoute().location);
    await $(ReplayStatusCard)
        .waitUntilVisible(timeout: const Duration(minutes: 1));
    if (expectEew) {
      await $(EewCard).waitUntilVisible(timeout: const Duration(minutes: 1));
    }
    if (location != null) {
      await $('現在地\n揺れ到達まで').waitUntilVisible(
        timeout: const Duration(minutes: 1),
      );
    }
    await _capture(scene, settle: const Duration(seconds: 8));
  }

  Future<void> earthquakeHistoryList({required String scene}) async {
    if (container.read(replayProvider) != null) {
      container.read(replayProvider.notifier).exit();
    }
    _router.go(const HomeRoute().location);
    const parameter = EarthquakeHistoryParameter.all(
      sortBy: .eventId,
      sortOrder: .desc,
      intensityGte: .four,
    );
    _router
        .push<void>(const EarthquakeHistoryRoute().location, extra: parameter)
        .ignore();
    await $(EarthquakeHistoryListTile)
        .waitUntilVisible(timeout: const Duration(minutes: 2));
    await _capture(scene, settle: const Duration(seconds: 5));
  }

  Future<void> earthquakeDetail({
    required String scene,
    required String eventId,
  }) async {
    if (container.read(replayProvider) != null) {
      container.read(replayProvider.notifier).exit();
    }
    _router.go(const HomeRoute().location);
    _router
        .push<void>(EarthquakeHistoryDetailsRoute(eventId: eventId).location)
        .ignore();
    // ホームにも ErrorCard が出うるため、詳細画面の中だけを見る。
    final errorCard = $(EarthquakeHistoryDetailsPage).$(ErrorCard);
    await _waitUntil(
      () => $(ValueKey(eventId)).exists || errorCard.exists,
      timeout: const Duration(minutes: 2),
      description: 'earthquake $eventId',
    );
    if (errorCard.exists) {
      final error = $.tester.widget<ErrorCard>(errorCard.first).error;
      await errorCard.$('詳細').tap();
      await _capture('failure-$scene', settle: const Duration(seconds: 2));
      fail('earthquake $eventId failed to load: ${_describe(error)}');
    }
    // 推計震度分布がある地震は既定でそれを表示する。切り替えの状態はページ内にしか無い。
    $.tester
        .widget<EarthquakeIntensityCard>(
          find.byType(EarthquakeIntensityCard, skipOffstage: false),
        )
        .onDisplayModeChanged(.jma);
    // 震度の塗りはタイル単位で描かれ、10 秒では画面下側が欠けた。
    await _capture(scene, settle: const Duration(seconds: 30));
  }

  Future<void> lockScreenLiveActivity({required String scene}) async {
    const eventId = 'eqmonitor-store-screenshot';
    final contentState = container
        .read(debugLiveActivityContentBuilderProvider)
        .eewFromPreset(
          preset: DebugEewPreset.warning,
          eventId: eventId,
          now: DateTime.now(),
        );
    await container
        .read(liveActivityLocalControllerProvider)
        .start(kind: .eew, eventId: eventId, contentState: contentState);
    await $.platform.mobile.openNotifications();
    await _allowLiveActivities();
    await _capture(scene, settle: const Duration(seconds: 3));
    await $.platform.mobile.closeNotifications();
  }

  // 初回だけ Live Activity の下に許可の確認が出る。許可済みの端末では出ない。
  Future<void> _allowLiveActivities() async {
    try {
      await $.platform.ios.tap(
        const IOSSelector(label: 'Allow', elementType: .button),
        appId: 'com.apple.springboard',
        timeout: const Duration(seconds: 5),
      );
    } on PatrolActionException {
      return;
    }
  }

  Future<void> _capture(String scene, {required Duration settle}) async {
    await grantPermissionDialogs();
    await Future<void>.delayed(settle);
    await $.pump();
    await channel.capture(scene);
  }

  Future<void> _waitUntil(
    bool Function() condition, {
    required Duration timeout,
    required String description,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (!condition()) {
      if (stopwatch.elapsed > timeout) {
        fail('timed out waiting for $description');
      }
      await $.pump(const Duration(milliseconds: 200));
    }
  }

  String _describe(Object error) => switch (error) {
    DioException(:final requestOptions, :final response) =>
      '${requestOptions.method} ${requestOptions.uri.replace(query: '')} '
          '-> ${response?.statusCode} ${response?.headers.value('content-type')} '
          '${response?.data}',
    _ => '$error',
  };
}
