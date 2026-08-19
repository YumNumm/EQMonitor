import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_exit_action.g.dart';

@riverpod
LiveMonitorExitAction liveMonitorExitAction(Ref ref) =>
    const LiveMonitorExitAction();

class LiveMonitorExitAction {
  const new();

  Future<void> confirm({
    required WidgetRef ref,
    required BuildContext context,
    required bool dismissWhenPanelCloses,
    required VoidCallback onConfirmed,
  }) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = DialogRoute<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('LiveMonitor モードを終了しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('終了'),
          ),
        ],
      ),
    );
    final panelSubscription = dismissWhenPanelCloses
        ? ref.listenManual(liveMonitorControlPanelProvider, (_, next) {
            if (!next && route.isActive) {
              route.navigator?.removeRoute(route, false);
            }
          })
        : null;
    bool? confirmed;
    try {
      confirmed = await navigator.push(route);
    } finally {
      panelSubscription?.close();
    }
    if (confirmed != true || !context.mounted) {
      return;
    }
    onConfirmed();
    ref.read(liveMonitorControlPanelProvider.notifier).close();
  }

  Future<void> confirmDiscardAndExit({
    required WidgetRef ref,
    required BuildContext context,
    required bool dismissWhenPanelCloses,
    required VoidCallback onConfirmed,
  }) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = DialogRoute<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('表示時間を保存できませんでした'),
        content: const Text('入力中の変更を破棄してLiveMonitor モードを終了しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('戻る'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('変更を破棄して終了'),
          ),
        ],
      ),
    );
    final panelSubscription = dismissWhenPanelCloses
        ? ref.listenManual(liveMonitorControlPanelProvider, (_, next) {
            if (!next && route.isActive) {
              route.navigator?.removeRoute(route, false);
            }
          })
        : null;
    bool? confirmed;
    try {
      confirmed = await navigator.push(route);
    } finally {
      panelSubscription?.close();
    }
    if (confirmed != true || !context.mounted) {
      return;
    }
    onConfirmed();
    ref.read(liveMonitorControlPanelProvider.notifier).close();
  }
}
