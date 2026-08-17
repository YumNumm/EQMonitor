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
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return const AndroidNotificationChannelInitializer(
        platform: NoopAndroidNotificationChannelPlatform(),
      );
    }

    final plugin = FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return AndroidNotificationChannelInitializer(
      platform: switch (plugin) {
        final AndroidFlutterLocalNotificationsPlugin plugin =>
          AndroidFlutterLocalNotificationsChannelPlatform(plugin: plugin),
        null => const NoopAndroidNotificationChannelPlatform(),
      },
    );
  }

  final AndroidNotificationChannelPlatform platform;

  Future<void> initialize() async {
    for (final id in legacyNotificationChannelIds) {
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
