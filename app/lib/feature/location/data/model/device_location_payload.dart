import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_payload.freezed.dart';
part 'device_location_payload.g.dart';

@freezed
abstract class DeviceLocationPayload with _$DeviceLocationPayload {
  @JsonSerializable(includeIfNull: false)
  const factory({
    required String region,
    String? city,
    @JsonKey(name: 'tsunamiForecastRegion')
    String? tsunamiForecastRegion,
  }) = _DeviceLocationPayload;

  factory fromJson(Map<String, dynamic> json) =>
      _$DeviceLocationPayloadFromJson(json);
}
