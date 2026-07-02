import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_notifier.g.dart';

/// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。
@Riverpod(keepAlive: true)
class ReplayNotifier extends _$ReplayNotifier {
  Timer? _playbackTimer;

  @override
  ReplayState? build() {
    ref.onDispose(_stopPlaybackTimer);
    return null;
  }

  /// リプレイファイルを読み込み、再生モードへ入る。
  Future<void> loadFile({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final file = ReplayDataParser().parse(bytes);
    state = ReplayState(
      file: file,
      fileName: fileName,
      currentIndex: 0,
      isPlaying: false,
      playbackSpeed: 1,
    );
    ref.read(appClockProvider.notifier).enterReplay(file.data.first.time);
    unawaited(ref.read(kyoshinMonitorAnalyzerIsolateProvider.future));
    unawaited(ref.read(estimatedIntensityIsolateProvider.future));
    await _rebuildTo(0);
    play();
  }

  void play() {
    final current = state;
    if (current == null) {
      return;
    }
    state = current.copyWith(isPlaying: true);
    _startPlaybackTimer();
  }

  void pause() {
    final current = state;
    if (current == null) {
      return;
    }
    _stopPlaybackTimer();
    state = current.copyWith(isPlaying: false);
  }

  void togglePlayPause() {
    final current = state;
    if (current == null) {
      return;
    }
    if (current.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  /// リプレイを終了し、通常再生（ライブ）へ戻す。
  void exit() {
    _stopPlaybackTimer();
    state = null;
    ref.read(appClockProvider.notifier).returnToRealtime();
    // リプレイ由来のデータを破棄し、ライブ取得を再開させる。
    ref
      ..invalidate(eewProvider, asReload: true)
      ..invalidate(kyoshinMonitorProvider, asReload: true);
  }

  Future<void> seekToIndex(int index) async {
    final current = state;
    if (current == null || current.totalFrames == 0) {
      return;
    }
    final clamped = index.clamp(0, current.totalFrames - 1);
    state = current.copyWith(currentIndex: clamped);
    await _rebuildTo(clamped);
  }

  Future<void> seekToProgress(double progress) async {
    final current = state;
    if (current == null || current.totalFrames == 0) {
      return;
    }
    await seekToIndex((progress * (current.totalFrames - 1)).round());
  }

  void setPlaybackSpeed(double speed) {
    final current = state;
    if (current == null) {
      return;
    }
    state = current.copyWith(playbackSpeed: speed);
    if (current.isPlaying) {
      _stopPlaybackTimer();
      _startPlaybackTimer();
    }
  }

  Future<void> _advanceToNextFrame() async {
    final current = state;
    if (current == null) {
      return;
    }
    if (current.currentIndex >= current.totalFrames - 1) {
      pause();
      return;
    }
    final nextIndex = current.currentIndex + 1;
    state = current.copyWith(currentIndex: nextIndex);
    await _applyFrame(nextIndex);
  }

  void _startPlaybackTimer() {
    _stopPlaybackTimer();
    final interval = _nextFrameInterval();
    if (interval == null) {
      return;
    }
    _playbackTimer = Timer(interval, () async {
      await _advanceToNextFrame();
      if (state?.isPlaying ?? false) {
        _startPlaybackTimer();
      }
    });
  }

  Duration? _nextFrameInterval() {
    final current = state;
    if (current == null || current.currentIndex >= current.totalFrames - 1) {
      return null;
    }
    final diff = current.file.data[current.currentIndex + 1].time.difference(
      current.file.data[current.currentIndex].time,
    );
    final adjustedMs = (diff.inMilliseconds / current.playbackSpeed).round();
    return Duration(milliseconds: adjustedMs.clamp(16, 10000));
  }

  void _stopPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
  }

  /// 単一フレームを適用する（順次再生用）。
  Future<void> _applyFrame(int index) async {
    final current = state;
    if (current == null) {
      return;
    }
    final data = current.file.data[index];
    ref.read(appClockProvider.notifier).updateReplayTime(data.time);
    switch (data) {
      case KyoshinMonitorImageReplayData():
        await _applyKyoshinImage(data);
      case EqMonitorEewReplayData():
        _applyEew(data);
      case _:
        break;
    }
  }

  /// 指定位置まで状態を再構築する（シーク用）。
  /// EEW は累積更新のため先頭から再適用し、強震モニタ画像は直近 1 枚のみ適用する。
  Future<void> _rebuildTo(int index) async {
    final current = state;
    if (current == null) {
      return;
    }
    ref
      ..read(appClockProvider.notifier).updateReplayTime(
        current.file.data[index].time,
      )
      ..invalidate(eewProvider, asReload: true);

    final frames = current.file.data;
    for (var i = 0; i <= index; i++) {
      final data = frames[i];
      if (data is EqMonitorEewReplayData) {
        _applyEew(data);
      }
    }
    final latestImage = frames
        .sublist(0, index + 1)
        .whereType<KyoshinMonitorImageReplayData>()
        .lastOrNull;
    if (latestImage != null) {
      await _applyKyoshinImage(latestImage);
    }
  }

  Future<void> _applyKyoshinImage(KyoshinMonitorImageReplayData data) async {
    final imageData = data.images[ImageType.shindo];
    if (imageData == null) {
      return;
    }
    final analyzer = await ref.read(
      kyoshinMonitorAnalyzerIsolateProvider.future,
    );
    final result = await analyzer.analyze(Uint8List.fromList(imageData));
    ref
        .read(kyoshinMonitorProvider.notifier)
        .setReplay(
          geoJson: result.geoJson,
          targetTime: data.time,
          analyzedPointsCount: result.featureCount,
        );
  }

  void _applyEew(EqMonitorEewReplayData data) {
    final item = EewItemWithRelations.fromJson(
      jsonDecode(data.json) as Map<String, dynamic>,
    );
    ref.read(eewProvider.notifier).upsert(item.toEewTelegramItem);
  }
}
