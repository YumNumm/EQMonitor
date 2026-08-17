import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_history_notice_notifier.dart';
import 'package:eqmonitor/feature/eew_history/ui/components/eew_history_notice_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showEewHistoryNoticeFlow({
  required WidgetRef ref,
  required BuildContext context,
}) async {
  final acknowledged = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const EewHistoryNoticeDialog(),
  );
  if (acknowledged != true || !context.mounted) {
    return;
  }
  try {
    await EewHistoryNoticeShown.markShownMutation.run(
      ref,
      (tsx) async =>
          tsx.get(eewHistoryNoticeShownProvider.notifier).markShown(),
    );
  } catch (error, stackTrace) {
    talker.handle(error, stackTrace, 'Failed to persist EEW history notice');
  }
}
