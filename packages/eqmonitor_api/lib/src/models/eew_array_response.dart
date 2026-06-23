// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_item_with_relations.dart';

part 'eew_array_response.freezed.dart';
part 'eew_array_response.g.dart';

@Freezed()
abstract class EewArrayResponse with _$EewArrayResponse {
  const factory EewArrayResponse({
    required List<EewItemWithRelations> items,
  }) = _EewArrayResponse;

  factory EewArrayResponse.fromJson(Map<String, Object?> json) =>
      _$EewArrayResponseFromJson(json);
}
