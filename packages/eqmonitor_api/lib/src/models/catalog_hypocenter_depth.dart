// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_hypocenter_depth.freezed.dart';
part 'catalog_hypocenter_depth.g.dart';

@Freezed()
abstract class CatalogHypocenterDepth with _$CatalogHypocenterDepth {
  const factory CatalogHypocenterDepth({
    /// 震源の深さ(km)
    required num value,

    /// 深さフリー条件（震源評価コード1）で計算された震源かどうか
    @JsonKey(name: 'is_free')
    required bool isFree,

    /// 震源の深さの標準誤差(km)
    @JsonKey(includeIfNull: false)
    num? stderr,
  }) = _CatalogHypocenterDepth;

  factory CatalogHypocenterDepth.fromJson(Map<String, Object?> json) => _$CatalogHypocenterDepthFromJson(json);
}
