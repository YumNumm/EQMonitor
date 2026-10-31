import 'dart:async';

import 'package:eqmonitor/core/fcm/local_notification_repository.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_messaging_foreground.g.dart';

@Riverpod(keepAlive: true)
LocalNotificationRepository localNotificationRepository(Ref ref) {
  final repository = LocalNotificationRepository.forCurrentPlatform();
  ref.onDispose(() => unawaited(repository.dispose()));
  return repository;
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingForeground(Ref ref) async* {
  final repository = ref.watch(localNotificationRepositoryProvider);
  ref.listen(isShakeDetectionNotificationAvailableProvider, (_, _) {});
  await for (final message in repository.foregroundMessages) {
    try {
      if (message.notification?.android?.channelId == 'shake_detection') {
        final availability = ref.read(
          isShakeDetectionNotificationAvailableProvider,
        );
        if (availability.isLoading ||
            availability.hasError ||
            availability.value != true) {
          continue;
        }
      }
      await repository.showForegroundNotification(message);
    } on Object catch (error, stackTrace) {
      talker.error('Foreground notification display failed', error, stackTrace);
    }
    yield message;
  }
}
