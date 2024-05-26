import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/lib.dart';
import 'package:eqapi_types/model/v1/auth/notification_settings_request.dart';
import 'package:eqmonitor/core/api/api_authentication_service.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/earthquake/earthquake_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/children/config/notification/eew/eew_notification_settings_view_model.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/notification_remote_settings.dart';
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
    if (!isMigrated) {
      await _migrate();
    }

    yield NotificationRemoteSettingsSetupState.completed;
  }

  Future<void> _migrate() async {
    final currentSettings = (
      earthquake: ref.read(earthquakeNotificationSettingsViewModelProvider),
      eew: ref.read(eewNotificationsSettingsViewModelProvider),
    );

    // earthquakeから
    try {
      final intensity = currentSettings.earthquake?.topic
          .replaceAll('earthquake_', '')
          .replaceAll('lower', '-')
          .replaceAll('upper', '+');
      final jmaIntensity =
          JmaIntensity.values.firstWhereOrNull((i) => i.type == intensity);
      final isAll = intensity == 'all';
      if (jmaIntensity != null || isAll) {
        final request = NotificationSettingsRequest(
          global: (jmaIntensity != null || isAll)
              ? NotificationSettingsGlobal(
                  minJmaIntensity: switch (jmaIntensity) {
                    JmaIntensity.one => JmaForecastIntensity.one,
                    JmaIntensity.two => JmaForecastIntensity.two,
                    JmaIntensity.three => JmaForecastIntensity.three,
                    JmaIntensity.four => JmaForecastIntensity.four,
                    JmaIntensity.fiveLower => JmaForecastIntensity.fiveLower,
                    JmaIntensity.fiveUpper => JmaForecastIntensity.fiveUpper,
                    JmaIntensity.sixLower => JmaForecastIntensity.sixLower,
                    JmaIntensity.sixUpper => JmaForecastIntensity.sixUpper,
                    JmaIntensity.seven => JmaForecastIntensity.seven,
                    _ when isAll => JmaForecastIntensity.zero,
                    _ => throw Exception('Unexpected intensity'),
                  },
                )
              : null,
        );
        await ref
            .read(notificationRemoteSettingsNotifierProvider.notifier)
            .updateEarthquake(
              request: request,
            );
        log(
          'Migrated Earthquake : $intensity',
          name: 'NotificationRemoteSettingsInitialSetupNotifier',
        );
      }
    } on Exception catch (e) {
      log(
        'Failed to migrate Earthquake : $e',
        name: 'NotificationRemoteSettingsInitialSetupNotifier',
      );
    }
    await Future<void>.delayed(const Duration(seconds: 1));
    ref.invalidate(notificationRemoteSettingsNotifierProvider);

    // EEW
    try {
      final intensity = currentSettings.eew?.topic
          .replaceAll('eew', '')
          .replaceAll('_', '')
          .replaceAll('lower', '-')
          .replaceAll('upper', '+');
      final jmaIntensity =
          JmaIntensity.values.firstWhereOrNull((i) => i.type == intensity);
      final isAll = intensity == 'all';
      final request = NotificationSettingsRequest(
        global: (jmaIntensity != null || isAll)
            ? NotificationSettingsGlobal(
                minJmaIntensity: switch (jmaIntensity) {
                  JmaIntensity.one => JmaForecastIntensity.one,
                  JmaIntensity.two => JmaForecastIntensity.two,
                  JmaIntensity.three => JmaForecastIntensity.three,
                  JmaIntensity.four => JmaForecastIntensity.four,
                  JmaIntensity.fiveLower => JmaForecastIntensity.fiveLower,
                  JmaIntensity.fiveUpper => JmaForecastIntensity.fiveUpper,
                  JmaIntensity.sixLower => JmaForecastIntensity.sixLower,
                  JmaIntensity.sixUpper => JmaForecastIntensity.sixUpper,
                  JmaIntensity.seven => JmaForecastIntensity.seven,
                  _ when isAll => JmaForecastIntensity.zero,
                  _ => throw Exception('Unexpected intensity'),
                },
              )
            : null,
      );
      await ref
          .read(notificationRemoteSettingsNotifierProvider.notifier)
          .updateEew(
            request: request,
          );
      log(
        'Migrated EEW : $intensity',
        name: 'NotificationRemoteSettingsInitialSetupNotifier',
      );
    } on Exception catch (e) {
      log(
        'Failed to migrate EEW : $e',
        name: 'NotificationRemoteSettingsInitialSetupNotifier',
      );
    }

    await _setIsMigrated();
  }

  Future<void> unsubscribeOldTopics() async {
    final registeredTopics = ref.read(fcmTopicManagerProvider);
    final excludeTopics = [
      FcmBasicTopic(FcmTopics.all),
    ];
    final topics =
        registeredTopics.where((t) => !excludeTopics.contains(t)).toList();
    final messaging = ref.read(firebaseMessagingProvider);
    final futures = <Future<void>>[];
    for (final topic in topics) {
      futures.add(messaging.unsubscribeFromTopic(topic));
    }
    await Future.wait(futures);
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
  completed,
  ;
}

class NotificationRemoteSettingsSetupException implements Exception {
  NotificationRemoteSettingsSetupException({required this.message});

  final String message;
}
