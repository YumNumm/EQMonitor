import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_kyoshin_archive_window_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_origin_time_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_position_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_shake_detection_planner.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_exit_notice.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_start_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_exit_notice_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_file_repository.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_kyoshin_archive_frame.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_kyoshin_archive_frame_loader.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_kyoshin_archive_repository.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_analyzer_isolate_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show EewItemWithRelations;
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_notifier.g.dart';

/// EQRP リプレイファイルと強震モニタの過去画像の再生を司り、再生時刻と各フレームを
/// 本物の表示パイプライン（appClock / [eewProvider] / [kyoshinMonitorProvider]）
/// へ流し込むコントローラ。
@Riverpod(keepAlive: true)
class ReplayNotifier extends _$ReplayNotifier {
  static const _liveEewPollInterval = Duration(seconds: 10);

  // 画像解析の遅れで再生が累積的に遅れないよう、再生開始時の壁時計を基準に再生位置を決める。
  // 処理が遅れたときは基準を取り直さず、途中のフレームを飛ばして基準の位置へ追いつく。
  final _wallClock = Stopwatch()..start();
  Timer? _playbackTimer;
  Timer? _liveEewTimer;
  DateTime? _appliedArchiveImageTime;
  ReplayAnchor? _anchor;
  // シーク・読み込み・終了をまたいで、解析中だった古いフレームを反映しないための世代番号。
  int _generation = 0;

  @override
  ReplayState? build() {
    ref
      ..onDispose(_stopPlaybackTimer)
      ..onDispose(_stopLiveEewTimer)
      ..listen(realtimeEventsProvider, (_, next) {
        if (next case AsyncData(
          isLoading: false,
          value: RealtimeEewUpsertEvent(:final record),
        )) {
          if (_exitIfLiveEewAlive([record.toEewTelegramItem])) {
            // 終了時の REST 再取得を待たずに、復帰のきっかけになった報を表示する。
            ref.read(eewProvider.notifier).applyRealtimeRecord(record);
          }
        }
      });
    return null;
  }

  static final openMutation = Mutation<void>();

  Future<void> open({required Uri source}) async {
    _throwIfLiveEewAlive();
    final loaded = await ref
        .read(replayFileRepositoryProvider)
        .load(source: source);
    if (!ref.mounted) {
      return;
    }
    await start(
      source: ReplaySource.eqrp(
        file: loaded.file,
        name: loaded.name,
        originTime: ref
            .read(replayOriginTimeResolverProvider)
            .resolve(loaded.file.data),
      ),
    );
  }

  static final openEarthquakeMutation = Mutation<void>();

  Future<void> openEarthquake({
    required String eventId,
    required String label,
    required DateTime? originTime,
    required OriginTimePrecision precision,
  }) async {
    final window = ref
        .read(replayKyoshinArchiveWindowResolverProvider)
        .resolve(
          originTime: originTime,
          precision: precision,
          now: ref.read(appClockProvider.notifier).realtimeNow(),
        );
    if (window == null) {
      throw const ReplayStartException(.outOfRange);
    }
    _throwIfLiveEewAlive();
    final repository = await ref.read(
      replayKyoshinArchiveRepositoryProvider.future,
    );
    final monitorSource =
        ref.read(kyoshinMonitorSettingsProvider).value?.monitorSource ??
        KyoshinMonitorSource.lmoni;
    repository.clear();
    // 過去画像は1時間ごとにまとめて削除されるため、範囲内でも先頭が残っているとは限らない。
    switch (await repository.fetchShindoImage(
      source: monitorSource,
      time: window.startTime,
    )) {
      case Success(value: null):
        throw const ReplayStartException(.outOfRange);
      case Failure(:final exception):
        throw exception;
      case Success():
    }
    final eewFrames = ref.read(isProProvider)
        ? await repository.fetchEewFrames(eventId: eventId)
        : const Success<List<ReplayData>, Exception>([]);
    if (!ref.mounted) {
      return;
    }
    if (eewFrames case Failure(:final exception, :final stackTrace)) {
      talker.warning(
        '[Replay] EEW history unavailable: $eventId',
        exception,
        stackTrace,
      );
    }
    await start(
      source: ReplaySource.kyoshinArchive(
        label: label,
        windowStart: window.startTime,
        windowEnd: window.endTime,
        originTime: window.originTime,
        isOriginTimeApproximate: window.isOriginTimeApproximate,
        eewFrames: eewFrames.unwrapOr(const []),
        monitorSource: monitorSource,
      ),
    );
  }

