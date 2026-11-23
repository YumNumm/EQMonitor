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
import 'package:firebase_messaging/firebase_messaging.dart';
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

  // Patrol の権限ダイアログの操作は英語の端末でしか動かない。撮影は日本語の端末で行うため、iOS はラベルで押す。
  static const _iosAllowLabels = ['アプリの使用中は許可', '許可'];

  Future<void> grantPermissionDialogs() async {
    if (!Platform.isIOS) {
      while (await $.platform.mobile.isPermissionDialogVisible(
        timeout: const Duration(seconds: 2),
      )) {
        await $.platform.mobile.grantPermissionWhenInUse();
      }
      await _declineAndroidLocationAccuracy();
      return;
    }
    while (await _tapIosAllowButton()) {}
  }

  // Google Play 開発者サービスの「位置情報の精度」への同意を求めるダイアログ。同意はせずに閉じる。
  Future<void> _declineAndroidLocationAccuracy() async {
    try {
      await $.platform.android.tap(
        const AndroidSelector(text: 'No thanks'),
        timeout: const Duration(seconds: 2),
      );
    } on PatrolActionException {
      return;
    }
  }

  Future<bool> _tapIosAllowButton() async {
    for (final label in _iosAllowLabels) {
      try {
        await $.platform.ios.tap(
          IOSSelector(label: label, elementType: .button),
          appId: 'com.apple.springboard',
          timeout: const Duration(seconds: 2),
        );
        return true;
      } on PatrolActionException {
        continue;
      }
    }
    return false;
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

  // 撮影時に host が simctl push で送る通知を表示するため、通知と重大な通知を許可する。
  Future<void> allowNotifications() async {
    var isAnswered = false;
    final request = FirebaseMessaging.instance
        .requestPermission(criticalAlert: true)
        .whenComplete(() => isAnswered = true);
    final stopwatch = Stopwatch()..start();
    while (!isAnswered) {
      if (stopwatch.elapsed > const Duration(minutes: 3)) {
        fail('timed out waiting for the notification permission dialog');
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

  Future<void> earthquakeHistoryList({
    required String scene,
    required String detailEventId,
  }) async {
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
    // iPhone Duo の内側のように広い画面では一覧と詳細が並ぶ。詳細を空欄のまま撮らないよう、
    // 地震詳細のシーンと同じ地震を一覧から選ぶ。
    if (!$('一覧から表示する情報を選択してください').exists) {
      await _capture(scene, settle: const Duration(seconds: 5));
      return;
    }
    final tile = $(
      find.byWidgetPredicate(
        (widget) =>
            widget is EarthquakeHistoryListTile &&
            widget.item.earthquake.eventId == detailEventId,
      ),
    );
    await tile.scrollTo(
      view: find
          .ancestor(
            of: find.byType(EarthquakeHistoryListTile).first,
            matching: find.byType(Scrollable),
          )
          .first,
      maxScrolls: 80,
    );
    await tile.tap();
    await _waitUntil(
      () => $(ValueKey(detailEventId)).exists,
      timeout: const Duration(minutes: 2),
      description: 'earthquake $detailEventId',
    );
    _showObservedIntensity();
    await _capture(scene, settle: const Duration(seconds: 30));
  }

  // 推計震度分布がある地震は既定でそれを表示する。切り替えの状態はページ内にしか無い。
  void _showObservedIntensity() => $.tester
      .widget<EarthquakeIntensityCard>(
        find.byType(EarthquakeIntensityCard, skipOffstage: false),
      )
      .onDisplayModeChanged(.jma);

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
    _showObservedIntensity();
    // 震度の塗りはタイル単位で描かれ、10 秒では画面下側が欠けた。
    await _capture(scene, settle: const Duration(seconds: 30));
  }

  Future<void> lockScreenLiveActivity({
    required String scene,
    required String? watchScene,
  }) async {
    const eventId = 'eqmonitor-store-screenshot';
    // 到達までの秒数は撮る瞬間で変わり、iPhone と Apple Watch でも揃わない。表示を固定し、
    // 待っている間に実際の到達時刻を過ぎて表示が切り替わらないよう、到達は十分先に置く。
    final contentState =
        container
            .read(debugLiveActivityContentBuilderProvider)
            .eewFromPreset(
              preset: DebugEewPreset.warning,
              eventId: eventId,
              now: DateTime.now().add(const Duration(minutes: 30)),
            )
          ..['fixedRemainingSeconds'] = _fixedRemainingSeconds;
    await container
        .read(liveActivityLocalControllerProvider)
        .start(kind: .eew, eventId: eventId, contentState: contentState);
    if (watchScene != null) {
      // Watch に届くまでの時間は数秒〜数分とばらつく。host が Watch のスマートスタックを開き、到着をログで確かめる。
      await channel.capture('${watchScene}_prepare');
    }
    // 通知センターを開いた状態で届いた通知は、ペアリングした Apple Watch 側に出て iPhone に並ばないことがあった。
    // アプリを表示している間に host に送らせ、バナーが消えてから通知センターを開く。
    await channel.capture('${scene}_notify');
    // 重大な通知のバナーは自動では消えず、残っていると通知センターを開く操作を妨げる。
    await Future<void>.delayed(const Duration(seconds: 2));
    await $.platform.ios.closeHeadsUpNotification();
    await Future<void>.delayed(const Duration(seconds: 2));
    await $.platform.mobile.openNotifications();
    await _allowLiveActivities();
    await _capture(scene, settle: const Duration(seconds: 3));
    await $.platform.mobile.closeNotifications();
  }

  static const _fixedRemainingSeconds = 16.3;

  // 初回だけ Live Activity の下に許可の確認が出る。許可済みの端末では出ない。
  Future<void> _allowLiveActivities() async {
    try {
      await $.platform.ios.tap(
        const IOSSelector(label: '許可', elementType: .button),
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
    // 位置情報を要求したあと、遅れて出ることがある。
    if (Platform.isAndroid) {
      await _declineAndroidLocationAccuracy();
    }
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
