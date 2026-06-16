// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_estimation_first_height.dart';
import 'tsunami_estimation_max_height.dart';

part 'estimation.freezed.dart';
part 'estimation.g.dart';

@Freezed()
abstract class Estimation with _$Estimation {
  const factory Estimation({
    @JsonKey(includeIfNull: false,name: 'first_height')
    TsunamiEstimationFirstHeight? firstHeight,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiEstimationMaxHeight? maxHeight,
  }) = _Estimation;
  
  factory Estimation.fromJson(Map<String, Object?> json) => _$EstimationFromJson(json);
}
