import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_local_settings/data/jma_intensity_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_local_settings_model.freezed.dart';
part 'notification_local_settings_model.g.dart';

@freezed
abstract class NotificationLocalSettingsModel
    with _$NotificationLocalSettingsModel {
  const factory NotificationLocalSettingsModel({
    @Default(EewSettings()) EewSettings eew,
    @Default(EarthquakeSettings()) EarthquakeSettings earthquake,
  }) = _NotificationLocalSettingsModel;

  factory NotificationLocalSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationLocalSettingsModelFromJson(json);
}

@freezed
abstract class EewSettings with _$EewSettings {
  const factory EewSettings({
    @Default(null)
    @JmaIntensityJsonConverter()
    JmaIntensity? emergencyIntensity,
    @Default(null) @JmaIntensityJsonConverter() JmaIntensity? silentIntensity,
    @Default([]) List<Region> regions,
  }) = _EewSettings;

  factory EewSettings.fromJson(Map<String, dynamic> json) =>
      _$EewSettingsFromJson(json);
}

@freezed
abstract class EarthquakeSettings with _$EarthquakeSettings {
  const factory EarthquakeSettings({
    @Default(null)
    @JmaIntensityJsonConverter()
    JmaIntensity? emergencyIntensity,
    @Default(null) @JmaIntensityJsonConverter() JmaIntensity? silentIntensity,
    @Default([]) List<Region> regions,
  }) = _EarthquakeSettings;

  factory EarthquakeSettings.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeSettingsFromJson(json);
}

@freezed
abstract class Region with _$Region {
  const factory Region({
    required String code,
    required String name,
    @JmaIntensityJsonConverter() required JmaIntensity emergencyIntensity,
    @JmaIntensityJsonConverter() required JmaIntensity silentIntensity,
    required bool isMain,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}
