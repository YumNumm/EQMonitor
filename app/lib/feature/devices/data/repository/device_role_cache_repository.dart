import 'dart:developer';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_role_cache_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceRoleCacheRepository deviceRoleCacheRepository(Ref ref) =>
    DeviceRoleCacheRepository(
      dataSource: () => ref.read(sharedPreferencesDataSourceProvider.future),
    );

/// 最後にサーバーから取得できたデバイスのロールを端末に保存する。
///
/// 保存値がない・読めない場合は null を返す。権限判定に使うため、
/// 読み取り失敗を Admin へ補完しない。
class const DeviceRoleCacheRepository({
  required final Future<SharedPreferencesDataSource> Function() dataSource,
}) {
  Future<DeviceRole?> read() async {
    try {
      final value = await (await dataSource()).getString(
        key: SharedPreferencesKey.deviceRole,
      );
      return DeviceRole.values.where((role) => role.value == value).firstOrNull;
    } on Object catch (error, stackTrace) {
      log(
        'failed to read device role',
        name: 'DeviceRoleCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> write(DeviceRole role) async {
    try {
      await (await dataSource()).setString(
        key: SharedPreferencesKey.deviceRole,
        value: role.value,
      );
    } on Object catch (error, stackTrace) {
      log(
        'failed to write device role',
        name: 'DeviceRoleCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> clear() async {
    try {
      await (await dataSource()).remove(key: SharedPreferencesKey.deviceRole);
    } on Object catch (error, stackTrace) {
      log(
        'failed to clear device role',
        name: 'DeviceRoleCacheRepository',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
