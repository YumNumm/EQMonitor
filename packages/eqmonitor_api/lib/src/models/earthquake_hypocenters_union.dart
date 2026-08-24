// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'catalog_hypocenter.dart';
import 'catalog_hypocenter_record_type.dart';
import 'hypocenter.dart';

part 'earthquake_hypocenters_union.freezed.dart';
part 'earthquake_hypocenters_union.g.dart';

@Freezed()
sealed class EarthquakeHypocentersUnion with _$EarthquakeHypocentersUnion {
  @JsonSerializable()
  const factory EarthquakeHypocentersUnion.variant1({
    /// const: "JMA_DISASTER_INFORMATION_XML"
    required String datasource,
    @JsonKey(name: 'reported_at')
    required DateTime reportedAt,
    @JsonKey(includeIfNull: true,name: 'source_telegram_id')
    required String? sourceTelegramId,
    required Hypocenter hypocenter,
  }) = EarthquakeHypocentersUnionVariant1;

  @JsonSerializable()
  const factory EarthquakeHypocentersUnion.variant2({
    /// const: "JMA_INTENSITY_DATABASE"
    required String datasource,
    required int seq,
    @JsonKey(name: 'record_type')
    required CatalogHypocenterRecordType recordType,
    required Hypocenter hypocenter,
    required CatalogHypocenter catalog,
  }) = EarthquakeHypocentersUnionVariant2;


  factory EarthquakeHypocentersUnion.fromJson(Map<String, Object?> json) =>
      switch (json['datasource']) {
        'JMA_DISASTER_INFORMATION_XML' =>
          EarthquakeHypocentersUnionVariant1.fromJson(json),
        'JMA_INTENSITY_DATABASE' =>
          EarthquakeHypocentersUnionVariant2.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'datasource',
          'Unknown EarthquakeHypocentersUnion datasource',
        ),
      };

}
