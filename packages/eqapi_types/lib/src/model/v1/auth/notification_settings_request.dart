import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_request.freezed.dart';
part 'notification_settings_request.g.dart';

@freezed
class NotificationSettingsRequest with _$NotificationSettingsRequest {
  const factory NotificationSettingsRequest({
    NotificationSettingsGlobal? global,
    List<NotificationSettingsRegion>? regions,
  }) = _NotificationSettingsRequest;

  factory NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsRequestFromJson(json);
}

@freezed
class NotificationSettingsGlobal with _$NotificationSettingsGlobal {
  const factory NotificationSettingsGlobal({
    required JmaForecastIntensity minJmaIntensity,
  }) = _NotificationSettingsGlobal;

  factory NotificationSettingsGlobal.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsGlobalFromJson(json);
}

@freezed
class NotificationSettingsRegion with _$NotificationSettingsRegion {
  const factory NotificationSettingsRegion({
    required int code,
    required JmaForecastIntensity minIntensity,
  }) = _NotificationSettingsRegion;

  factory NotificationSettingsRegion.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsRegionFromJson(json);
}
