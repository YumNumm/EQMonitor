import 'dart:async';

import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _RecordingFirebaseMessaging extends Fake implements FirebaseMessaging {
  _RecordingFirebaseMessaging({
    AuthorizationStatus authorizationStatus = AuthorizationStatus.denied,
  }) : settings = _notificationSettings(
         authorizationStatus: authorizationStatus,
       );

  final tokenRefreshController = StreamController<String>.broadcast();
  NotificationSettings settings;
  int requestPermissionCalls = 0;
  int getTokenCalls = 0;

  @override
  Future<NotificationSettings> getNotificationSettings() async => settings;

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) async {
    requestPermissionCalls++;
    return settings;
  }

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async {
    getTokenCalls++;
    return 'unexpected-fcm-token';
  }

  @override
  Stream<String> get onTokenRefresh => tokenRefreshController.stream;
}

class _RecordingTokenStreams {
  _RecordingTokenStreams() {
    fcm = StreamController<String>(
      onListen: () => fcmListenCount++,
      onCancel: () => fcmCancelCount++,
    );
    apns = StreamController<String>(
      onListen: () => apnsListenCount++,
      onCancel: () => apnsCancelCount++,
    );
    pushToStart = StreamController<String>(
      onListen: () => pushToStartListenCount++,
      onCancel: () => pushToStartCancelCount++,
    );
  }

  late final StreamController<String> fcm;
  late final StreamController<String> apns;
  late final StreamController<String> pushToStart;
  int fcmListenCount = 0;
  int apnsListenCount = 0;
  int pushToStartListenCount = 0;
  int fcmCancelCount = 0;
  int apnsCancelCount = 0;
  int pushToStartCancelCount = 0;

  void addTokens() {
    fcm.add('fcm-token');
    apns.add('apns-token');
    pushToStart.add('push-to-start-token');
  }

  void addLateTokens() {
    fcm.add('late-fcm-token');
    apns.add('late-apns-token');
    pushToStart.add('late-push-to-start-token');
  }

  Future<void> close() async {
    await Future.wait([
      if (fcm.hasListener) fcm.close(),
      if (apns.hasListener) apns.close(),
      if (pushToStart.hasListener) pushToStart.close(),
    ]);
  }
}

NotificationSettings _notificationSettings({
  required AuthorizationStatus authorizationStatus,
}) {
  return NotificationSettings(
    alert: AppleNotificationSetting.notSupported,
    announcement: AppleNotificationSetting.notSupported,
    authorizationStatus: authorizationStatus,
    badge: AppleNotificationSetting.notSupported,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.notSupported,
    notificationCenter: AppleNotificationSetting.notSupported,
    showPreviews: AppleShowPreviewSetting.notSupported,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: AppleNotificationSetting.notSupported,
    sound: AppleNotificationSetting.notSupported,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );
}

