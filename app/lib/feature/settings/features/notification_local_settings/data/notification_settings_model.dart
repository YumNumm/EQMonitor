import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/components/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

@freezed
class NotificationSettingsModel with _$NotificationSettingsModel {
  const factory NotificationSettingsModel({
    @Default(EewSettings()) EewSettings eew,
    @Default(EarthquakeSettings()) EarthquakeSettings earthquake,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);
}

@freezed
class EewSettings with _$EewSettings {
  const factory EewSettings({
    @Default(null) JmaForecastIntensity? emergencyIntensity,
    @Default(null) JmaForecastIntensity? silentIntensity,
    @Default([]) List<Region> regions,
  }) = _EewSettings;

  factory EewSettings.fromJson(Map<String, dynamic> json) =>
      _$EewSettingsFromJson(json);
}

@freezed
class EarthquakeSettings with _$EarthquakeSettings {
  const factory EarthquakeSettings({
    @Default(null) JmaForecastIntensity? emergencyIntensity,
    @Default(null) JmaForecastIntensity? silentIntensity,
    @Default([]) List<Region> regions,
  }) = _EarthquakeSettings;

  factory EarthquakeSettings.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeSettingsFromJson(json);
}

@freezed
class Region with _$Region {
  const factory Region({
    required String code,
    required String name,
    required JmaForecastIntensity emergencyIntensity,
    required JmaForecastIntensity silentIntensity,
    required bool isMain,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}