  Future<void> start({required ReplaySource source}) async {
    // 読み込みや取得を待つ間に発表された EEW を、再生の開始で隠さない。
    _throwIfLiveEewAlive();
    _stopPlaybackTimer();
    _generation++;
    _anchor = null;
    final startTime = source.startTime;
    final initial = ReplayState(
      source: source,
      passedFrameCount: 0,
      currentTime: startTime,
      isPlaying: false,
      playbackSpeed: 1,
    );
    state = initial.copyWith(
      passedFrameCount: initial.passedFrameCountAt(startTime),
    );
    _stopLiveEewTimer();
    _liveEewTimer = Timer.periodic(
      _liveEewPollInterval,
      (_) async => _pollLiveEew(),
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

  /// 補間中の位置で止め、表示中の波面などを巻き戻さない。
  Future<void> pause() async {
    final current = state;
    if (current == null) {
      return;
    }
    _stopPlaybackTimer();
    final position = ref
        .read(replayPositionResolverProvider)
        .current(
          state: current,
          anchor: _anchor,
          wallTime: _wallClock.elapsed,
        );
    _anchor = null;
    final paused = current.copyWith(isPlaying: false);
    state = paused;
    await _advanceTo(current: paused, target: position);
  }

  Future<void> togglePlayPause() async {
    if (state?.isPlaying ?? false) {
      await pause();
    } else {
      await play();
    }
  }

  /// リプレイを終了し、通常再生（ライブ）へ戻す。
  void exit({ReplayExitNotice? notice}) {
    _stopPlaybackTimer();
    _stopLiveEewTimer();
    _generation++;
    if (notice != null) {
      ref.read(replayExitNoticeProvider.notifier).show(notice);
    }
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
      passedFrameCount: current.passedFrameCountAt(target),
      currentTime: target,
    );
    await _rebuild();
    _schedule();
  }

  /// 補間中の表示位置を基準に動かす。直前の進行位置を基準にすると最大 1 秒ずれる。
  Future<void> seekBy(Duration delta) async {
    final current = state;
    if (current == null) {
      return;
    }
    final position = ref
        .read(replayPositionResolverProvider)
        .current(
          state: current,
          anchor: _anchor,
          wallTime: _wallClock.elapsed,
        );
    await seek(position.add(delta));
  }

  void setPlaybackSpeed(double speed) {
    final current = state;
    if (current == null || !current.source.playbackSpeeds.contains(speed)) {
      return;
    }
    final position = ref
        .read(replayPositionResolverProvider)
        .current(
          state: current,
          anchor: _anchor,
          wallTime: _wallClock.elapsed,
        );
    final next = current.copyWith(playbackSpeed: speed);
    state = next;
    if (next.isPlaying) {
      _anchor = (wallTime: _wallClock.elapsed, replayTime: position);
      ref
          .read(appClockProvider.notifier)
          .updateReplayTime(position, rate: speed, limit: next.endTime);
    }
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
    final anchor = _anchor ?? (wallTime: now, replayTime: current.currentTime);
    if (_anchor == null) {
      _anchor = anchor;
      ref
          .read(appClockProvider.notifier)
          .updateReplayTime(
            current.currentTime,
            rate: current.playbackSpeed,
            limit: current.endTime,
          );
    }
    final due =
        anchor.wallTime +
        next.difference(anchor.replayTime) * (1 / current.playbackSpeed);
    final delay = due - now;
    _playbackTimer = Timer(delay.isNegative ? Duration.zero : delay, () async {
      await _tick(scheduled: next);
    });
  }

  Future<void> _tick({required DateTime scheduled}) async {
    final generation = _generation;
    final current = state;
    if (current == null || !current.isPlaying) {
      return;
    }
    final target = ref
        .read(replayPositionResolverProvider)
        .tickTarget(
          state: current,
          anchor: _anchor,
          wallTime: _wallClock.elapsed,
          scheduled: scheduled,
        );
    await _advanceTo(current: current, target: target);
    if (!ref.mounted || generation != _generation) {
      return;
    }
    if (state?.isAtEnd ?? true) {
      await pause();
      return;
    }
    _schedule();
  }

  Future<void> _advanceTo({
    required ReplayState current,
    required DateTime target,
  }) async {
    final passedFrameCount = current.passedFrameCountAt(target);
    final passed = current.frames.sublist(
      current.passedFrameCount,
      passedFrameCount,
    );
    passed.whereType<EqMonitorEewReplayData>().forEach(_applyEew);
    state = current.copyWith(
      passedFrameCount: passedFrameCount,
      currentTime: target,
    );
    ref
        .read(appClockProvider.notifier)
        .updateReplayTime(
          target,
          rate: current.isPlaying ? current.playbackSpeed : 0,
          limit: current.endTime,
        );
    switch (current.source) {
      case ReplayEqrpSource():
        final latestImage = passed
            .whereType<KyoshinMonitorImageReplayData>()
            .lastOrNull;
        if (latestImage != null) {
          await _applyRecordedImage(latestImage, generation: _generation);
        }
      case final ReplayKyoshinArchiveSource source:
        await _applyArchiveImage(
          source: source,
          time: target,
          generation: _generation,
        );
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

    _appliedArchiveImageTime = null;
    final passed = current.frames.take(current.passedFrameCount).toList();
    passed.whereType<EqMonitorEewReplayData>().forEach(_applyEew);
    switch (current.source) {
      case ReplayEqrpSource():
        final latestImage = passed
            .whereType<KyoshinMonitorImageReplayData>()
            .lastOrNull;
        if (latestImage == null) {
          ref
              .read(kyoshinMonitorProvider.notifier)
              .setReplay(geoJson: null, targetTime: current.currentTime);
          return;
        }
        await _applyRecordedImage(latestImage, generation: generation);
      case final ReplayKyoshinArchiveSource source:
        await _applyArchiveImage(
          source: source,
          time: current.currentTime,
          generation: generation,
        );
    }
  }

  Future<void> _applyRecordedImage(
    KyoshinMonitorImageReplayData data, {
    required int generation,
  }) async {
    final imageData = data.images[ImageType.shindo];
    final current = state;
    if (imageData == null || current == null) {
      return;
    }
    await _applyKyoshinImage(
      image: Uint8List.fromList(imageData),
      observedAt: data.time,
      baselineImages: {
        for (final time in _shakeBaselineTimes(observedAt: data.time))
          if (current.recordedShindoImageAt(time) case final gif?) time: gif,
      },
      generation: generation,
    );
  }

  Future<void> _applyArchiveImage({
    required ReplayKyoshinArchiveSource source,
    required DateTime time,
    required int generation,
  }) async {
    final observedAt = time.copyWith(millisecond: 0, microsecond: 0);
    if (_appliedArchiveImageTime == observedAt) {
      return;
    }
    _appliedArchiveImageTime = observedAt;
    final loader = await ref.read(
      replayKyoshinArchiveFrameLoaderProvider.future,
    );
    final frame = await loader.load(
      source: source.monitorSource,
      observedAt: observedAt,
      baselineTimes: _shakeBaselineTimes(observedAt: observedAt),
      now: ref.read(appClockProvider.notifier).realtimeNow(),
    );
    if (!ref.mounted || generation != _generation) {
      return;
    }
    switch (frame) {
      case ReplayKyoshinArchiveFramePurged():
        exit(notice: .archiveExpired);
      case ReplayKyoshinArchiveFrameUnavailable():
        // 取得できなかった時刻に、直前の時刻の観測点を残さない。
        ref.read(deviceShakeDetectionProvider.notifier).clear();
        ref
            .read(kyoshinMonitorProvider.notifier)
            .setReplay(geoJson: null, targetTime: observedAt);
      case ReplayKyoshinArchiveFrameAvailable(
        :final image,
        :final baselineImages,
      ):
        await _applyKyoshinImage(
          image: image,
          observedAt: observedAt,
          baselineImages: baselineImages,
          generation: generation,
        );
    }
  }

  List<DateTime> _shakeBaselineTimes({required DateTime observedAt}) => ref
      .read(replayShakeDetectionPlannerProvider)
      .requiredTimes(
        observedAt: observedAt,
        previousObservedAt: ref.read(deviceShakeDetectionProvider)?.observedAt,
        settings: ref.read(shakeDetectionCurrentSettingsProvider),
        tuning: ref.read(shakeDetectionTuningProvider),
      );

  Future<void> _applyKyoshinImage({
    required Uint8List image,
    required DateTime observedAt,
    required Map<DateTime, Uint8List> baselineImages,
    required int generation,
  }) async {
    final shakeDetection = ref.read(deviceShakeDetectionProvider.notifier);
    final shakePlan = ref
        .read(replayShakeDetectionPlannerProvider)
        .plan(
          images: baselineImages,
          observedAt: observedAt,
          previousObservedAt: ref
              .read(deviceShakeDetectionProvider)
              ?.observedAt,
          settings: ref.read(shakeDetectionCurrentSettingsProvider),
          tuning: ref.read(shakeDetectionTuningProvider),
        );
    try {
      final analyzer = await ref.read(
        kyoshinMonitorAnalyzerIsolateProvider.future,
      );
      final result = await analyzer.analyze(
        image,
        shakeDetection: shakePlan?.request,
      );
      if (!ref.mounted || generation != _generation) {
        return;
      }
      ref
          .read(kyoshinMonitorProvider.notifier)
          .setReplay(
            geoJson: result.geoJson,
            targetTime: observedAt,
            analyzedPointsCount: result.featureCount,
          );
      final shakeEvents = result.shakeEvents;
      if (shakeEvents == null) {
        shakeDetection.clear();
        return;
      }
      shakeDetection.apply(
        observedAt: observedAt,
        events: shakeEvents,
        status: result.shakeStatus,
      );
      final backfill = shakePlan?.backfill;
      if (backfill == null) {
        return;
      }
      final rebuiltEvents = await analyzer.backfillShakeDetection(backfill);
      if (rebuiltEvents != null && ref.mounted && generation == _generation) {
        shakeDetection.replaceEvents(rebuiltEvents);
      }
    } on Object catch (error, stackTrace) {
      // 1 フレームの解析失敗で再生全体を止めない。
      talker.warning(
        '[Replay] kmoni frame skipped: $observedAt',
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

  void _throwIfLiveEewAlive() {
    if (ref.read(isRealtimeModeProvider) &&
        (ref.read(eewAliveTelegramProvider)?.isNotEmpty ?? false)) {
      throw const ReplayStartException(.liveEewActive);
    }
  }

  Future<void> _pollLiveEew() async {
    if (state == null ||
        ref.read(eqMonitorWsStatusProvider).phase == WsPhase.connected) {
      return;
    }
    final items = await Result.capture<List<EewTelegramItem>, Exception>(
      () => ref.refresh(eewRestProvider.future),
    );
    if (ref.mounted) {
      _exitIfLiveEewAlive(items.unwrapOr(const []));
    }
  }

  bool _exitIfLiveEewAlive(List<EewTelegramItem> items) {
    final checker = ref.read(eewAliveCheckerProvider);
    final now = ref.read(appClockProvider.notifier).realtimeNow();
    if (state == null ||
        items.every(
          (eew) => checker.checkMarkAsEventEnded(eew: eew, now: now),
        )) {
      return false;
    }
    exit(notice: .eewIssued);
    return true;
  }

  void _stopLiveEewTimer() {
    _liveEewTimer?.cancel();
    _liveEewTimer = null;
  }

  void _stopPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = null;
  }
}
