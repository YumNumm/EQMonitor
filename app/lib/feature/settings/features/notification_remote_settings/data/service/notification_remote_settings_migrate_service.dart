import 'dart:developer';

import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_request.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings_saved_state.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_authentication_service.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_settings_migrate_service.g.dart';

@Riverpod(keepAlive: true)
class NotificationRemoteSettingsInitialSetupNotifier
    extends _$NotificationRemoteSettingsInitialSetupNotifier {
  @override
  Stream<NotificationRemoteSettingsSetupState> build() async* {
    yield NotificationRemoteSettingsSetupState.initial;
    // 既にmigrate済みかどうかを確認
    final isMigrated = _getIsMigrated();
    // Tokenを持っているかどうか確認
    final authorization =
        await ref.read(apiAuthenticationServiceProvider.future);
    if (isMigrated && authorization != null) {
      yield NotificationRemoteSettingsSetupState.completed;
      log(
        'Already migrated',
        name: 'NotificationRemoteSettingsInitialSetupNotifier',
      );
      return;
    }

    yield NotificationRemoteSettingsSetupState.waitingForFcmToken;
    await FirebaseInstallations.instance.delete();
    final token = await ref.read(notificationTokenProvider.future);
    final fcmToken = token.fcmToken;
    if (fcmToken == null) {
      throw NotificationRemoteSettingsSetupException(
        message: 'FCMトークンが取得できませんでした',
      );
    }
    yield NotificationRemoteSettingsSetupState.registering;
    final authenticateService =
        ref.watch(notificationRemoteAuthenticateServiceProvider);
    await authenticateService.authenticate(fcmToken: fcmToken);

    yield NotificationRemoteSettingsSetupState.migrating;
    await ref
        .read(notificationRemoteSettingsSavedStateNotifierProvider.notifier)
        .updateEarthquake(
          request: const NotificationSettingsRequest(
            global: NotificationSettingsGlobal(
              minJmaIntensity: JmaForecastIntensity.zero,
            ),
          ),
        );

    await ref
        .read(notificationRemoteSettingsSavedStateNotifierProvider.notifier)
        .updateEew(
          request: const NotificationSettingsRequest(
            global: NotificationSettingsGlobal(
              minJmaIntensity: JmaForecastIntensity.zero,
            ),
          ),
        );
    await _setIsMigrated();

    yield NotificationRemoteSettingsSetupState.completing;
    await Future<void>.delayed(const Duration(seconds: 1));
    yield NotificationRemoteSettingsSetupState.completed;
  }

  bool _getIsMigrated() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(_isMigratedKey) ?? false;
  }

  Future<void> _setIsMigrated() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_isMigratedKey, true);
  }

  static const _isMigratedKey =
      'NotificationRemoteSettingsInitialSetupNotifier.isMigrated';
}

enum NotificationRemoteSettingsSetupState {
  initial,
  waitingForFcmToken,
  registering,
  migrating,
  unsubscribingOldTopics,
  completing,
  completed,
  ;
}

class NotificationRemoteSettingsSetupException implements Exception {
  NotificationRemoteSettingsSetupException({required this.message});

  final String message;
}
