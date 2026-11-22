import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_state.freezed.dart';

@freezed
abstract class const ReplayState._() with _$ReplayState {
  const factory({
    required ReplayFile file,
    required String fileName,
    required int currentIndex,
    required DateTime currentTime,
    required bool isPlaying,
    required double playbackSpeed,
  }) = _ReplayState;

  static const maxTickInterval = Duration(seconds: 1);

  List<ReplayData> get frames => file.data;

  DateTime get startTime => frames.first.time;

  DateTime get endTime => frames.last.time;

  Duration get duration => endTime.difference(startTime);

  Duration get elapsed => currentTime.difference(startTime);

  bool get isAtEnd => !currentTime.isBefore(endTime);

  DateTime clampTime(DateTime time) => time.isBefore(startTime)
      ? startTime
      : time.isAfter(endTime)
      ? endTime
      : time;

  /// [time] 以前で最後のフレームの位置。
  int indexAt(DateTime time) {
    var low = 0;
    var high = frames.length - 1;
    while (low < high) {
      final mid = (low + high + 1) ~/ 2;
      if (frames[mid].time.isAfter(time)) {
        high = mid - 1;
      } else {
        low = mid;
      }
    }
    return low;
  }

  /// [time] ちょうどに記録された強震モニタの震度画像。
  Uint8List? shindoImageAt(DateTime time) {
    for (var index = indexAt(time); index >= 0; index--) {
      final frame = frames[index];
      if (!frame.time.isAtSameMomentAs(time)) {
        return null;
      }
      if (frame case KyoshinMonitorImageReplayData(:final images)) {
        final image = images[ImageType.shindo];
        return image == null ? null : Uint8List.fromList(image);
      }
    }
    return null;
  }

  /// 次に再生位置を進める時刻。フレームが途切れても [maxTickInterval] ごとに時計を進める。
  DateTime? nextTickTime() {
    if (isAtEnd) {
      return null;
    }
    final limit = currentTime.add(maxTickInterval);
    final nextIndex = currentIndex + 1;
    final nextFrameTime = nextIndex < frames.length
        ? frames[nextIndex].time
        : endTime;
    final candidate = nextFrameTime.isAfter(limit) ? limit : nextFrameTime;
    return clampTime(
      candidate.isAfter(currentTime) ? candidate : currentTime,
    );
  }
}
