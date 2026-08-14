import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

/// [PermissionNotifier] のいずれかの許可リクエストが実行中かどうか。
final permissionRequestProcessingProvider = Provider<bool>((ref) {
  return ref.watch(PermissionNotifier.requestNotificationMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestCriticalAlertMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestForegroundLocationMutation)
          is MutationPending ||
      ref.watch(PermissionNotifier.requestBackgroundLocationMutation)
          is MutationPending;
});
