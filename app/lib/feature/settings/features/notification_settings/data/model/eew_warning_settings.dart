import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_settings.freezed.dart';
part 'eew_warning_settings.g.dart';

enum EewWarningTarget { currentLocationOnly, currentLocationAndNationwide }

@freezed
abstract class EewWarningSettings with _$EewWarningSettings {
  const factory({
    required EewWarningTarget target,
    required InterruptionLevel? nationwideInterruptionLevel,
  }) = _EewWarningSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$EewWarningSettingsFromJson(json);
}

extension ApiEewWarningConfigResponseConverter on api.EewWarningConfigResponse {
  EewWarningSettings toEewWarningSettings() => EewWarningSettings(
    target: target.toAppTarget,
    nationwideInterruptionLevel:
        nationwideInterruptionLevel?.toAppInterruptionLevel,
  );
}

extension ApiTargetConverter on api.Target {
  EewWarningTarget get toAppTarget => switch (this) {
    .currentLocationOnly => .currentLocationOnly,
    .currentLocationAndNationwide => .currentLocationAndNationwide,
  };
}

extension EewWarningTargetToApi on EewWarningTarget {
  api.Target get toApiTarget => switch (this) {
    .currentLocationOnly => .currentLocationOnly,
    .currentLocationAndNationwide => .currentLocationAndNationwide,
  };
}
