// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_item_with_relations.dart';

part 'eew_list_response.freezed.dart';
part 'eew_list_response.g.dart';

@Freezed()
abstract class EewListResponse with _$EewListResponse {
  const factory EewListResponse({
    required List<EewItemWithRelations> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_token')
    String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false,name: 'next_pooling')
    String? nextPooling,
  }) = _EewListResponse;
  
  factory EewListResponse.fromJson(Map<String, Object?> json) => _$EewListResponseFromJson(json);
}
