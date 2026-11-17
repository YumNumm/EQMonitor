import 'dart:async';

import 'package:eqmonitor/feature/notification/data/model/test_live_activity_status.dart';
import 'package:eqmonitor/feature/notification/data/repository/test_live_activity_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_live_activity_notifier.g.dart';

/// テスト表示を自動で終了する時刻。アプリを再起動すると失われる。
@Riverpod(keepAlive: true)
class TestLiveActivityDeadline extends _$TestLiveActivityDeadline {
  @override
  DateTime? build() => null;

  // ignore: use_setters_to_change_properties
  void set(DateTime? value) => state = value;
}

@Riverpod(keepAlive: true)
class TestLiveActivityNotifier extends _$TestLiveActivityNotifier {
  /// テスト表示を出してから自動で終了するまでの時間。
  static const displayDuration = Duration(minutes: 1);

  @override
  Future<TestLiveActivityStatus> build() async {
    final repository = ref.watch(testLiveActivityRepositoryProvider);
    final deadline = ref.read(testLiveActivityDeadlineProvider);
    var status = await repository.status();
    if (!status.isActive) {
      return status;
    }
    final remaining = deadline?.difference(DateTime.now());
    // 期限切れ、または期限が分からない（アプリ再起動前の表示）なら終了する
    if (remaining == null || remaining <= Duration.zero) {
      await repository.end();
      ref.read(testLiveActivityDeadlineProvider.notifier).set(null);
      status = await repository.status();
      return status;
    }
    // 画面を閉じていて購読が無くても終了させるため、再構築に任せずここで終了する
    final timer = Timer(remaining, () async {
      await repository.end();
      ref.read(testLiveActivityDeadlineProvider.notifier).set(null);
      ref.invalidateSelf();
    });
    ref.onDispose(timer.cancel);
    return TestLiveActivityStatus(
      isSupported: status.isSupported,
      isActive: true,
      endsAt: deadline,
    );
  }

  static final showMutation = Mutation<void>();

  Future<void> show(DebugEewPreset preset) async {
    await ref.read(testLiveActivityRepositoryProvider).show(preset);
    ref
        .read(testLiveActivityDeadlineProvider.notifier)
        .set(DateTime.now().add(displayDuration));
    ref.invalidateSelf();
    await future;
  }

  static final endMutation = Mutation<void>();

  Future<void> end() async {
    await ref.read(testLiveActivityRepositoryProvider).end();
    ref.read(testLiveActivityDeadlineProvider.notifier).set(null);
    ref.invalidateSelf();
    await future;
  }
}
