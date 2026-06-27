// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'replay_file.dart';
import 'replay_file_trigger.dart';

part 'admin_replay_file_detail_response_item.freezed.dart';
part 'admin_replay_file_detail_response_item.g.dart';

@Freezed()
abstract class AdminReplayFileDetailResponseItem with _$AdminReplayFileDetailResponseItem {
  const factory AdminReplayFileDetailResponseItem({
    required String id,
    required String startTime,
    required String endTime,
    required String objectKey,
    @JsonKey(includeIfNull: true)
    required num? fileSizeBytes,
    required String createdAt,
    @JsonKey(includeIfNull: true)
    required String? downloadUrl,
    required List<ReplayFileTrigger> triggers,
  }) = _AdminReplayFileDetailResponseItem;
  
  factory AdminReplayFileDetailResponseItem.fromJson(Map<String, Object?> json) => _$AdminReplayFileDetailResponseItemFromJson(json);
}
