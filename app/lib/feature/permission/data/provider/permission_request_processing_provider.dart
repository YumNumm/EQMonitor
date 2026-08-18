import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_request_processing_provider.g.dart';

/// [PermissionNotifier] のいずれかの許可リクエストが実行中かどうか。
@riverpod
bool permissionRequestProcessing(Ref ref) =>
    ref.watch(PermissionNotifier.requestNotificationMutation)
        is MutationPending ||
    ref.watch(PermissionNotifier.requestCriticalAlertMutation)
        is MutationPending ||
    ref.watch(PermissionNotifier.requestForegroundLocationMutation)
        is MutationPending ||
    ref.watch(PermissionNotifier.requestBackgroundLocationMutation)
        is MutationPending;
