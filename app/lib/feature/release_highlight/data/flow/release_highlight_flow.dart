import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/release_highlight/data/model/release_highlight.dart';
import 'package:eqmonitor/feature/release_highlight/data/notifier/release_highlight_seen_version_notifier.dart';
import 'package:eqmonitor/feature/subscription/ui/component/shake_detection_notification_detail_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ReleaseHighlightFlow() {
  Future<void> dismiss({required WidgetRef ref}) async {
    final version = ref.read(packageInfoProvider).version;
    try {
      await ReleaseHighlightSeenVersion.markSeenMutation.run(
        ref,
        (tsx) async => tsx
            .get(releaseHighlightSeenVersionProvider.notifier)
            .markSeen(version),
      );
    } catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'Failed to persist release highlight seen version',
      );
    }
  }

  Future<void> openPrimaryAction({
    required WidgetRef ref,
    required BuildContext context,
    required ReleaseHighlightAction action,
  }) async {
    // 既読にするとカードが外れて context が無効になるため、先に遷移を始める。
    final navigation = switch (action) {
      .aboutPro => const PaywallRoute().push<void>(context),
      .notificationSettings => const NotificationSettingsRoute().push<void>(
        context,
      ),
    };
    await dismiss(ref: ref);
    await navigation;
  }

  Future<void> openChangelog({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final navigation = const ChangelogRoute().push<void>(context);
    await dismiss(ref: ref);
    await navigation;
  }

  Future<void> openDetail({
    required BuildContext context,
    required ReleaseHighlight highlight,
  }) => switch (highlight) {
    .shakeDetectionNotification =>
      const ShakeDetectionNotificationDetailSheetAction().show(context),
  };
}
