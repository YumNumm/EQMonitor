// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'catalog_period_kind.dart';

part 'catalog_period_value.freezed.dart';
part 'catalog_period_value.g.dart';

@Freezed()
abstract class CatalogPeriodValue with _$CatalogPeriodValue {
  const factory CatalogPeriodValue({
    required CatalogPeriodKind kind,

    /// flagのみ記録され数値が欠測の行が実データに存在するため省略される場合がある
    @JsonKey(includeIfNull: false)
    num? value,
  }) = _CatalogPeriodValue;

  factory CatalogPeriodValue.fromJson(Map<String, Object?> json) => _$CatalogPeriodValueFromJson(json);
}
