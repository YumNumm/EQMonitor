// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_item_with_relations.dart';

part 'eew_latest_response.freezed.dart';
part 'eew_latest_response.g.dart';

@Freezed()
abstract class EewLatestResponse with _$EewLatestResponse {
  const factory EewLatestResponse({
    required List<EewItemWithRelations> items,
  }) = _EewLatestResponse;
  
  factory EewLatestResponse.fromJson(Map<String, Object?> json) => _$EewLatestResponseFromJson(json);
}
