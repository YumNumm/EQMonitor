import 'dart:async';

import 'package:eqmonitor/core/fcm/android_notification_channel_initializer.dart';
import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:flutter/foundation.dart';
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
      for (final id in _deletedLegacyChannelIds) 'delete:$id',
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

  test('never deletes active channel ids', () async {
    final platform = _RecordingAndroidNotificationChannelPlatform();

    await AndroidNotificationChannelInitializer(
      platform: platform,
    ).initialize();

    final deletedIds = platform.operations
        .where((operation) => operation.startsWith('delete:'))
        .map((operation) => operation.substring('delete:'.length));
    expect(deletedIds, _deletedLegacyChannelIds);
    expect(deletedIds, isNot(contains('eew_forecast')));
    expect(deletedIds, isNot(contains('bgl_debug')));
  });

  test('uses no-op platform outside Android', () async {
    final initializer = AndroidNotificationChannelInitializer.forPlatform(
      targetPlatform: TargetPlatform.iOS,
      androidPlugin: null,
    );

    expect(initializer.platform, isA<NoopAndroidNotificationChannelPlatform>());
    await initializer.initialize();
  });

  test('rejects a missing Android plugin', () {
    expect(
      () => AndroidNotificationChannelInitializer.forPlatform(
        targetPlatform: TargetPlatform.android,
        androidPlugin: null,
      ),
      throwsStateError,
    );
  });
}

const _deletedLegacyChannelIds = [
  'fromdev',
  'eew_warning',
  'eew_low_accuracy',
  'VXSE51',
  'VXSE52',
  'VXSE53',
  'VXSE61',
  'VXSE62',
  'VZSE40',
  'VYSE50',
  'VYSE51',
  'VYSE52',
  'test',
  'test_critical',
];

class _RecordingAndroidNotificationChannelPlatform
    implements AndroidNotificationChannelPlatform {
  final operations = <String>[];

  @override
  Future<void> createChannel(AndroidNotificationChannel channel) async {
    operations.add('channel:${channel.id}');
  }

  @override
  Future<void> createGroup(AndroidNotificationChannelGroup group) async {
    operations.add('group:${group.id}');
  }

  @override
  Future<void> deleteChannel(String id) async {
    operations.add('delete:$id');
  }
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
