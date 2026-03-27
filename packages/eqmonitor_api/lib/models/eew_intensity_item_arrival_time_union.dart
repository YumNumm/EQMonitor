// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'eew_intensity_item_arrival_time_union.freezed.dart';
part 'eew_intensity_item_arrival_time_union.g.dart';

@Freezed()
sealed class EewIntensityItemArrivalTimeUnion with _$EewIntensityItemArrivalTimeUnion {
  @JsonSerializable()
  const factory EewIntensityItemArrivalTimeUnion.eewIntensityRegionArrivalTimeTime({
    required dynamic type,
    required DateTime value,
  }) = EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeTime;
  
  @JsonSerializable()
  const factory EewIntensityItemArrivalTimeUnion.eewIntensityRegionArrivalTimeArrived({
    required dynamic type,
  }) = EewIntensityItemArrivalTimeUnionEewIntensityRegionArrivalTimeArrived;
  

  factory EewIntensityItemArrivalTimeUnion.fromJson(Map<String, Object?> json) =>
      // TODO: No discriminator in OpenAPI spec - you must implement this manually.
      //
      // Inspect the JSON and return the matching variant. Each variant has a fromJson:
      //   EewIntensityItemArrivalTimeUnionVariantName.fromJson(json)
      //
      // Example pattern (check for unique fields):
      //   json.containsKey('uniqueFieldA') ? EewIntensityItemArrivalTimeUnionTypeA.fromJson(json) :
      //   json.containsKey('uniqueFieldB') ? EewIntensityItemArrivalTimeUnionTypeB.fromJson(json) :
      //   EewIntensityItemArrivalTimeUnionDefault.fromJson(json);
      //
      // IMPORTANT: Keep the => arrow syntax. Converting to a { } body will cause
      // freezed to skip generating toJson/fromJson for this class.
      throw UnimplementedError();

}
