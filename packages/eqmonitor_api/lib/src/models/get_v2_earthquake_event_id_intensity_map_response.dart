// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_v2_earthquake_event_id_intensity_map_response.freezed.dart';
part 'get_v2_earthquake_event_id_intensity_map_response.g.dart';

@Freezed()
abstract class GetV2EarthquakeEventIdIntensityMapResponse
    with _$GetV2EarthquakeEventIdIntensityMapResponse {
  const factory GetV2EarthquakeEventIdIntensityMapResponse({
    @JsonKey(includeIfNull: true) required String? url,
    @JsonKey(includeIfNull: true, name: 'object_key')
    required String? objectKey,
  }) = _GetV2EarthquakeEventIdIntensityMapResponse;

  factory GetV2EarthquakeEventIdIntensityMapResponse.fromJson(
    Map<String, Object?> json,
  ) => _$GetV2EarthquakeEventIdIntensityMapResponseFromJson(json);
}
