// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'regions.freezed.dart';
part 'regions.g.dart';

@Freezed()
abstract class Regions with _$Regions {
  const factory Regions({
    required String code,
    required String name,
    required String intensity,
  }) = _Regions;
  
  factory Regions.fromJson(Map<String, Object?> json) => _$RegionsFromJson(json);
}
