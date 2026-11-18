import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/stored_notification_slots.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slot_cache_repository.g.dart';

@Riverpod(keepAlive: true)
NotificationSlotCacheRepository notificationSlotCacheRepository(Ref ref) =>
    NotificationSlotCacheRepository(
      dataSource: () => ref.read(sharedPreferencesDataSourceProvider.future),
    );

/// 通知スロット一覧の前回値を端末に保存する。
///
/// 起動時にサーバーの応答を待たずに進めるための保存で、正本はサーバー。
/// 読み書きの失敗は通常の取得へ縮退させるため、例外を外へ出さない。
class const NotificationSlotCacheRepository({
  required final Future<SharedPreferencesDataSource> Function() dataSource,
}) {
  Future<List<NotificationSlot>?> read() async {
    try {
      final source = await (await dataSource()).getString(
        key: SharedPreferencesKey.notificationSlotsCache,
      );
      if (source == null) {
        return null;
      }
      final decoded = jsonDecode(source);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      return StoredNotificationSlots.fromJson(decoded).slots;
    } on Object catch (error, stackTrace) {
      log(
        'failed to read notification slots',
        name: 'NotificationSlotCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> write(List<NotificationSlot> slots) async {
    try {
      await (await dataSource()).setString(
        key: SharedPreferencesKey.notificationSlotsCache,
        value: jsonEncode(StoredNotificationSlots(slots: slots).toJson()),
      );
    } on Object catch (error, stackTrace) {
      log(
        'failed to write notification slots',
        name: 'NotificationSlotCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> clear() async {
    try {
      await (await dataSource()).remove(
        key: SharedPreferencesKey.notificationSlotsCache,
      );
    } on Object catch (error, stackTrace) {
      log(
        'failed to clear notification slots',
        name: 'NotificationSlotCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
