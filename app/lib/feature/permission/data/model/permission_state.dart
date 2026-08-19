import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_state.freezed.dart';

@freezed
abstract class PermissionState with _$PermissionState {
  const factory({
    required bool isNotificationGranted,
    required bool isCriticalAlertSupported,
    required bool isCriticalAlertGranted,
    required bool isForegroundLocationGranted,
    required bool isBackgroundLocationGranted,
  }) = _PermissionState;
}
