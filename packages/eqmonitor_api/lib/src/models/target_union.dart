// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'environment.dart';

part 'target_union.freezed.dart';
part 'target_union.g.dart';

@Freezed()
sealed class TargetUnion with _$TargetUnion {
  @JsonSerializable()
  const factory TargetUnion.variant1({
    required String type,
    required String deviceId,
  }) = TargetUnionVariant1;
  
  @JsonSerializable()
  const factory TargetUnion.variant2({
    required String type,
    required String token,
    required Environment environment,
  }) = TargetUnionVariant2;
  

  factory TargetUnion.fromJson(Map<String, Object?> json) =>
      switch (json['type']) {
        'device_id' => TargetUnionVariant1.fromJson(json),
        'push_to_start_token' => TargetUnionVariant2.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown TargetUnion type',
        ),
      };

}
