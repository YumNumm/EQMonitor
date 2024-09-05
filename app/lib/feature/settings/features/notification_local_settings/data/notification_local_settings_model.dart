import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_local_settings_model.freezed.dart';
part 'notification_local_settings_model.g.dart';

@freezed
class NotificationLocalSettingsModel with _$NotificationLocalSettingsModel {
  const factory NotificationLocalSettingsModel({
    @Default(EewSettings()) EewSettings eew,
    @Default(EarthquakeSettings()) EarthquakeSettings earthquake,
  }) = _NotificationLocalSettingsModel;

  factory NotificationLocalSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationLocalSettingsModelFromJson(json);
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
