import 'package:eqmonitor/feature/notification/data/notifier/test_live_activity_notifier.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_live_activity_action.g.dart';

@riverpod
TestLiveActivityAction testLiveActivityAction(Ref ref) =>
    const TestLiveActivityAction();

class const TestLiveActivityAction() {
  Future<void> run({
    required WidgetRef ref,
    required BuildContext context,
    DebugEewPreset? preset,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (preset != null) {
        await TestLiveActivityNotifier.showMutation.run(
          ref,
          (transaction) =>
              transaction.get(testLiveActivityProvider.notifier).show(preset),
        );
      } else {
        await TestLiveActivityNotifier.endMutation.run(
          ref,
          (transaction) =>
              transaction.get(testLiveActivityProvider.notifier).end(),
        );
      }
      if (!context.mounted || !messenger.mounted) {
        return;
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            preset == null ? 'テストのライブアクティビティを終了しました' : 'テストのライブアクティビティを表示しました',
          ),
        ),
      );
    } on LiveActivityLocalException catch (error) {
      if (!context.mounted || !messenger.mounted) {
        return;
      }
      messenger.showSnackBar(SnackBar(content: Text(error.message)));
    } on Exception catch (_) {
      if (!context.mounted || !messenger.mounted) {
        return;
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('ライブアクティビティの操作に失敗しました')),
      );
    }
  }
}
