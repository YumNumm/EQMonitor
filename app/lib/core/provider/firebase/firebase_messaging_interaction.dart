import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'firebase_messaging_interaction.g.dart';

String? _pendingNotificationEventId;

String? consumePendingNotificationEventId() {
  final eventId = _pendingNotificationEventId;
  _pendingNotificationEventId = null;
  return eventId;
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
    final eventId = initialMessage.data['eventId'] as String?;
    if (eventId != null) {
      _pendingNotificationEventId = eventId;
    }
    yield initialMessage;
  }

  await for (final message in FirebaseMessaging.onMessageOpenedApp) {
    await _recordNotificationOpened(
      recorder,
      uploader,
      message,
      coldStart: false,
    );
    final eventId = message.data['eventId'] as String?;
    if (eventId != null) {
     await ref
          .read(goRouterProvider)
          .push(EarthquakeHistoryDetailsRoute(eventId: eventId).location);
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
