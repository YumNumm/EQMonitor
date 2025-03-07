// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_converter_internal/dmdata/converter.dart';

part 'tsunami.freezed.dart';
part 'tsunami.g.dart';

@freezed
class TsunamiParameter with _$TsunamiParameter {
  const factory TsunamiParameter({
    required String responseId,
    required DateTime responseTime,
    required String status,
    required DateTime changeTime,
    required String version,
    required List<TsunamiParameterItem> items,
  }) = _TsunamiParameter;

  factory TsunamiParameter.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterFromJson(json);
}

@freezed
class TsunamiParameterItem with _$TsunamiParameterItem {
  const factory TsunamiParameterItem({
    required String? area,
    required String prefecture,
    required String code,
    required String name,
    required String kana,
    required String owner,
    @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
    required double latitude,
    @JsonKey(fromJson: doubleFromString, toJson: doubleToString)
    required double longitude,
  }) = _TsunamiParameterItem;

  factory TsunamiParameterItem.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterItemFromJson(json);
}
