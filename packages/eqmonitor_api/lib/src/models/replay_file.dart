// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_file.freezed.dart';
part 'replay_file.g.dart';

@Freezed()
abstract class ReplayFile with _$ReplayFile {
  const factory ReplayFile({
    required String id,
    required String startTime,
    required String endTime,
    required String objectKey,
    @JsonKey(includeIfNull: true)
    required num? fileSizeBytes,
    required String createdAt,
    @JsonKey(includeIfNull: true)
    required String? downloadUrl,
  }) = _ReplayFile;
  
  factory ReplayFile.fromJson(Map<String, Object?> json) => _$ReplayFileFromJson(json);
}
