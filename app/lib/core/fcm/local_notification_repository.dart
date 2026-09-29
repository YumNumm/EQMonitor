import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/fcm/android_notification_channel_initializer.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:eqmonitor/core/fcm/foreground_notification_payload_codec.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationRepository {
  new({
    required this.plugin,
    required this.channelInitializer,
    required this.isAndroid,
    required Stream<RemoteMessage> foregroundMessages,
  }) : _foregroundMessages = foregroundMessages;

  factory forCurrentPlatform() => LocalNotificationRepository(
    plugin: FlutterLocalNotificationsPlugin(),
    channelInitializer:
        AndroidNotificationChannelInitializer.forCurrentPlatform(),
    isAndroid: !kIsWeb && defaultTargetPlatform == TargetPlatform.android,
    foregroundMessages: FirebaseMessaging.onMessage,
  );

  final FlutterLocalNotificationsPlugin plugin;
  final AndroidNotificationChannelInitializer channelInitializer;
  final bool isAndroid;
  final Stream<RemoteMessage> _foregroundMessages;
  final _openedMessages = StreamController<RemoteMessage>.broadcast();
  Future<void>? _initialization;
  var _nextNotificationId = 0;

  Stream<RemoteMessage> get foregroundMessages =>
      isAndroid ? _foregroundMessages : const Stream.empty();

  Stream<RemoteMessage> get openedMessages => _openedMessages.stream;

  Future<void> initialize() => _initialization ??= initializePlatform();

  Future<void> initializePlatform() async {
    await channelInitializer.initialize();
    await plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification_icon'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
        macOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: handleResponse,
    );
  }

  Future<RemoteMessage?> getInitialMessage() async {
    if (!isAndroid) {
      return null;
    }
    await initialize();
    final details = await plugin.getNotificationAppLaunchDetails();
    return details?.didNotificationLaunchApp == true
        ? const ForegroundNotificationPayloadCodec().decode(
            details?.notificationResponse?.payload,
          )
        : null;
  }

  void handleResponse(NotificationResponse response) {
    final message = const ForegroundNotificationPayloadCodec().decode(
      response.payload,
    );
    if (message != null && !_openedMessages.isClosed) {
      _openedMessages.add(message);
    }
  }

  Future<void> showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (!isAndroid || notification == null) {
      return;
    }
    await initialize();
    final android = notification.android;
    final channel = await resolveChannel(android?.channelId);
    final tag = android?.tag;
    final identity = tag != null && tag.isNotEmpty ? tag : message.messageId;
    await plugin.show(
      id: (identity?.hashCode ?? _nextNotificationId++) & 0x7fffffff,
      title: notification.title,
      body: notification.body,
      payload: const ForegroundNotificationPayloadCodec().encode(message),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: channel.importance,
          priority: switch (channel.importance) {
            Importance.max || Importance.high => Priority.high,
            Importance.low => Priority.low,
            Importance.min || Importance.none => Priority.min,
            _ => Priority.defaultPriority,
          },
          playSound: channel.playSound,
          sound: channel.sound,
          enableVibration: channel.enableVibration,
          vibrationPattern: channel.vibrationPattern,
          icon: 'ic_notification_icon',
          tag: tag,
          styleInformation: BigTextStyleInformation(notification.body ?? ''),
        ),
      ),
    );
  }

  Future<AndroidNotificationChannel> resolveChannel(String? requestedId) async {
    final migratedId = switch (requestedId) {
      'test' => 'service_test',
      'test_critical' => 'service_test_critical',
      _ => requestedId,
    };
    final id = migratedId == null || migratedId.isEmpty
        ? 'service_fallback'
        : migratedId;
    final registered = notificationChannels.firstWhereOrNull((c) => c.id == id);
    if (registered != null) {
      return registered;
    }
    final existing = await plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.getNotificationChannels();
    final channel = existing?.firstWhereOrNull((c) => c.id == id);
    // FCM と同じく、指定 channel が OS に存在しなければ Manifest の既定値を使う。
    return channel ??
        notificationChannels.firstWhere((c) => c.id == 'service_fallback');
  }

  Future<void> dispose() => _openedMessages.close();
}
