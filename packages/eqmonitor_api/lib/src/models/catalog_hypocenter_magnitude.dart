// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_magnitude_type.dart';

part 'catalog_hypocenter_magnitude.freezed.dart';
part 'catalog_hypocenter_magnitude.g.dart';

@Freezed()
abstract class CatalogHypocenterMagnitude with _$CatalogHypocenterMagnitude {
  const factory CatalogHypocenterMagnitude({
    required CatalogMagnitudeType type,
    required num value,
  }) = _CatalogHypocenterMagnitude;

  factory CatalogHypocenterMagnitude.fromJson(Map<String, Object?> json) => _$CatalogHypocenterMagnitudeFromJson(json);
}
