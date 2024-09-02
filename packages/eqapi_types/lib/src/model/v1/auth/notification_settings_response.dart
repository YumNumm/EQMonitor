import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_response.freezed.dart';
part 'notification_settings_response.g.dart';

@freezed
class NotificationSettingsResponse with _$NotificationSettingsResponse {
  const factory NotificationSettingsResponse({
    required List<DevicesEarthquakeSettings> earthquake,
    required List<DevicesEewSettings> eew,
  }) = _NotificationSettingsResponse;

  factory NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsResponseFromJson(json);
}
