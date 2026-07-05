// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_station_max_acceleration.freezed.dart';
part 'catalog_station_max_acceleration.g.dart';

/// 最大加速度（gal）。いずれかの成分が存在する場合のみ出現する
@Freezed()
abstract class CatalogStationMaxAcceleration with _$CatalogStationMaxAcceleration {
  const factory CatalogStationMaxAcceleration({
    @JsonKey(includeIfNull: false,name: 'synthesized_gal')
    num? synthesizedGal,
    @JsonKey(includeIfNull: false,name: 'ns_gal')
    num? nsGal,
    @JsonKey(includeIfNull: false,name: 'ew_gal')
    num? ewGal,
    @JsonKey(includeIfNull: false,name: 'ud_gal')
    num? udGal,
  }) = _CatalogStationMaxAcceleration;

  factory CatalogStationMaxAcceleration.fromJson(Map<String, Object?> json) => _$CatalogStationMaxAccelerationFromJson(json);
}
