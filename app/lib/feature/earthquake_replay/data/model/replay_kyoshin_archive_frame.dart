import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_kyoshin_archive_frame.freezed.dart';

@freezed
sealed class ReplayKyoshinArchiveFrame with _$ReplayKyoshinArchiveFrame {
  const factory available({
    required Uint8List image,
    required Map<DateTime, Uint8List> baselineImages,
  }) = ReplayKyoshinArchiveFrameAvailable;

  const factory unavailable() = ReplayKyoshinArchiveFrameUnavailable;

  const factory purged() = ReplayKyoshinArchiveFramePurged;
}
