import 'dart:async';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_parser_provider.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_notifier.g.dart';

@riverpod
class ReplayNotifier extends _$ReplayNotifier {
  Timer? _playbackTimer;

  @override
  ReplayState? build() {
    ref.onDispose(_stopPlaybackTimer);
    return null;
  }

  /// リプレイファイルを読み込む
  Future<void> loadFile({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final parser = ReplayDataParser();
    final file = parser.parse(bytes);
    state = ReplayState(
      file: file,
      fileName: fileName,
      currentIndex: 0,
      isPlaying: false,
      playbackSpeed: 1,
    );
    await _parseCurrentFrame();
  }

  /// 再生開始
  void play() {
    if (state == null) {
      return;
    }
    state = state!.copyWith(isPlaying: true);
    _startPlaybackTimer();
  }

  /// 一時停止
  void pause() {
    if (state == null) {
      return;
    }
    _stopPlaybackTimer();
    state = state!.copyWith(isPlaying: false);
  }

  /// 再生/一時停止を切り替え
  void togglePlayPause() {
    if (state == null) {
      return;
    }
    if (state!.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// シーク（フレームインデックスを直接設定）
  Future<void> seekToIndex(int index) async {
    if (state == null) {
      return;
    }
    final clampedIndex = index.clamp(0, state!.totalFrames - 1);
    state = state!.copyWith(currentIndex: clampedIndex);
    await _parseCurrentFrame();
  }

  /// シーク（進捗率で設定: 0.0 ~ 1.0）
  Future<void> seekToProgress(double progress) async {
    if (state == null) {
      return;
    }
    final index = (progress * (state!.totalFrames - 1)).round();
    await seekToIndex(index);
  }

  /// 再生速度を変更
  void setPlaybackSpeed(double speed) {
    if (state == null) {
      return;
    }
    state = state!.copyWith(playbackSpeed: speed);
    if (state!.isPlaying) {
      _stopPlaybackTimer();
      _startPlaybackTimer();
    }
  }

  /// データオーバーレイの表示を切り替え
  void toggleDataOverlay() {
    if (state == null) {
      return;
    }
    state = state!.copyWith(showDataOverlay: !state!.showDataOverlay);
  }

  /// 次のフレームに進む
  Future<void> nextFrame() async {
    if (state == null) {
      return;
    }
    if (state!.currentIndex >= state!.totalFrames - 1) {
      pause();
      return;
    }
    state = state!.copyWith(currentIndex: state!.currentIndex + 1);
    await _parseCurrentFrame();
  }

  /// 前のフレームに戻る
  Future<void> previousFrame() async {
    if (state == null) {
      return;
    }
    if (state!.currentIndex <= 0) {
      return;
    }
    state = state!.copyWith(currentIndex: state!.currentIndex - 1);
    await _parseCurrentFrame();
  }

  void _startPlaybackTimer() {
    _stopPlaybackTimer();
    if (state == null) {
      return;
    }

    // 次のフレームまでの時間を計算
    final interval = _calculateNextFrameInterval();
    if (interval == null) {
      return;
    }

    _playbackTimer = Timer(interval, () async {
      await nextFrame();
      if (state?.isPlaying ?? false) {
        _startPlaybackTimer();
      }
    });
  }

  Duration? _calculateNextFrameInterval() {
    if (state == null || state!.currentIndex >= state!.totalFrames - 1) {
      return null;
    }

    final currentTime = state!.file.data[state!.currentIndex].time;
    final nextTime = state!.file.data[state!.currentIndex + 1].time;
    final diff = nextTime.difference(currentTime);

    // 再生速度を適用
    final adjustedMs = (diff.inMilliseconds / state!.playbackSpeed).round();
    return Duration(milliseconds: adjustedMs.clamp(16, 10000));
  }

  void _stopPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
  }

  /// 現在のフレームを解析
  Future<void> _parseCurrentFrame() async {
    if (state == null) {
      return;
    }

    final currentData = state!.file.data[state!.currentIndex];

    // KyoshinMonitorImageReplayDataの場合のみ解析
    if (currentData is KyoshinMonitorImageReplayData) {
      final points = await _parseKyoshinImage(currentData);
      state = state!.copyWith(currentPoints: points);
    }
  }

  Future<List<KyoshinMonitorImageParseObservationPoint>?> _parseKyoshinImage(
    KyoshinMonitorImageReplayData data,
  ) async {
    // 震度(shindo)画像を優先して取得
    final imageData = data.images[ImageType.shindo];
    if (imageData == null) {
      return null;
    }

    final imageParser = ref.read(kyoshinMonitorImageParserProvider);
    final points = ref.read(kyoshinMonitorObservationPointsProvider);
    final observationPoints = ref.read(kyoshinObservationPointsProvider);

    final result = await imageParser.parseGif(
      gifImage: imageData,
      points: points,
    );

    final results = <KyoshinMonitorImageParseObservationPoint>[];
    for (var i = 0; i < result.length; i++) {
      final element = result[i];
      if (element is KyoshinMonitorImageParseObservationSuccess) {
        results.add(
          KyoshinMonitorImageParseObservationPoint(
            point: observationPoints.points[i],
            observation: element.point,
          ),
        );
      }
    }

    return results;
  }
}
