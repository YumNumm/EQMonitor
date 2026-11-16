import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/shake_detection_settings_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/shake_detection_enablement_checker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_notice_agreement_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/shake_detection_notice_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ShakeDetectionEnableFlow() {
  /// 注意事項に未同意の場合は確認ダイアログを表示し、同意したかどうかを返す。
  ///
  /// 通知と端末内の表示は同じ注意事項を使うため、同意は共通で 1 回だけ求める。
  Future<bool> ensureAgreed({
    required WidgetRef ref,
    required BuildContext context,
    String? description,
  }) async {
    if (await ref.read(shakeDetectionNoticeAgreedProvider.future)) {
      return true;
    }
    if (!context.mounted) {
      return false;
    }
    final agreed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => description == null
          ? const ShakeDetectionNoticeDialog()
          : ShakeDetectionNoticeDialog(description: description),
    );
    if (agreed != true || !context.mounted) {
      return false;
    }
    try {
      await ShakeDetectionNoticeAgreed.agreeMutation.run(
        ref,
        (tsx) async =>
            tsx.get(shakeDetectionNoticeAgreedProvider.notifier).agree(),
      );
    } catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'Failed to persist shake detection notice agreement',
      );
    }
    return true;
  }

  Future<void> setSlotEnabled({
    required WidgetRef ref,
    required BuildContext context,
    required NotificationSlot slot,
    required bool enabled,
  }) async {
    if (enabled && !await ensureAgreed(ref: ref, context: context)) {
      return;
    }
    await const ShakeDetectionSettingsAction().setSlotEnabled(
      ref,
      slot: slot,
      enabled: enabled,
    );
  }

  Future<void> save({
    required WidgetRef ref,
    required BuildContext context,
    required List<ShakeDetectionEntry> previous,
    required List<ShakeDetectionEntry> next,
  }) async {
    final requiresAgreement = const ShakeDetectionEnablementChecker()
        .enablesAny(previous: previous, next: next);
    if (requiresAgreement && !await ensureAgreed(ref: ref, context: context)) {
      return;
    }
    await const ShakeDetectionSettingsAction().save(ref, next);
  }
}
