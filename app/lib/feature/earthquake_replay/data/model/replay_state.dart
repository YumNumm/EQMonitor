import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_state.freezed.dart';

@freezed
abstract class ReplayState with _$ReplayState {
  const factory({
    required ReplayFile file,
    required String fileName,
    required int currentIndex,
    required bool isPlaying,
    required double playbackSpeed,
  }) = _ReplayState;

  const new _();

  /// 総フレーム数
  int get totalFrames => file.data.length;

  /// 現在のフレームの時刻
  DateTime get currentTime => file.data[currentIndex].time;

  /// 開始時刻
  DateTime get startTime => file.header.startTime;

  /// 終了時刻
  DateTime get endTime => file.header.endTime;

  /// 再生位置（0.0 ~ 1.0）
  double get progress => totalFrames > 1 ? currentIndex / (totalFrames - 1) : 0;
}
