import 'package:eqmonitor/feature/store_screenshot/data/model/store_screenshot_scene.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_screenshot_session.freezed.dart';
part 'store_screenshot_session.g.dart';

@freezed
abstract class StoreScreenshotSession with _$StoreScreenshotSession {
  const factory({
    required Map<String, dynamic> preferences,
    required List<StoreScreenshotScene> scenes,
  }) = _StoreScreenshotSession;

  factory fromJson(Map<String, dynamic> json) =>
      _$StoreScreenshotSessionFromJson(json);
}
