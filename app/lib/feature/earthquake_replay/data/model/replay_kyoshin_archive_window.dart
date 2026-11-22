import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_kyoshin_archive_window.freezed.dart';

@freezed
abstract class ReplayKyoshinArchiveWindow with _$ReplayKyoshinArchiveWindow {
  const factory({
    required DateTime startTime,
    required DateTime endTime,
    required DateTime originTime,
    required bool isOriginTimeApproximate,
  }) = _ReplayKyoshinArchiveWindow;
}
