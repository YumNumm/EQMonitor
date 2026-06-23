// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_sub_region_response.freezed.dart';
part 'shake_detection_sub_region_response.g.dart';

@Freezed()
abstract class ShakeDetectionSubRegionResponse
    with _$ShakeDetectionSubRegionResponse {
  const factory ShakeDetectionSubRegionResponse({
    required String id,

    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,
  }) = _ShakeDetectionSubRegionResponse;

  factory ShakeDetectionSubRegionResponse.fromJson(Map<String, Object?> json) =>
      _$ShakeDetectionSubRegionResponseFromJson(json);
}
