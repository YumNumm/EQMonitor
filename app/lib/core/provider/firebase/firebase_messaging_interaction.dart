import 'dart:async';

import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/fcm/pending_notification_deep_link_gate.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_foreground.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';
import 'package:url_launcher/url_launcher.dart';

part 'firebase_messaging_interaction.g.dart';

@Riverpod(keepAlive: true)
PendingNotificationDeepLinkGate pendingNotificationDeepLinkGate(Ref ref) =>
    PendingNotificationDeepLinkGate();

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingInteraction(Ref ref) async* {
  final pendingGate = ref.watch(pendingNotificationDeepLinkGateProvider);
  try {
    if (kIsWeb) {
      return;
    }
    final messaging = ref.watch(firebaseMessagingProvider);
    final recorder = ref.read(telemetryRecorderProvider);
    final uploader = ref.read(telemetryUploaderProvider);
    final localNotifications = ref.watch(localNotificationRepositoryProvider);
    final openedMessages = StreamController<RemoteMessage>();
    final fcmSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
      openedMessages.add,
      onError: openedMessages.addError,
    );
    final localSubscription = localNotifications.openedMessages.listen(
      openedMessages.add,
      onError: openedMessages.addError,
    );
    ref.onDispose(() {
      unawaited(fcmSubscription.cancel());
      unawaited(localSubscription.cancel());
      unawaited(openedMessages.close());
    });

    final initialMessage =
        await Future<RemoteMessage?>.sync(messaging.getInitialMessage).onError((
          error,
          stackTrace,
        ) {
          talker.error(
            'Initial FCM notification lookup failed',
            error,
            stackTrace,
          );
          return null;
        }) ??
        await Future<RemoteMessage?>.sync(
          localNotifications.getInitialMessage,
        ).onError((error, stackTrace) {
          talker.error(
            'Initial local notification lookup failed',
            error,
            stackTrace,
          );
          return null;
        });
    pendingGate.store(
      initialMessage == null
          ? null
          : NotificationDeepLink.fromData(initialMessage.data),
    );
    pendingGate.resolve();
    if (initialMessage != null) {
      unawaited(
        NotificationOpenedRecorder.record(
          recorder: recorder,
          uploader: uploader,
          message: initialMessage,
          coldStart: true,
        ),
      );
      yield initialMessage;
    }
    await for (final message in openedMessages.stream) {
      // 計測は遷移を遅らせず、失敗しても以降の通知タップを止めない。
      unawaited(
        NotificationOpenedRecorder.record(
          recorder: recorder,
          uploader: uploader,
          message: message,
          coldStart: false,
        ),
      );
      final link = NotificationDeepLink.fromData(message.data);
      switch (link) {
        case NotificationRouteLink(:final location):
          await ref.read(goRouterProvider).push(location);
        case NotificationUrlLink(:final uri):
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        case null:
          break;
      }
      yield message;
    }
  } finally {
    pendingGate.resolve();
  }
}

/// FCM 通知タップの計測記録を行う。
class NotificationOpenedRecorder {
  const new _();

  static Future<void> record({
    required TelemetryRecorder recorder,
    required TelemetryUploader uploader,
    required RemoteMessage message,
    required bool coldStart,
  }) async {
    try {
      await recorder.record(
        TelemetryEvent.notificationOpened(
          coldStart: coldStart,
          eventId: message.data['eventId'] as String?,
        ),
      );
      await uploader.flush();
    } on Object catch (error, stackTrace) {
      talker.error('Failed to record notification opened', error, stackTrace);
    }
  }
}
