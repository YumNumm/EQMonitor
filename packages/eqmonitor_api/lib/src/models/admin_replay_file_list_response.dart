// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'items2.dart';

part 'admin_replay_file_list_response.freezed.dart';
part 'admin_replay_file_list_response.g.dart';

@Freezed()
abstract class AdminReplayFileListResponse with _$AdminReplayFileListResponse {
  const factory AdminReplayFileListResponse({
    required List<Items2> items,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,

    /// カーソル情報（base64エンコード）
    @JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling,
  }) = _AdminReplayFileListResponse;

  factory AdminReplayFileListResponse.fromJson(Map<String, Object?> json) =>
      _$AdminReplayFileListResponseFromJson(json);
}
