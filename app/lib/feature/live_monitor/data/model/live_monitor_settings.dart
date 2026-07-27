import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_monitor_settings.freezed.dart';
part 'live_monitor_settings.g.dart';

enum LiveMonitorDisplayMode { automatic, split }

@freezed
abstract class LiveMonitorSettings with _$LiveMonitorSettings {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LiveMonitorSettings({
    @Default(LiveMonitorDisplayMode.automatic)
    LiveMonitorDisplayMode displayMode,
    @Default(10) int earthquakeDisplaySeconds,
    @Default(true) bool keepScreenAwake,
    @Default(0.5) double portraitRealtimeRatio,
    @Default(0.5) double landscapeRealtimeRatio,
  }) = _LiveMonitorSettings;

  factory LiveMonitorSettings.fromJson(Map<String, dynamic> json) =>
      _$LiveMonitorSettingsFromJson(json);
}
