import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_state.freezed.dart';

@freezed
abstract class ReplayState with _$ReplayState {
  const factory ReplayState({
    required ReplayFile file,
    required String fileName,
    required int currentIndex,
    required bool isPlaying,
    required double playbackSpeed,
    @Default(false) bool showDataOverlay,
    List<KyoshinMonitorImageParseObservationPoint>? currentPoints,
  }) = _ReplayState;

  const ReplayState._();

  /// 総フレーム数
  int get totalFrames => file.data.length;

  /// 現在のデータを取得
  DateTime get currentTime => file.data[currentIndex].time;

  /// 開始時刻
  DateTime get startTime => file.header.startTime;

  /// 終了時刻
  DateTime get endTime => file.header.endTime;

  /// 再生位置（0.0 ~ 1.0）
  double get progress => totalFrames > 1 ? currentIndex / (totalFrames - 1) : 0;

  /// 現在時刻の前後5秒以内のイベントを取得（画像データを除く）
  List<ReplayData> get recentEvents {
    final current = currentTime;
    const threshold = Duration(seconds: 5);

    return file.data.where((data) {
      if (data is KyoshinMonitorImageReplayData) {
        return false;
      }
      final diff = data.time.difference(current).abs();
      return diff <= threshold;
    }).toList();
  }
}
