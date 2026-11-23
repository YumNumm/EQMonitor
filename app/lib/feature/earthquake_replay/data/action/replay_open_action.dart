import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_start_exception.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_open_action.g.dart';

@riverpod
ReplayOpenAction replayOpenAction(Ref ref) => const ReplayOpenAction();

class const ReplayOpenAction() {
  /// 失敗は [ReplayNotifier.openMutation] の状態として画面に表示する。
  Future<void> open(
    WidgetRef ref,
    BuildContext context, {
    required Uri source,
  }) async {
    try {
      await ReplayNotifier.openMutation.run(
        ref,
        (tsx) => tsx.get(replayProvider.notifier).open(source: source),
      );
    } on Object {
      return;
    }
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }

  Future<void> openEarthquake(
    WidgetRef ref,
    BuildContext context, {
    required Earthquake earthquake,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ReplayNotifier.openEarthquakeMutation.run(
        ref,
        (tsx) => tsx
            .get(replayProvider.notifier)
            .openEarthquake(
              eventId: earthquake.eventId,
              label: earthquake.hypocenter?.name ?? '過去の地震',
              originTime: earthquake.originTime,
              precision: earthquake.originTimePrecision,
            ),
      );
    } on ReplayStartException catch (error) {
      messenger.showSnackBar(SnackBar(content: Text(error.failure.message)));
      return;
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text('再生を開始できませんでした。時間をおいてもう一度お試しください。')),
      );
      return;
    }
    if (context.mounted) {
      const HomeRoute().go(context);
    }
  }
}
