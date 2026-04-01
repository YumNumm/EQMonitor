// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_auxiliary.freezed.dart';
part 'hypocenter_auxiliary.g.dart';

/// 震源の補助情報（方角・距離等、津波電文で使用）
@Freezed()
abstract class HypocenterAuxiliary with _$HypocenterAuxiliary {
  const factory HypocenterAuxiliary({
    required String code,
    required String name,
    required String direction,
    @JsonKey(name: 'distance_km')
    required num distanceKm,
  }) = _HypocenterAuxiliary;
  
  factory HypocenterAuxiliary.fromJson(Map<String, Object?> json) => _$HypocenterAuxiliaryFromJson(json);
}
