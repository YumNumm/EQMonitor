import 'dart:io';

import 'package:eqmonitor/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'store_screenshot/capture_channel.dart';
import 'store_screenshot/store_screenshot_scenes.dart';

const _notoFixture = 'noto_peninsula_2024.eqrp';
const _detailEventId = '20260823020050';
const _requireFixtures = bool.fromEnvironment(
  'STORE_SCREENSHOT_REQUIRE_FIXTURES',
);
const _sceneFilter = String.fromEnvironment('STORE_SCREENSHOT_SCENES');
const _captureWatch = bool.fromEnvironment('STORE_SCREENSHOT_WATCH');

// 第30報（16:11:08）で警報の対象になり、揺れの到達まで時間が残る地域（千葉県北西部、千葉市役所）。
const _chiba = (latitude: 35.6073, longitude: 140.1063);
// 第10報（16:10:21）で予想震度と到達までの時間が出る地域（富山県西部、device.json と同じ高岡市太田）。
const _takaoka = (latitude: 36.815006, longitude: 137.03363);

const _preferences = <String, Object>{
  'debug': false,
  'onboarding_completed': true,
  'release_highlight_seen_version': '9999.0.0',
  'estimated_intensity_notice_shown': true,
  'eew_history_notice_shown': true,
  'is_estimated_intensity_on_eew_replay_allowed': true,
  'location_permission_banner_dismissed': true,
  'notification_permission_banner_dismissed': true,
};

void main() {
  patrolTest(
    'ストア画像のシーンを順に表示する',
    timeout: const Timeout(Duration(minutes: 30)),
    ($) async {
      final channel = await StoreScreenshotCaptureChannel.open();
      final preferences = await SharedPreferences.getInstance();
      for (final MapEntry(:key, :value) in _preferences.entries) {
        switch (value) {
          case final bool flag:
            await preferences.setBool(key, flag);
          case final String text:
            await preferences.setString(key, text);
        }
      }

      // AppBootstrap が差し替えるハンドラを戻さないと、テスト終了時の検査で失敗する。
      final flutterOnError = FlutterError.onError;
      final platformOnError = PlatformDispatcher.instance.onError;
      WidgetsApp.debugAllowBannerOverride = false;
      // アプリ内の「強い揺れに警戒!」の点滅は、アニメーションを減らす設定のとき塗ったままになる。
      $.tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      // LiveTestWidgetsFlutterBinding がテスト名を画面上端に描くため消す。公開 API は無い。
      if (WidgetsBinding.instance
          case final LiveTestWidgetsFlutterBinding binding) {
        // ignore: invalid_use_of_protected_member
        binding.setLabel('');
      }
      try {
        final container = await AppBootstrap.run();
        final scenes = StoreScreenshotScenes(
          $: $,
          container: container,
          channel: channel,
        );
        await scenes.waitForHome();
        await scenes.grantPermissionDialogs();
        await scenes.allowLocation();
        if (Platform.isIOS) {
          await scenes.allowNotifications();
        }

        bool wanted(String scene) =>
            _sceneFilter.isEmpty || _sceneFilter.split(',').contains(scene);

        final hasNoto = await scenes.hasFixture(_notoFixture);
        if (!hasNoto && _requireFixtures) {
          fail('missing $storeScreenshotFixtureDirectory/$_notoFixture');
        }
        if (hasNoto && wanted('eew_warning')) {
          await scenes.replay(
            scene: 'eew_warning',
            fixture: _notoFixture,
            time: DateTime.parse('2024-01-01T16:11:08+09:00'),
            expectEew: true,
            location: _chiba,
          );
        }
        if (hasNoto && wanted('kyoshin_monitor')) {
          await scenes.replay(
            scene: 'kyoshin_monitor',
            fixture: _notoFixture,
            time: DateTime.parse('2024-01-01T16:10:21+09:00'),
            expectEew: false,
            location: _takaoka,
          );
        }
        if (wanted('earthquake_history_list')) {
          await scenes.earthquakeHistoryList(scene: 'earthquake_history_list');
        }
        if (wanted('earthquake_detail')) {
          await scenes.earthquakeDetail(
            scene: 'earthquake_detail',
            eventId: _detailEventId,
          );
        }
        if (Platform.isIOS && wanted('lock_screen_live_activity')) {
          await scenes.lockScreenLiveActivity(
            scene: 'lock_screen_live_activity',
            watchScene: _captureWatch ? 'watch_live_activity' : null,
          );
        }
        await channel.markDone();
      } finally {
        FlutterError.onError = flutterOnError;
        PlatformDispatcher.instance.onError = platformOnError;
        WidgetsApp.debugAllowBannerOverride = true;
        $.tester.platformDispatcher.clearAccessibilityFeaturesTestValue();
      }
    },
  );
}
