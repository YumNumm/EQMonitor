// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_replay_file_download_url_response.freezed.dart';
part 'admin_replay_file_download_url_response.g.dart';

@Freezed()
abstract class AdminReplayFileDownloadUrlResponse
    with _$AdminReplayFileDownloadUrlResponse {
  const factory AdminReplayFileDownloadUrlResponse({required String url}) =
      _AdminReplayFileDownloadUrlResponse;

  factory AdminReplayFileDownloadUrlResponse.fromJson(
    Map<String, Object?> json,
  ) => _$AdminReplayFileDownloadUrlResponseFromJson(json);
}
