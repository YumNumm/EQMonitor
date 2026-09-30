import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_custom_snapshot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_sound_operation_coordinator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_custom_snapshot_repository.g.dart';

@Riverpod(keepAlive: true)
Future<NotificationCustomSnapshotRepository>
notificationCustomSnapshotRepository(
  Ref ref,
) async {
  final dataSource = await ref.watch(
    sharedPreferencesDataSourceProvider.future,
  );
  return NotificationCustomSnapshotRepository(
    dataSource,
    soundCoordinator: ref.watch(notificationSoundOperationCoordinatorProvider),
  );
}

class NotificationCustomSnapshotRepository {
  new(
    this._dataSource, {
    NotificationSoundOperationCoordinator? soundCoordinator,
  }) : _soundCoordinator =
           soundCoordinator ?? NotificationSoundOperationCoordinator();

  final SharedPreferencesDataSource _dataSource;
  final NotificationSoundOperationCoordinator _soundCoordinator;

  Future<void> save(NotificationCustomSnapshot snapshot) =>
      _soundCoordinator.run(
        () => _dataSource.setString(
          key: SharedPreferencesKey.notificationCustomSnapshot,
          value: jsonEncode(snapshot.toJson()),
        ),
      );

  /// スキーマ不一致・パース失敗時は null を返し、呼び出し側でフォールバックする。
  Future<NotificationCustomSnapshot?> load({bool requireValid = false}) async {
    final raw = await _dataSource.getString(
      key: SharedPreferencesKey.notificationCustomSnapshot,
    );
    if (raw == null) {
      return null;
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final snapshot = NotificationCustomSnapshot.fromJson(json);
      if (snapshot.schemaVersion != notificationCustomSnapshotSchemaVersion) {
        if (requireValid)
          throw const FormatException('Notification snapshot schema mismatch');
        return null;
      }
      return snapshot;
    } on Object catch (e, st) {
      talker.error('[NotificationCustomSnapshot] load failed', e, st);
      if (requireValid) rethrow;
      return null;
    }
  }

  Future<void> clear() =>
      _dataSource.remove(key: SharedPreferencesKey.notificationCustomSnapshot);
}
