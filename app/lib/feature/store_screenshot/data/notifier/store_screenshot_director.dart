import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:eqmonitor/feature/store_screenshot/data/model/store_screenshot_scene.dart';
import 'package:eqmonitor/feature/store_screenshot/data/model/store_screenshot_session.dart';
import 'package:eqmonitor/feature/store_screenshot/data/repository/store_screenshot_session_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_screenshot_director.g.dart';

@Riverpod(keepAlive: true)
class StoreScreenshotDirector extends _$StoreScreenshotDirector {
  @override
  void build() {}

  static final runMutation = Mutation<void>();
  Future<void> run({required StoreScreenshotSession session}) async {
    final repository = ref.read(storeScreenshotSessionRepositoryProvider);
    await waitForHome();
    for (final scene in session.scenes) {
      await switch (scene) {
        StoreScreenshotReplayScene() => showReplay(scene: scene),
        StoreScreenshotRouteScene() => showRoute(scene: scene),
        StoreScreenshotLiveActivityScene() => startLiveActivity(scene: scene),
      };
      await Future<void>.delayed(
        Duration(milliseconds: scene.settleMilliseconds),
      );
      await WidgetsBinding.instance.endOfFrame;
      await repository.markReady(scene: scene.name);
      await repository.waitForCapture(scene: scene.name);
    }
    await repository.markDone();
  }

  // SplashPage は初期化の完了後に Home へ遷移するため、先に遷移すると上書きされる。
  Future<void> waitForHome() async {
    final router = ref.read(goRouterProvider);
    while (router.routerDelegate.currentConfiguration.uri.path !=
        const HomeRoute().location) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }

  Future<void> showReplay({required StoreScreenshotReplayScene scene}) async {
    final replay = ref.read(replayProvider.notifier);
    if (ref.read(replayProvider)?.fileName != scene.fixture) {
      await replay.open(
        source: ref
            .read(storeScreenshotSessionRepositoryProvider)
            .fixtureUri(name: scene.fixture),
      );
    }
    replay.pause();
    final loaded = ref.read(replayProvider);
    if (loaded == null ||
        scene.time.isBefore(loaded.startTime) ||
        scene.time.isAfter(loaded.endTime)) {
      throw StateError('${scene.fixture} does not cover ${scene.time}');
    }
    await replay.seek(scene.time);
    ref.read(goRouterProvider).go(const HomeRoute().location);
  }

  Future<void> showRoute({required StoreScreenshotRouteScene scene}) async {
    if (ref.read(replayProvider) != null) {
      ref.read(replayProvider.notifier).exit();
    }
    final router = ref.read(goRouterProvider)..go(const HomeRoute().location);
    // push の Future は push した画面が閉じるまで完了しない。
    router.push<void>(scene.location).ignore();
  }

  Future<void> startLiveActivity({
    required StoreScreenshotLiveActivityScene scene,
  }) async {
    const eventId = 'eqmonitor-store-screenshot';
    final contentState = ref
        .read(debugLiveActivityContentBuilderProvider)
        .eewFromPreset(
          preset: scene.preset,
          eventId: eventId,
          now: DateTime.now(),
        );
    await ref
        .read(liveActivityLocalControllerProvider)
        .start(kind: .eew, eventId: eventId, contentState: contentState);
  }
}