void main() {
  const expectedToken = NotificationToken(
    fcmToken: 'fcm-token',
    apnsToken: 'apns-token',
    apnsPushToStartToken: 'push-to-start-token',
  );

  for (final status in [
    AuthorizationStatus.denied,
    AuthorizationStatus.notDetermined,
  ]) {
    test('$status では権限要求も Token 取得もしない', () async {
      final firebaseMessaging = _RecordingFirebaseMessaging();
      final tokenStreams = _RecordingTokenStreams();
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(authorizationStatus: status),
      );
      final container = ProviderContainer(
        overrides: [
          firebaseMessagingProvider.overrideWithValue(firebaseMessaging),
          osNotificationPermissionProvider.overrideWith(
            (ref) async => permission,
          ),
          notificationTokenApnsSupportedProvider.overrideWithValue(true),
          firebaseMessagingTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.fcm.stream,
          ),
          apnsTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.apns.stream,
          ),
          apnsPushToStartTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.pushToStart.stream,
          ),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(firebaseMessaging.tokenRefreshController.close);
      addTearDown(tokenStreams.close);

      final firstToken = Completer<NotificationToken>();
      container.listen(notificationTokenStreamProvider, (_, next) {
        next.whenData((token) {
          if (!firstToken.isCompleted) {
            firstToken.complete(token);
          }
        });
      });
      final token = await firstToken.future;

      expect(firebaseMessaging.requestPermissionCalls, 0);
      expect(token, const NotificationToken());
      expect(tokenStreams.fcmListenCount, 0);
      expect(tokenStreams.apnsListenCount, 0);
      expect(tokenStreams.pushToStartListenCount, 0);
    });
  }

  for (final status in [
    AuthorizationStatus.authorized,
    AuthorizationStatus.provisional,
  ]) {
    test('$status では3種類の Token を取得する', () async {
      final firebaseMessaging = _RecordingFirebaseMessaging();
      final tokenStreams = _RecordingTokenStreams()..addTokens();
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(authorizationStatus: status),
      );
      final container = ProviderContainer(
        overrides: [
          firebaseMessagingProvider.overrideWithValue(firebaseMessaging),
          osNotificationPermissionProvider.overrideWith(
            (ref) async => permission,
          ),
          notificationTokenApnsSupportedProvider.overrideWithValue(true),
          firebaseMessagingTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.fcm.stream,
          ),
          apnsTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.apns.stream,
          ),
          apnsPushToStartTokenStreamProvider.overrideWith(
            (ref) => tokenStreams.pushToStart.stream,
          ),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(firebaseMessaging.tokenRefreshController.close);
      addTearDown(tokenStreams.close);

      final firstToken = Completer<NotificationToken>();
      container.listen(notificationTokenStreamProvider, (_, next) {
        next.whenData((token) {
          if (token == expectedToken && !firstToken.isCompleted) {
            firstToken.complete(token);
          }
        });
      });
      final token = await firstToken.future;

      expect(token, expectedToken);
      expect(firebaseMessaging.requestPermissionCalls, 0);
      expect(tokenStreams.fcmListenCount, 1);
      expect(tokenStreams.apnsListenCount, 1);
      expect(tokenStreams.pushToStartListenCount, 1);
    });
  }

  test('権限が denied から provisional に変わると同じ Container で Token を取得する', () async {
    final firebaseMessaging = _RecordingFirebaseMessaging();
    final tokenStreams = _RecordingTokenStreams()..addTokens();
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(firebaseMessaging),
        notificationTokenApnsSupportedProvider.overrideWithValue(true),
        firebaseMessagingTokenStreamProvider.overrideWith(
          (ref) => tokenStreams.fcm.stream,
        ),
        apnsTokenStreamProvider.overrideWith((ref) => tokenStreams.apns.stream),
        apnsPushToStartTokenStreamProvider.overrideWith(
          (ref) => tokenStreams.pushToStart.stream,
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(firebaseMessaging.tokenRefreshController.close);
    addTearDown(tokenStreams.close);

    final deniedToken = Completer<NotificationToken>();
    final acquiredToken = Completer<NotificationToken>();
    container.listen(notificationTokenStreamProvider, (_, next) {
      if (next.value case final token?) {
        if (token == const NotificationToken() && !deniedToken.isCompleted) {
          deniedToken.complete(token);
        }
        if (token == expectedToken && !acquiredToken.isCompleted) {
          acquiredToken.complete(token);
        }
      }
    });

    expect(await deniedToken.future, const NotificationToken());
    expect(tokenStreams.fcmListenCount, 0);

    firebaseMessaging.settings = _notificationSettings(
      authorizationStatus: AuthorizationStatus.provisional,
    );
    container.invalidate(osNotificationPermissionProvider);

    expect(await acquiredToken.future, expectedToken);
    expect(firebaseMessaging.requestPermissionCalls, 0);
    expect(tokenStreams.fcmListenCount, 1);
    expect(tokenStreams.apnsListenCount, 1);
    expect(tokenStreams.pushToStartListenCount, 1);
  });

  test('権限が authorized から denied に変わると child Token 購読を解除する', () async {
    const lateToken = NotificationToken(
      fcmToken: 'late-fcm-token',
      apnsToken: 'late-apns-token',
      apnsPushToStartToken: 'late-push-to-start-token',
    );
    final firebaseMessaging = _RecordingFirebaseMessaging(
      authorizationStatus: AuthorizationStatus.authorized,
    );
    final tokenStreams = _RecordingTokenStreams()..addTokens();
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(firebaseMessaging),
        notificationTokenApnsSupportedProvider.overrideWithValue(true),
        firebaseMessagingTokenStreamProvider.overrideWith(
          (ref) => tokenStreams.fcm.stream,
        ),
        apnsTokenStreamProvider.overrideWith((ref) => tokenStreams.apns.stream),
        apnsPushToStartTokenStreamProvider.overrideWith(
          (ref) => tokenStreams.pushToStart.stream,
        ),
      ],
    );
    addTearDown(tokenStreams.close);
    addTearDown(firebaseMessaging.tokenRefreshController.close);
    addTearDown(container.dispose);

    final acquiredToken = Completer<void>();
    final deniedToken = Completer<void>();
    final emissions = <NotificationToken>[];
    var permissionChangedToDenied = false;
    container.listen(notificationTokenStreamProvider, (_, next) {
      if (next.value case final token?) {
        emissions.add(token);
        if (token == expectedToken && !acquiredToken.isCompleted) {
          acquiredToken.complete();
        }
        if (permissionChangedToDenied &&
            token == const NotificationToken() &&
            !deniedToken.isCompleted) {
          deniedToken.complete();
        }
      }
    });

    await acquiredToken.future;
    permissionChangedToDenied = true;
    firebaseMessaging.settings = _notificationSettings(
      authorizationStatus: AuthorizationStatus.denied,
    );
    container.invalidate(osNotificationPermissionProvider);
    await deniedToken.future;
    await pumpEventQueue();

    expect(tokenStreams.fcmCancelCount, 1);
    expect(tokenStreams.apnsCancelCount, 1);
    expect(tokenStreams.pushToStartCancelCount, 1);

    tokenStreams.addLateTokens();
    await pumpEventQueue();

    expect(emissions, isNot(contains(lateToken)));
  });
}
