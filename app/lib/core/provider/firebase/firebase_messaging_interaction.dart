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

NotificationDeepLink? _pendingNotificationDeepLink;

NotificationDeepLink? consumePendingNotificationDeepLink() {
  final link = _pendingNotificationDeepLink;
  _pendingNotificationDeepLink = null;
  return link;
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingInteraction(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  final recorder = ref.read(telemetryRecorderProvider);
  final uploader = ref.read(telemetryUploaderProvider);

  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    await _recordNotificationOpened(
      recorder,
      uploader,
      initialMessage,
      coldStart: true,
    );
    _pendingNotificationDeepLink = NotificationDeepLink.fromData(
      initialMessage.data,
    );
    yield initialMessage;
  }

  await for (final message in FirebaseMessaging.onMessageOpenedApp) {
    await _recordNotificationOpened(
      recorder,
      uploader,
      message,
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

Future<void> _recordNotificationOpened(
  TelemetryRecorder recorder,
  TelemetryUploader uploader,
  RemoteMessage message, {
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
