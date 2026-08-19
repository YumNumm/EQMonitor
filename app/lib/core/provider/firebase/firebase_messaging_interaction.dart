import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';
import 'package:url_launcher/url_launcher.dart';

part 'firebase_messaging_interaction.g.dart';

@Riverpod(keepAlive: true)
PendingNotificationDeepLinkGate pendingNotificationDeepLinkGate(Ref ref) =>
    PendingNotificationDeepLinkGate();

/// FCM 通知タップ時の遷移先を、ルーティング準備が整うまで保持するゲート。
class PendingNotificationDeepLinkGate {
  NotificationDeepLink? _pending;

  void store(NotificationDeepLink? link) {
    _pending = link;
  }

  NotificationDeepLink? consumePending() {
    final link = _pending;
    _pending = null;
    return link;
  }
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingInteraction(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  final recorder = ref.read(telemetryRecorderProvider);
  final uploader = ref.read(telemetryUploaderProvider);
  final pendingGate = ref.watch(pendingNotificationDeepLinkGateProvider);

  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    await NotificationOpenedRecorder.record(
      recorder: recorder,
      uploader: uploader,
      message: initialMessage,
      coldStart: true,
    );
    pendingGate.store(NotificationDeepLink.fromData(initialMessage.data));
    yield initialMessage;
  }

  await for (final message in FirebaseMessaging.onMessageOpenedApp) {
    await NotificationOpenedRecorder.record(
      recorder: recorder,
      uploader: uploader,
      message: message,
      coldStart: false,
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
    await recorder.record(
      TelemetryEvent.notificationOpened(
        coldStart: coldStart,
        eventId: message.data['eventId'] as String?,
      ),
    );
    await uploader.flush();
  }
}
