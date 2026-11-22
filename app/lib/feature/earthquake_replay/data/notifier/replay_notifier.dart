import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_file_repository.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_baseline_planner.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show EewItemWithRelations;
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_notifier.g.dart';

/// EQRP リプレイファイルの再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。
@Riverpod(keepAlive: true)
class ReplayNotifier extends _$ReplayNotifier {
  static final openMutation = Mutation<void>();

  // 画像解析の遅れで再生が累積的に遅れないよう、再生開始時の壁時計を基準に次の時刻を決める。
  // 基準から大きく遅れたときは追いつこうとせず基準を取り直す。
  static const _lagTolerance = Duration(milliseconds: 500);

  final _wallClock = Stopwatch()..start();
  Timer? _playbackTimer;
  ({Duration wallTime, DateTime replayTime})? _anchor;
  // シーク・読み込み・終了をまたいで、解析中だった古いフレームを反映しないための世代番号。
  int _generation = 0;

  @override
  ReplayState? build() {
    ref.onDispose(_stopPlaybackTimer);
    return null;
  }

  Future<void> open({required Uri source}) async {
    final loaded = await ref
        .read(replayFileRepositoryProvider)
        .load(source: source);
    if (!ref.mounted) {
      return;
    }
    await start(file: loaded.file, fileName: loaded.name);
  }

  Future<void> start({
    required ReplayFile file,
    required String fileName,
  }) async {
    _stopPlaybackTimer();
    _generation++;
    _anchor = null;
    final startTime = file.data.first.time;
    state = ReplayState(
      file: file,
      fileName: fileName,
      currentIndex: 0,
      currentTime: startTime,
      isPlaying: false,
      playbackSpeed: 1,
    );
    ref.read(appClockProvider.notifier).enterReplay(startTime);
    ref.read(kyoshinMonitorAnalyzerIsolateProvider.future).ignore();
    ref.read(estimatedIntensityIsolateProvider.future).ignore();
    await _rebuild();
    await play();
  }

  Future<void> play() async {
    final current = state;
    if (current == null) {
      return;
    }
    if (current.isAtEnd) {
      await seek(current.startTime);
    }
    final next = state;
    if (next == null) {
      return;
    }
    _anchor = null;
    state = next.copyWith(isPlaying: true);
    _schedule();
  }

  void pause() {
    final current = state;
    if (current == null) {
      return;
    }
    _stopPlaybackTimer();
    _anchor = null;
    state = current.copyWith(isPlaying: false);
  }

  Future<void> togglePlayPause() async {
    if (state?.isPlaying ?? false) {
      pause();
    } else {
      await play();
    }
  }

  /// リプレイを終了し、通常再生（ライブ）へ戻す。
  void exit() {
    _stopPlaybackTimer();
    _generation++;
    _anchor = null;
    state = null;
    ref.read(deviceShakeDetectionProvider.notifier).clear();
    ref.read(appClockProvider.notifier).returnToRealtime();
    // リプレイ中に発表されたライブのEEWは破棄されているため、REST も取り直す。
    ref
      ..invalidate(eewRestProvider, asReload: true)
      ..invalidate(eewProvider, asReload: true)
      ..invalidate(kyoshinMonitorProvider, asReload: true);
  }

  Future<void> seek(DateTime time) async {
    final current = state;
    if (current == null) {
      return;
    }
    _stopPlaybackTimer();
    _generation++;
    _anchor = null;
    final target = current.clampTime(time);
    state = current.copyWith(
      currentIndex: current.indexAt(target),
      currentTime: target,
    );
    await _rebuild();
    _schedule();
  }

  Future<void> seekBy(Duration delta) async {
    final current = state;
    if (current == null) {
      return;
    }
    await seek(current.currentTime.add(delta));
  }

  void setPlaybackSpeed(double speed) {
    final current = state;
    if (current == null || speed <= 0) {
      return;
    }
    _anchor = null;
    state = current.copyWith(playbackSpeed: speed);
    _schedule();
  }

  void _schedule() {
    _stopPlaybackTimer();
    final current = state;
    final next = current?.nextTickTime();
    if (current == null || !current.isPlaying || next == null) {
      return;
    }
    final now = _wallClock.elapsed;
    final anchor = _anchor ??= (wallTime: now, replayTime: current.currentTime);
    final due =
        anchor.wallTime +
        next.difference(anchor.replayTime) * (1 / current.playbackSpeed);
    final delay = due - now;
    if (delay < -_lagTolerance) {
      _anchor = (wallTime: now, replayTime: current.currentTime);
    }
    _playbackTimer = Timer(delay.isNegative ? Duration.zero : delay, () async {
      await _tick(target: next);
    });
  }

  Future<void> _tick({required DateTime target}) async {
    final generation = _generation;
    final current = state;
    if (current == null || !current.isPlaying) {
      return;
    }
    await _advanceTo(current: current, target: target);
    if (!ref.mounted || generation != _generation) {
      return;
    }
    if (state?.isAtEnd ?? true) {
      pause();
      return;
    }
    _schedule();
  }

