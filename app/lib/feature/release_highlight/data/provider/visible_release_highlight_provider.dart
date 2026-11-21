import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/release_highlight/data/logic/release_highlight_selector.dart';
import 'package:eqmonitor/feature/release_highlight/data/model/release_highlight.dart';
import 'package:eqmonitor/feature/release_highlight/data/notifier/release_highlight_seen_version_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_access_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visible_release_highlight_provider.g.dart';

/// ホームに表示する新機能の案内。表示するものが無ければ null。
///
/// 案内する機能をこの端末で使えない間は表示せず、既読にもしない。
@riverpod
VisibleReleaseHighlight? visibleReleaseHighlight(Ref ref) {
  final seenVersion = ref.watch(releaseHighlightSeenVersionProvider);
  if (seenVersion is! AsyncData<String?>) {
    return null;
  }
  final candidates = const ReleaseHighlightSelector().select(
    currentVersion: ref.watch(packageInfoProvider).version,
    seenVersion: seenVersion.value,
  );
  for (final highlight in candidates) {
    final primaryAction = switch (highlight) {
      .shakeDetectionNotification => switch (ref.watch(
        shakeDetectionNotificationAccessProvider,
      )) {
        .hidden => null,
        .editable => ReleaseHighlightAction.notificationSettings,
      },
    };
    if (primaryAction != null) {
      return (highlight: highlight, primaryAction: primaryAction);
    }
  }
  return null;
}
