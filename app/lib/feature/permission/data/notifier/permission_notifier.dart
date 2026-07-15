import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_state.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_notifier.g.dart';

/// アプリで利用する権限の状態を保持する Notifier。
///
/// 初期化時に OS の権限状態を読み取り、既に許可済みの権限は granted として反映する。
@Riverpod(keepAlive: true)
class PermissionNotifier extends _$PermissionNotifier {
  static final requestNotificationMutation = Mutation<bool>();
  static final requestCriticalAlertMutation = Mutation<bool>();
  static final requestForegroundLocationMutation = Mutation<bool>();
  static final requestBackgroundLocationMutation = Mutation<bool>();

  @override
  Future<PermissionState> build() async {
    return _loadFromOs();
  }

  Future<PermissionState> _loadFromOs() async {
    final repository = ref.read(permissionRepositoryProvider);
    final notification = await repository.getNotificationPermission();
    final location = await repository.getLocationPermission();
    return PermissionState.fromOs(
      notification: notification,
      location: location,
    );
  }

  Future<bool> requestNotification() async {
    final repository = ref.read(permissionRepositoryProvider);
    final isGranted = await repository.requestNotificationPermission();
    ref.invalidate(osNotificationPermissionProvider);
    final current = state.requireValue;
    if (isGranted) {
      state = AsyncData(current.grantNotification());
    }
    return isGranted;
  }

  Future<bool> requestCriticalAlert() async {
    final repository = ref.read(permissionRepositoryProvider);
    final isGranted = await repository.requestCriticalAlertPermission();
    final current = state.requireValue;
    if (isGranted) {
      state = AsyncData(current.grantCriticalAlert());
    }
    return isGranted;
  }

  Future<bool> requestForegroundLocation() async {
    final repository = ref.read(permissionRepositoryProvider);
    final isGranted = await repository.requestForegroundLocationPermission();
    final current = state.requireValue;
    if (isGranted) {
      state = AsyncData(current.grantForegroundLocation());
    }
    return isGranted;
  }

  Future<bool> requestBackgroundLocation() async {
    final repository = ref.read(permissionRepositoryProvider);
    final isGranted = await repository.requestBackgroundLocationPermission();
    final current = state.requireValue;
    if (isGranted) {
      state = AsyncData(current.grantBackgroundLocation());
    }
    return isGranted;
  }

  void skipNotification() {
    state = AsyncData(state.requireValue.skipNotification());
  }

  void skipCriticalAlert() {
    state = AsyncData(state.requireValue.skipCriticalAlert());
  }

  void skipForegroundLocation() {
    state = AsyncData(state.requireValue.skipForegroundLocation());
  }

  void skipBackgroundLocation() {
    state = AsyncData(state.requireValue.skipBackgroundLocation());
  }
}
