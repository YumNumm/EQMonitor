// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_damage_scale.dart';
import 'catalog_hypocenter.dart';
import 'catalog_link.dart';
import 'catalog_station_record.dart';
import 'catalog_tsunami_scale.dart';

part 'catalog.freezed.dart';
part 'catalog.g.dart';

/// 震度データベースZIPカタログ由来の詳細情報（datasource=JMA_INTENSITY_DATABASEまたはXMLとの結合時のみ出現）
@Freezed()
abstract class Catalog with _$Catalog {
  const factory Catalog({
    required List<CatalogHypocenter> hypocenters,
    @JsonKey(name: 'station_records')
    required List<CatalogStationRecord> stationRecords,
    @JsonKey(includeIfNull: false,name: 'damage_scale')
    CatalogDamageScale? damageScale,
    @JsonKey(includeIfNull: false,name: 'tsunami_scale')
    CatalogTsunamiScale? tsunamiScale,
    @JsonKey(includeIfNull: false)
    CatalogLink? link,
  }) = _Catalog;

  factory Catalog.fromJson(Map<String, Object?> json) => _$CatalogFromJson(json);
}
