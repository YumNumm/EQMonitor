import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_exit_action.g.dart';

@riverpod
LiveMonitorExitAction liveMonitorExitAction(Ref ref) =>
    const LiveMonitorExitAction();

class LiveMonitorExitAction {
  const LiveMonitorExitAction();

  Future<void> confirm({
    required WidgetRef ref,
    required BuildContext context,
    required VoidCallback onConfirmed,
  }) async {
    final confirmed = await showDialog<bool>(
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
    if (confirmed != true || !context.mounted) {
      return;
    }
    ref.read(liveMonitorControlPanelProvider.notifier).close();
    onConfirmed();
  }
}
