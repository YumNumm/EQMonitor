// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_hypocenter_record_type.dart';

part 'catalog_hypocenter.freezed.dart';
part 'catalog_hypocenter.g.dart';

@Freezed()
abstract class CatalogHypocenter with _$CatalogHypocenter {
  const factory CatalogHypocenter({
    /// 0が代表震源
    required int seq,
    @JsonKey(name: 'record_type')
    required CatalogHypocenterRecordType recordType,
    @JsonKey(includeIfNull: true,name: 'origin_time')
    required DateTime? originTime,
    @JsonKey(includeIfNull: true)
    required num? latitude,
    @JsonKey(includeIfNull: true)
    required num? longitude,
    @JsonKey(includeIfNull: true,name: 'depth_km')
    required num? depthKm,
    @JsonKey(name: 'depth_is_free')
    required bool depthIsFree,
    @JsonKey(includeIfNull: true)
    required num? magnitude1,
    @JsonKey(includeIfNull: true,name: 'magnitude1_type')
    required String? magnitude1Type,
    @JsonKey(includeIfNull: true)
    required num? magnitude2,
    @JsonKey(includeIfNull: true,name: 'magnitude2_type')
    required String? magnitude2Type,

    /// 歴史的階級(L/S/M/R/F/X)を含む生の震度階級コード
    @JsonKey(includeIfNull: true,name: 'max_intensity_raw')
    required String? maxIntensityRaw,
    @JsonKey(includeIfNull: true,name: 'damage_scale')
    required String? damageScale,
    @JsonKey(includeIfNull: true,name: 'tsunami_scale')
    required String? tsunamiScale,
    @JsonKey(includeIfNull: true,name: 'determination_flag')
    required String? determinationFlag,
  }) = _CatalogHypocenter;
  
  factory CatalogHypocenter.fromJson(Map<String, Object?> json) => _$CatalogHypocenterFromJson(json);
}
