import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class AndroidNotificationChannelPlatform {
  Future<void> deleteChannel(String id);

  Future<void> createGroup(AndroidNotificationChannelGroup group);

  Future<void> createChannel(AndroidNotificationChannel channel);
}

class AndroidNotificationChannelInitializer {
  const new({required this.platform, this.isShakeDetectionEnabled = true});

  factory forCurrentPlatform({bool isShakeDetectionEnabled = true}) {
    if (kIsWeb) {
      return AndroidNotificationChannelInitializer(
        platform: const NoopAndroidNotificationChannelPlatform(),
        isShakeDetectionEnabled: isShakeDetectionEnabled,
      );
    }

    final targetPlatform = defaultTargetPlatform;
    final androidPlugin = targetPlatform == TargetPlatform.android
        ? FlutterLocalNotificationsPlugin()
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
        : null;
    return AndroidNotificationChannelInitializer.forPlatform(
      targetPlatform: targetPlatform,
      androidPlugin: androidPlugin,
      isShakeDetectionEnabled: isShakeDetectionEnabled,
    );
  }

  factory forPlatform({
    required TargetPlatform targetPlatform,
    required AndroidFlutterLocalNotificationsPlugin? androidPlugin,
    bool isShakeDetectionEnabled = true,
  }) {
    if (targetPlatform != TargetPlatform.android) {
      return AndroidNotificationChannelInitializer(
        platform: const NoopAndroidNotificationChannelPlatform(),
        isShakeDetectionEnabled: isShakeDetectionEnabled,
      );
    }
    if (androidPlugin == null) {
      throw StateError(
        'AndroidFlutterLocalNotificationsPlugin is unavailable on Android',
      );
    }
    return AndroidNotificationChannelInitializer(
      platform: AndroidFlutterLocalNotificationsChannelPlatform(
        plugin: androidPlugin,
      ),
      isShakeDetectionEnabled: isShakeDetectionEnabled,
    );
  }

  final AndroidNotificationChannelPlatform platform;
  final bool isShakeDetectionEnabled;

  Future<void> initialize() async {
    final activeChannels = notificationChannels.where(
      (channel) => isShakeDetectionEnabled || channel.id != 'shake_detection',
    );
    final activeChannelIds = activeChannels
        .map((channel) => channel.id)
        .toSet();
    if (!isShakeDetectionEnabled) {
      await platform.deleteChannel('shake_detection');
    }
    for (final id in legacyNotificationChannelIds) {
      if (activeChannelIds.contains(id)) {
        continue;
      }
      await platform.deleteChannel(id);
    }
    for (final group in notificationChannelGroups) {
      await platform.createGroup(group);
    }
    for (final channel in activeChannels) {
      await platform.createChannel(channel);
    }
  }
}

class const AndroidFlutterLocalNotificationsChannelPlatform({
  required final AndroidFlutterLocalNotificationsPlugin plugin,
}) implements AndroidNotificationChannelPlatform {
  @override
  Future<void> deleteChannel(String id) =>
      plugin.deleteNotificationChannel(channelId: id);

  @override
  Future<void> createGroup(AndroidNotificationChannelGroup group) =>
      plugin.createNotificationChannelGroup(group);

  @override
  Future<void> createChannel(AndroidNotificationChannel channel) =>
      plugin.createNotificationChannel(channel);
}

class const NoopAndroidNotificationChannelPlatform()
    implements AndroidNotificationChannelPlatform {
  @override
  Future<void> deleteChannel(String id) async {}

  @override
  Future<void> createGroup(AndroidNotificationChannelGroup group) async {}

  @override
  Future<void> createChannel(AndroidNotificationChannel channel) async {}
}
