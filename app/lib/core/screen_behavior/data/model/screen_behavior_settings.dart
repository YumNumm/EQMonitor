import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_behavior_settings.freezed.dart';

@freezed
abstract class ScreenBehaviorSettings with _$ScreenBehaviorSettings {
  const factory({
    @Default(false) bool keepScreenAwake,
    @Default(true) bool showWhenLocked,
  }) = _ScreenBehaviorSettings;
}
