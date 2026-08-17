import 'dart:async';

import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_simulation_notifier.g.dart';

class EewSimulationState {
  const new({
    required this.reports,
    required this.currentIndex,
    required this.isPlaying,
    required this.startedAt,
  });

  final List<EewTelegramItem> reports;
  final int currentIndex;
  final bool isPlaying;
  final DateTime startedAt;

  int get totalReports => reports.length;
  EewTelegramItem get currentReport => reports[currentIndex];
  bool get isComplete => currentIndex >= reports.length - 1;

  EewSimulationState copyWith({
    List<EewTelegramItem>? reports,
    int? currentIndex,
    bool? isPlaying,
    DateTime? startedAt,
  }) => EewSimulationState(
    reports: reports ?? this.reports,
    currentIndex: currentIndex ?? this.currentIndex,
    isPlaying: isPlaying ?? this.isPlaying,
    startedAt: startedAt ?? this.startedAt,
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
      startedAt: DateTime.now(),
    );
    _scheduleNext();
  }

  void _scheduleNext() {
    _timer?.cancel();
    final s = state;
    if (s == null || !s.isPlaying || s.isComplete) {
      if (s != null && s.isComplete) {
        state = s.copyWith(isPlaying: false);
      }
      return;
    }

    final next = s.currentIndex + 1;
    final delay = s.reports[next].reportTime.difference(
      s.reports[s.currentIndex].reportTime,
    );
    // Clamp: at least 500ms, at most 5 seconds
    final clamped = Duration(
      milliseconds: delay.inMilliseconds.clamp(500, 5000),
    );

    _timer = Timer(clamped, () {
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
      state = s.copyWith(isPlaying: false);
    }
  }

  void resume() {
    final s = state;
    if (s != null && !s.isComplete) {
      state = s.copyWith(isPlaying: true);
      _scheduleNext();
    }
  }

  void stop() {
    _timer?.cancel();
    state = null;
  }
}
