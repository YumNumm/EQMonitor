// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_response.freezed.dart';
part 'device_location_response.g.dart';

@Freezed()
abstract class DeviceLocationResponse with _$DeviceLocationResponse {
  const factory DeviceLocationResponse({
    /// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
    required String region,

    /// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
    @JsonKey(includeIfNull: true)
    required String? city,

    /// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
    @JsonKey(includeIfNull: true)
    required String? tsunamiForecastRegion,
  }) = _DeviceLocationResponse;
  
  factory DeviceLocationResponse.fromJson(Map<String, Object?> json) => _$DeviceLocationResponseFromJson(json);
}
