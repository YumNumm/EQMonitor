// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_converter_internal/dmdata/common.dart';
import 'package:jma_parameter_converter_internal/dmdata/converter.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

/// Parameter Earthquake station v2
@freezed
class EarthquakeParameter with _$EarthquakeParameter {
  const factory EarthquakeParameter({
    required String responseId,
    required DateTime responseTime,
    required String status,
    required DateTime changeTime,
    required String version,
    required List<EarthquakeParmaeterItem> items,
  }) = _EarthquakeParameter;

  factory EarthquakeParameter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParameterFromJson(json);
}

@freezed
class EarthquakeParmaeterItem with _$EarthquakeParmaeterItem {
  const factory EarthquakeParmaeterItem({
    required ParameterRegion region,
    required ParameterCity city,
    required String noCode,
    required String code,
    required String name,
    required String kana,
    required String status,
    required String owner,
    @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
    required double latitude,
    @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
    required double longitude,
  }) = _EarthquakeParmaeterItem;

  factory EarthquakeParmaeterItem.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParmaeterItemFromJson(json);
}
