import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_repository.g.dart';

@Riverpod(keepAlive: true)
PermissionRepository permissionRepository(Ref ref) => PermissionRepository(
  readMessaging: () => ref.read(firebaseMessagingProvider),
);

class PermissionRepository {
  const PermissionRepository({
    required FirebaseMessaging Function() readMessaging,
  }) : _readMessaging = readMessaging;

  final FirebaseMessaging Function() _readMessaging;

  Future<OsNotificationPermission> getNotificationPermission() async {
    final settings = await _readMessaging().getNotificationSettings();
    return settings.toOsNotificationPermission();
  }

  Future<LocationPermission> getLocationPermission() async {
    return Geolocator.checkPermission();
  }

  Future<bool> requestNotificationPermission() async {
    final settings = await _readMessaging().requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<bool> requestCriticalAlertPermission() async {
    final settings = await _readMessaging().requestPermission(
      criticalAlert: true,
    );
    return settings.criticalAlert == AppleNotificationSetting.enabled;
  }

  Future<bool> requestForegroundLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> requestBackgroundLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always;
  }
}
