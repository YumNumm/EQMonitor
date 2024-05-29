import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/components/core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_remote_settings_state.freezed.dart';
part 'notification_remote_settings_state.g.dart';

@freezed
class NotificationRemoteSettingsState with _$NotificationRemoteSettingsState {
  const factory NotificationRemoteSettingsState({
    required NotificationRemoteSettingsEew eew,
    required NotificationRemoteSettingsEarthquake earthquake,
  }) = _NotificationRemoteSettingsState;

  factory NotificationRemoteSettingsState.fromJson(Map<String, dynamic> json) =>
      _$NotificationRemoteSettingsStateFromJson(json);
}

@freezed
class NotificationRemoteSettingsEew with _$NotificationRemoteSettingsEew {
  const factory NotificationRemoteSettingsEew({
    required JmaForecastIntensity? global,
    required List<NotificationRemoteSettingsEewRegion> regions,
  }) = _NotificationRemoteSettingsEew;

  factory NotificationRemoteSettingsEew.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NotificationRemoteSettingsEewFromJson(json);
}

@freezed
class NotificationRemoteSettingsEewRegion
    with _$NotificationRemoteSettingsEewRegion {
  const factory NotificationRemoteSettingsEewRegion({
    required int regionId,
    required JmaForecastIntensity minJmaIntensity,
    required String name,
  }) = _NotificationRemoteSettingsEewRegion;

  factory NotificationRemoteSettingsEewRegion.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NotificationRemoteSettingsEewRegionFromJson(json);
}

@freezed
class NotificationRemoteSettingsEarthquake
    with _$NotificationRemoteSettingsEarthquake {
  const factory NotificationRemoteSettingsEarthquake({
    required JmaForecastIntensity? global,
    required List<NotificationRemoteSettingsEarthquakeRegion> regions,
  }) = _NotificationRemoteSettingsEarthquake;

  factory NotificationRemoteSettingsEarthquake.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NotificationRemoteSettingsEarthquakeFromJson(json);
}

@freezed
class NotificationRemoteSettingsEarthquakeRegion
    with _$NotificationRemoteSettingsEarthquakeRegion {
  const factory NotificationRemoteSettingsEarthquakeRegion({
    required int regionId,
    required JmaForecastIntensity minJmaIntensity,
    required String name,
  }) = _NotificationRemoteSettingsEarthquakeRegion;

  factory NotificationRemoteSettingsEarthquakeRegion.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NotificationRemoteSettingsEarthquakeRegionFromJson(json);
}
