// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'environment.dart';

part 'target_union.freezed.dart';
part 'target_union.g.dart';

@Freezed()
sealed class TargetUnion with _$TargetUnion {
  @JsonSerializable()
  const factory TargetUnion.variant1({
    required dynamic type,
    required String deviceId,
  }) = TargetUnionVariant1;
  
  @JsonSerializable()
  const factory TargetUnion.variant2({
    required dynamic type,
    required String token,
    required Environment environment,
  }) = TargetUnionVariant2;
  

  factory TargetUnion.fromJson(Map<String, Object?> json) =>
      // TODO: No discriminator in OpenAPI spec - you must implement this manually.
      //
      // Inspect the JSON and return the matching variant. Each variant has a fromJson:
      //   TargetUnionVariantName.fromJson(json)
      //
      // Example pattern (check for unique fields):
      //   json.containsKey('uniqueFieldA') ? TargetUnionTypeA.fromJson(json) :
      //   json.containsKey('uniqueFieldB') ? TargetUnionTypeB.fromJson(json) :
      //   TargetUnionDefault.fromJson(json);
      //
      // IMPORTANT: Keep the => arrow syntax. Converting to a { } body will cause
      // freezed to skip generating toJson/fromJson for this class.
      throw UnimplementedError();

}
