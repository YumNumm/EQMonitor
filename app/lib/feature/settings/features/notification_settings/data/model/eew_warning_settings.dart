import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_settings.freezed.dart';
part 'eew_warning_settings.g.dart';

enum EewWarningTarget { currentLocationOnly, currentLocationAndNationwide }

/// 現在地を対象とする EEW 警報の割り込みレベル既定値。
///
/// 現在地は生命に直結するため、おやすみモード等を無視する critical を既定とする。
const InterruptionLevel currentLocationEewWarningDefaultLevel =
    InterruptionLevel.critical;

/// 全国を対象とする EEW 警報の割り込みレベル既定値。
///
/// 全国対象は「日本のどこかで警報」で必ず鳴るため、critical ではなく
/// time sensitive を既定とする。
const InterruptionLevel nationwideEewWarningDefaultLevel =
    InterruptionLevel.timeSensitive;

@freezed
abstract class EewWarningSettings with _$EewWarningSettings {
  const factory({
    required EewWarningTarget target,
    required InterruptionLevel currentLocationInterruptionLevel,
    required InterruptionLevel? nationwideInterruptionLevel,
  }) = _EewWarningSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$EewWarningSettingsFromJson(json);
}

extension ApiEewWarningConfigResponseConverter on api.EewWarningConfigResponse {
  EewWarningSettings toEewWarningSettings() => EewWarningSettings(
    target: target.toAppTarget,
    currentLocationInterruptionLevel:
        currentLocationInterruptionLevel.toAppInterruptionLevel,
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
