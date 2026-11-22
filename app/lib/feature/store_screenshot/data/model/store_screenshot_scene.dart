import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_screenshot_scene.freezed.dart';
part 'store_screenshot_scene.g.dart';

@Freezed(unionKey: 'kind', unionValueCase: FreezedUnionCase.snake)
sealed class StoreScreenshotScene with _$StoreScreenshotScene {
  const factory replay({
    required String name,
    required int settleMilliseconds,
    required String fixture,
    required DateTime time,
  }) = StoreScreenshotReplayScene;

  const factory route({
    required String name,
    required int settleMilliseconds,
    required String location,
  }) = StoreScreenshotRouteScene;

  const factory liveActivity({
    required String name,
    required int settleMilliseconds,
    required DebugEewPreset preset,
  }) = StoreScreenshotLiveActivityScene;

  factory fromJson(Map<String, dynamic> json) =>
      _$StoreScreenshotSceneFromJson(json);
}
