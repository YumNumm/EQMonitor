import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_replay_provider.freezed.dart';
part 'debug_replay_provider.g.dart';

enum DebugReplayStatus { idle, playing, completed }

@freezed
abstract class DebugReplayState with _$DebugReplayState {
  const factory DebugReplayState({
    @Default(DebugReplayStatus.idle) DebugReplayStatus status,
    @Default(0) int currentIndex,
    @Default(0) int totalCount,
  }) = _DebugReplayState;
}

@riverpod
class DebugReplay extends _$DebugReplay {
  final List<Timer> _timers = [];

  @override
  DebugReplayState build() => const DebugReplayState();

  Future<void> start(String scenarioAssetDir) async {
    stop();

    final indexJson = await rootBundle.loadString(
      '$scenarioAssetDir/index.json',
    );
    final index = jsonDecode(indexJson) as Map<String, dynamic>;
    final fileNames = (index['files'] as List).cast<String>();

    final items = <EewItemWithRelations>[];
    for (final name in fileNames) {
      final raw = await rootBundle.loadString('$scenarioAssetDir/$name');
      final parsed = EewItemWithRelations.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
      items.add(parsed);
    }

    if (items.isEmpty) {
      return;
    }

    final t0 = items.first.reportTime;
    final offset = DateTime.now().toUtc().difference(t0.toUtc());

    state = state.copyWith(
      status: DebugReplayStatus.playing,
      currentIndex: 0,
      totalCount: items.length,
    );

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final delay = item.reportTime.toUtc().difference(t0.toUtc());
      final timer = Timer(delay, () => _inject(item, offset));
      _timers.add(timer);
    }
  }

  void _inject(EewItemWithRelations item, Duration offset) {
    final shifted = item.copyWith(
      reportTime: item.reportTime.add(offset),
      originTime: item.originTime?.add(offset),
      arrivalTime: item.arrivalTime?.add(offset),
    );
    ref.read(eewProvider.notifier).upsert(shifted.toEewTelegramItem());

    final next = state.currentIndex + 1;
    state = state.copyWith(
      currentIndex: next,
      status:
          next >= state.totalCount
              ? DebugReplayStatus.completed
              : DebugReplayStatus.playing,
    );
  }

  void stop() {
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
    state = const DebugReplayState();
  }
}
