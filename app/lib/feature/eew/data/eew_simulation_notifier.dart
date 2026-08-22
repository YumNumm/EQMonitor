import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_simulation_notifier.g.dart';

class EewSimulationState {
  const new({
    required this.reports,
    required this.currentIndex,
    required this.isPlaying,
    required this.startedAt,
    required this.elapsedBeforeRun,
  });

  final List<EewTelegramItem> reports;
  final int currentIndex;
  final bool isPlaying;
  final DateTime startedAt;
  final Duration elapsedBeforeRun;

  int get totalReports => reports.length;
  EewTelegramItem get currentReport => reports[currentIndex];
  bool get isComplete => currentIndex >= reports.length - 1;

  Duration playbackElapsedAt(DateTime now) =>
      elapsedBeforeRun +
      (isPlaying ? now.difference(startedAt) : Duration.zero);

  Duration reportPlaybackOffset(int index) {
    var elapsed = Duration.zero;
    for (var i = 1; i <= index; i += 1) {
      final interval = reports[i].reportTime.difference(
        reports[i - 1].reportTime,
      );
      elapsed += Duration(
        milliseconds: interval.inMilliseconds.clamp(500, 5000),
      );
    }
    return elapsed;
  }

  EewSimulationState copyWith({
    List<EewTelegramItem>? reports,
    int? currentIndex,
    bool? isPlaying,
    DateTime? startedAt,
    Duration? elapsedBeforeRun,
  }) => EewSimulationState(
    reports: reports ?? this.reports,
    currentIndex: currentIndex ?? this.currentIndex,
    isPlaying: isPlaying ?? this.isPlaying,
    startedAt: startedAt ?? this.startedAt,
    elapsedBeforeRun: elapsedBeforeRun ?? this.elapsedBeforeRun,
  );
}

@riverpod
class EewSimulation extends _$EewSimulation {
  Timer? _timer;

  @override
  EewSimulationState? build() {
    ref.onDispose(() => _timer?.cancel());
    return null;
  }

  void start(List<EewTelegramItem> reports) {
    stop();
    final sorted = [...reports]
      ..sort((a, b) => a.reportTime.compareTo(b.reportTime));
    if (sorted.isEmpty) {
      return;
    }

    state = EewSimulationState(
      reports: sorted,
      currentIndex: 0,
      isPlaying: true,
      startedAt: clock.now(),
      elapsedBeforeRun: Duration.zero,
    );
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final s = state;
    if (s == null || !s.isPlaying || s.isComplete) {
      if (s != null && s.isComplete) {
        state = s.copyWith(
          isPlaying: false,
          elapsedBeforeRun: s.playbackElapsedAt(clock.now()),
        );
      }
      return;
    }

    final next = s.currentIndex + 1;
    final remaining =
        s.reportPlaybackOffset(next) - s.playbackElapsedAt(clock.now());
    final delay = remaining.isNegative ? Duration.zero : remaining;

    _timer = Timer(delay, () {
      final current = state;
      if (current == null || !current.isPlaying) {
        return;
      }
      state = current.copyWith(currentIndex: next);
      _scheduleNext();
    });
  }

  void pause() {
    _timer?.cancel();
    final s = state;
    if (s != null) {
      state = s.copyWith(
        isPlaying: false,
        elapsedBeforeRun: s.playbackElapsedAt(clock.now()),
      );
    }
  }

  void resume() {
    final s = state;
    if (s != null && !s.isComplete) {
      state = s.copyWith(isPlaying: true, startedAt: clock.now());
      _scheduleNext();
    }
  }

  void stop() {
    _timer?.cancel();
    state = null;
  }
}
