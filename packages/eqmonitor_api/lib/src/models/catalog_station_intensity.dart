// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_intensity_class.dart';

part 'catalog_station_intensity.freezed.dart';
part 'catalog_station_intensity.g.dart';

@Freezed()
abstract class CatalogStationIntensity with _$CatalogStationIntensity {
  const factory CatalogStationIntensity({
    /// The name has been replaced because it contains a keyword. Original name: `class`.
    @JsonKey(name: 'class')
    required CatalogIntensityClass classValue,

    /// 計測震度
    @JsonKey(includeIfNull: false)
    num? instrumental,
  }) = _CatalogStationIntensity;

  factory CatalogStationIntensity.fromJson(Map<String, Object?> json) => _$CatalogStationIntensityFromJson(json);
}
