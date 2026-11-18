import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/debug/ui/dialog/debug_mode_warning_dialog.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_mode_action.g.dart';

@riverpod
DebugModeAction debugModeAction(Ref ref) => const DebugModeAction();

class const DebugModeAction() {
  static const requiredTapCount = 10;

  Future<void> requestEnable(WidgetRef ref, BuildContext context) async {
    if (ref.read(debugProvider).value ?? false) {
      return;
    }
    final isAgreed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DebugModeWarningDialog(),
    );
    if (isAgreed != true) {
      return;
    }
    await ref.read(debugProvider.notifier).save(isEnabled: true);
  }

  Future<void> disable(WidgetRef ref, BuildContext context) async {
    await ref.read(debugProvider.notifier).save(isEnabled: false);
    if (!context.mounted) {
      return;
    }
    const SettingsRoute().go(context);
  }
}
