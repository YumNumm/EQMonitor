import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_state.freezed.dart';

@freezed
abstract class const ReplayState._() with _$ReplayState {
  const factory({
    required ReplaySource source,

    /// [currentTime] までに通過した [frames] の数。
    required int passedFrameCount,
    required DateTime currentTime,
    required bool isPlaying,
    required double playbackSpeed,
  }) = _ReplayState;

  static const maxTickInterval = Duration(seconds: 1);

  List<ReplayData> get frames => source.frames;

  DateTime get startTime => source.startTime;

  DateTime get endTime => source.endTime;

  Duration get duration => endTime.difference(startTime);

  Duration get elapsed => currentTime.difference(startTime);

  bool get isAtEnd => !currentTime.isBefore(endTime);

  DateTime clampTime(DateTime time) => time.isBefore(startTime)
      ? startTime
      : time.isAfter(endTime)
      ? endTime
      : time;

  int passedFrameCountAt(DateTime time) {
    var low = 0;
    var high = frames.length;
    while (low < high) {
      final mid = (low + high) ~/ 2;
      if (frames[mid].time.isAfter(time)) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }
    return low;
  }

  /// [time] ちょうどに記録された強震モニタの震度画像。
  Uint8List? recordedShindoImageAt(DateTime time) {
    for (var index = passedFrameCountAt(time) - 1; index >= 0; index--) {
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
    final nextFrameTime = passedFrameCount < frames.length
        ? frames[passedFrameCount].time
        : endTime;
    final candidate = nextFrameTime.isAfter(limit) ? limit : nextFrameTime;
    return clampTime(
      candidate.isAfter(currentTime) ? candidate : currentTime,
    );
  }
}
