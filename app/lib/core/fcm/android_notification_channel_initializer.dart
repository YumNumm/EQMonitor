import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class AndroidNotificationChannelPlatform {
  Future<void> deleteChannel(String id);

  Future<void> createGroup(AndroidNotificationChannelGroup group);

  Future<void> createChannel(AndroidNotificationChannel channel);
}

class AndroidNotificationChannelInitializer {
  const AndroidNotificationChannelInitializer({required this.platform});

  factory AndroidNotificationChannelInitializer.forCurrentPlatform() {
    if (kIsWeb) {
      return const AndroidNotificationChannelInitializer(
        platform: NoopAndroidNotificationChannelPlatform(),
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
    );
  }

  factory AndroidNotificationChannelInitializer.forPlatform({
    required TargetPlatform targetPlatform,
    required AndroidFlutterLocalNotificationsPlugin? androidPlugin,
  }) {
    if (targetPlatform != TargetPlatform.android) {
      return const AndroidNotificationChannelInitializer(
        platform: NoopAndroidNotificationChannelPlatform(),
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
    );
  }

  final AndroidNotificationChannelPlatform platform;

  Future<void> initialize() async {
    final activeChannelIds = notificationChannels
        .map((channel) => channel.id)
        .toSet();
    for (final id in legacyNotificationChannelIds) {
      if (activeChannelIds.contains(id)) {
        continue;
      }
      await platform.deleteChannel(id);
    }
    for (final group in notificationChannelGroups) {
      await platform.createGroup(group);
    }
    for (final channel in notificationChannels) {
      await platform.createChannel(channel);
    }
  }
}

class AndroidFlutterLocalNotificationsChannelPlatform
    implements AndroidNotificationChannelPlatform {
  const AndroidFlutterLocalNotificationsChannelPlatform({required this.plugin});

  final AndroidFlutterLocalNotificationsPlugin plugin;

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

class NoopAndroidNotificationChannelPlatform
    implements AndroidNotificationChannelPlatform {
  const NoopAndroidNotificationChannelPlatform();

  @override
  Future<void> deleteChannel(String id) async {}

  @override
  Future<void> createGroup(AndroidNotificationChannelGroup group) async {}

  @override
  Future<void> createChannel(AndroidNotificationChannel channel) async {}
}
