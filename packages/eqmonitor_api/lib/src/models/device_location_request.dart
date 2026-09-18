// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_request.freezed.dart';
part 'device_location_request.g.dart';

@Freezed()
abstract class DeviceLocationRequest with _$DeviceLocationRequest {
  const factory DeviceLocationRequest({
    /// 気象庁防災情報XMLコード表 AreaForecastLocalE（地震情報／細分区域）のコード
    required String region,

    /// 気象庁防災情報XMLコード表 AreaInformationCity（気象・地震・火山情報／市町村等）のコード
    @JsonKey(includeIfNull: false)
    String? city,

    /// 気象庁防災情報XMLコード表 AreaTsunami（津波予報区）のコード
    @JsonKey(includeIfNull: false)
    String? tsunamiForecastRegion,
  }) = _DeviceLocationRequest;
  
  factory DeviceLocationRequest.fromJson(Map<String, Object?> json) => _$DeviceLocationRequestFromJson(json);
}
