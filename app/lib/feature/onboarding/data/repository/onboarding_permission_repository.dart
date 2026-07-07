import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_permission_repository.g.dart';

@Riverpod(keepAlive: true)
OnboardingPermissionRepository onboardingPermissionRepository(Ref ref) =>
    OnboardingPermissionRepository(
      readMessaging: () => ref.read(firebaseMessagingProvider),
    );

class OnboardingPermissionRepository {
  const OnboardingPermissionRepository({
    required FirebaseMessaging Function() readMessaging,
  }) : _readMessaging = readMessaging;

  final FirebaseMessaging Function() _readMessaging;

  Future<bool> requestNotificationPermission() async {
    final settings = await _readMessaging().requestPermission();
    final authStatus = settings.authorizationStatus;
    return authStatus == AuthorizationStatus.authorized ||
        authStatus == AuthorizationStatus.provisional;
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
