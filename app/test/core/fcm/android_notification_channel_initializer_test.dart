import 'dart:async';

import 'package:eqmonitor/core/fcm/android_notification_channel_initializer.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('awaits legacy deletes, groups, and channels in exact order', () async {
    final platform = _BlockingFakeAndroidNotificationChannelPlatform();
    var completed = false;
    final initialization = AndroidNotificationChannelInitializer(
      platform: platform,
    ).initialize().whenComplete(() => completed = true);
    final expected = [
      for (final id in legacyNotificationChannelIds) 'delete:$id',
      for (final group in notificationChannelGroups) 'group:${group.id}',
      for (final channel in notificationChannels) 'channel:${channel.id}',
    ];

    for (var index = 0; index < expected.length; index++) {
      await Future<void>.delayed(Duration.zero);
      expect(platform.operations, expected.take(index + 1));
      expect(platform.hasPendingOperation, isTrue);
      expect(completed, isFalse);
      platform.completePendingOperation();
    }

    await initialization;
    expect(platform.operations, expected);
    expect(platform.hasPendingOperation, isFalse);
    expect(completed, isTrue);
  });
}

class _BlockingFakeAndroidNotificationChannelPlatform
    implements AndroidNotificationChannelPlatform {
  final operations = <String>[];
  Completer<void>? _pendingOperation;

  bool get hasPendingOperation => _pendingOperation != null;

  @override
  Future<void> createChannel(AndroidNotificationChannel channel) =>
      recordOperation('channel:${channel.id}');

  @override
  Future<void> createGroup(AndroidNotificationChannelGroup group) =>
      recordOperation('group:${group.id}');

  @override
  Future<void> deleteChannel(String id) => recordOperation('delete:$id');

  void completePendingOperation() {
    final pendingOperation = _pendingOperation;
    if (pendingOperation == null) {
      throw StateError('No operation is pending');
    }
    pendingOperation.complete();
  }

  Future<void> recordOperation(String operation) {
    if (_pendingOperation != null) {
      throw StateError('Operations must be awaited sequentially');
    }
    operations.add(operation);
    final pendingOperation = Completer<void>();
    _pendingOperation = pendingOperation;
    return pendingOperation.future.whenComplete(() => _pendingOperation = null);
  }
}
