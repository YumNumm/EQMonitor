import 'dart:async';

import 'package:eqmonitor/core/fcm/local_notification_repository.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_messaging_foreground.g.dart';

@Riverpod(keepAlive: true)
LocalNotificationRepository localNotificationRepository(Ref ref) {
  final repository = LocalNotificationRepository.forCurrentPlatform(
    isShakeDetectionEnabled: ref
        .watch(buildConfigProvider)
        .isShakeDetectionAvailable,
  );
  ref.onDispose(() => unawaited(repository.dispose()));
  return repository;
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingForeground(Ref ref) async* {
  final repository = ref.watch(localNotificationRepositoryProvider);
  await for (final message in repository.foregroundMessages) {
    try {
      await repository.showForegroundNotification(message);
    } on Object catch (error, stackTrace) {
      talker.error('Foreground notification display failed', error, stackTrace);
    }
    yield message;
  }
}
