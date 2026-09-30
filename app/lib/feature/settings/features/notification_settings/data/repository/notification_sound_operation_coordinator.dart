import 'dart:async';

import 'package:eqmonitor/feature/settings/features/notification_settings/data/data_source/notification_sound_data_source.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_operation_coordinator.g.dart';

@Riverpod(keepAlive: true)
NotificationSoundOperationCoordinator notificationSoundOperationCoordinator(
  Ref ref,
) => NotificationSoundOperationCoordinator(
  dataSource: ref.watch(notificationSoundDataSourceProvider),
);

/// Serializes deletion with settings writes, including preset restoration.
class NotificationSoundOperationCoordinator {
  new({NotificationSoundDataSource? dataSource}) : _dataSource = dataSource;

  final NotificationSoundDataSource? _dataSource;
  Future<void> _tail = Future<void>.value();
  final Map<String, int> _reservations = {};

  void reserve(String fileName) =>
      _reservations.update(fileName, (value) => value + 1, ifAbsent: () => 1);

  void release(String fileName) {
    final count = _reservations[fileName];
    if (count == null) return;
    if (count == 1) {
      _reservations.remove(fileName);
    } else {
      _reservations[fileName] = count - 1;
    }
  }

  bool isReserved(String fileName) => _reservations.containsKey(fileName);

  Future<T> run<T>(
    Future<T> Function() operation, {
    Iterable<String> soundNames = const [],
  }) async {
    final previous = _tail;
    final finished = Completer<void>();
    _tail = finished.future;
    await previous;
    try {
      final customNames = soundNames
          .where((name) => name.startsWith('eqm_custom_'))
          .toSet();
      final dataSource = _dataSource;
      if (customNames.isNotEmpty && dataSource != null) {
        final catalog = NotificationSoundCatalog.fromJson(
          await dataSource.read('list'),
        );
        final available = catalog.sounds
            .where((sound) => sound.isAvailable)
            .map((sound) => sound.fileName)
            .toSet();
        if (!available.containsAll(customNames)) {
          throw const NotificationSoundException(.sourceUnavailable);
        }
      }
      return await operation();
    } finally {
      finished.complete();
    }
  }
}
