// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';

part 'jma_code_table_item.freezed.dart';
part 'jma_code_table_item.g.dart';

@Freezed()
abstract class JmaCodeTableItem with _$JmaCodeTableItem {
  const factory JmaCodeTableItem({
    required String code,
    required LocalizedName name,
  }) = _JmaCodeTableItem;

  factory JmaCodeTableItem.fromJson(Map<String, Object?> json) => _$JmaCodeTableItemFromJson(json);
}