  Future<void> _advanceTo({
    required ReplayState current,
    required DateTime target,
  }) async {
    final frames = current.frames;
    var index = current.currentIndex;
    KyoshinMonitorImageReplayData? latestImage;
    while (index + 1 < frames.length &&
        !frames[index + 1].time.isAfter(target)) {
      index++;
      switch (frames[index]) {
        case final EqMonitorEewReplayData data:
          _applyEew(data);
        case final KyoshinMonitorImageReplayData data:
          latestImage = data;
        case _:
          break;
      }
    }
    state = current.copyWith(currentIndex: index, currentTime: target);
    ref.read(appClockProvider.notifier).updateReplayTime(target);
    if (latestImage != null) {
      await _applyKyoshinImage(latestImage, generation: _generation);
    }
  }

  /// 現在の再生位置まで状態を作り直す（読み込み・シーク用）。
  /// EEW は累積更新のため先頭から再適用し、強震モニタ画像は直近 1 枚のみ適用する。
  Future<void> _rebuild() async {
    final current = state;
    if (current == null) {
      return;
    }
    final generation = _generation;
    // 再生位置が飛ぶため、揺れ検知は次の画像で平常値の投入からやり直す。
    ref.read(deviceShakeDetectionProvider.notifier).clear();
    ref
      ..read(appClockProvider.notifier).updateReplayTime(current.currentTime)
      ..invalidate(eewProvider, asReload: true);

    final passed = current.frames.take(current.currentIndex + 1).toList();
    passed.whereType<EqMonitorEewReplayData>().forEach(_applyEew);
    final latestImage = passed
        .whereType<KyoshinMonitorImageReplayData>()
        .lastOrNull;
    if (latestImage == null) {
      ref
          .read(kyoshinMonitorProvider.notifier)
          .setReplay(geoJson: null, targetTime: current.currentTime);
      return;
    }
    await _applyKyoshinImage(latestImage, generation: generation);
  }

  Future<void> _applyKyoshinImage(
    KyoshinMonitorImageReplayData data, {
    required int generation,
  }) async {
    final imageData = data.images[ImageType.shindo];
    final current = state;
    if (imageData == null || current == null) {
      return;
    }
    final shakeSettings = ref.read(shakeDetectionCurrentSettingsProvider);
    final shakeTuning = ref.read(shakeDetectionTuningProvider);
    final shakeDetection = ref.read(deviceShakeDetectionProvider.notifier);
    // 平常値と履歴の作り直しには、ライブ取得の代わりにファイル内の過去フレームを使う。
    final baselineTimes = shakeSettings.isEnabled
        ? ref
              .read(shakeDetectionBaselinePlannerProvider)
              .plan(
                previous: ref.read(deviceShakeDetectionProvider)?.observedAt,
                target: data.time,
              )
        : null;
    try {
      final analyzer = await ref.read(
        kyoshinMonitorAnalyzerIsolateProvider.future,
      );
      final result = await analyzer.analyze(
        Uint8List.fromList(imageData),
        shakeDetection: shakeSettings.isEnabled
            ? ShakeDetectionRequest(
                observedAt: data.time,
                baselineGifs: baselineTimes == null
                    ? null
                    : [
                        for (final time in baselineTimes)
                          ?current.shindoImageAt(time),
                      ],
                fallbackBaseline: shakeTuning.fallbackBaseline,
                parameters: shakeTuning.parameters,
              )
            : null,
      );
      if (!ref.mounted || generation != _generation) {
        return;
      }
      ref
          .read(kyoshinMonitorProvider.notifier)
          .setReplay(
            geoJson: result.geoJson,
            targetTime: data.time,
            analyzedPointsCount: result.featureCount,
          );
      final shakeEvents = result.shakeEvents;
      if (shakeEvents == null) {
        shakeDetection.clear();
        return;
      }
      shakeDetection.apply(
        observedAt: data.time,
        events: shakeEvents,
        status: result.shakeStatus,
      );
      if (baselineTimes == null || !shakeSettings.isBackfillEnabled) {
        return;
      }
      final backfillFrames = [
        for (var second = 1; second <= shakeTuning.backfillSeconds; second++)
          if (data.time.subtract(Duration(seconds: second))
              case final observedAt)
            if (current.shindoImageAt(observedAt) case final gif?)
              ShakeBackfillFrame(observedAt: observedAt, gif: gif),
      ];
      if (backfillFrames.isEmpty) {
        return;
      }
      final rebuiltEvents = await analyzer.backfillShakeDetection(
        ShakeBackfillRequest(coldStartAt: data.time, frames: backfillFrames),
      );
      if (rebuiltEvents != null && ref.mounted && generation == _generation) {
        shakeDetection.replaceEvents(rebuiltEvents);
      }
    } on Object catch (error, stackTrace) {
      // 1 フレームの解析失敗で再生全体を止めない。
      talker.warning(
        '[Replay] kmoni frame skipped: ${data.time}',
        error,
        stackTrace,
      );
    }
  }

  void _applyEew(EqMonitorEewReplayData data) {
    try {
      final item = EewItemWithRelations.fromJson(
        jsonDecode(data.json) as Map<String, dynamic>,
      );
      ref.read(eewProvider.notifier).upsert(item.toEewTelegramItem);
    } on Object catch (error, stackTrace) {
      talker.warning(
        '[Replay] EEW frame skipped: ${data.time}',
        error,
        stackTrace,
      );
    }
  }

  void _stopPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
  }
}
