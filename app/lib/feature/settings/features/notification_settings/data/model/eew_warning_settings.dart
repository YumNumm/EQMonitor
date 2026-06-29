import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_settings.freezed.dart';

enum EewWarningTarget {
  currentLocationOnly,
  currentLocationAndNationwide;

  String get label => switch (this) {
    .currentLocationOnly => '現在地のみ',
    .currentLocationAndNationwide => '現在地＋全国',
  };
}

@freezed
abstract class EewWarningSettings with _$EewWarningSettings {
  const factory EewWarningSettings({
    required EewWarningTarget target,
    required InterruptionLevel? nationwideInterruptionLevel,
  }) = _EewWarningSettings;
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
    .currentLocationOnly => EewWarningTarget.currentLocationOnly,
    .currentLocationAndNationwide =>
      EewWarningTarget.currentLocationAndNationwide,
  };
}

extension EewWarningTargetToApi on EewWarningTarget {
  api.Target get toApiTarget => switch (this) {
    .currentLocationOnly => api.Target.currentLocationOnly,
    .currentLocationAndNationwide => api.Target.currentLocationAndNationwide,
  };
}
