// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_download_service_unavailable.freezed.dart';
part 'replay_download_service_unavailable.g.dart';

@Freezed()
abstract class ReplayDownloadServiceUnavailable
    with _$ReplayDownloadServiceUnavailable {
  const factory ReplayDownloadServiceUnavailable({
    required dynamic code,
    required String message,
  }) = _ReplayDownloadServiceUnavailable;

  factory ReplayDownloadServiceUnavailable.fromJson(
    Map<String, Object?> json,
  ) => _$ReplayDownloadServiceUnavailableFromJson(json);
}
