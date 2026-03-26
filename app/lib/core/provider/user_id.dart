import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id.g.dart';

/// User IDを提供するProvider
@Riverpod(keepAlive: true)
class UserId extends _$UserId {
  @override
  Future<String?> build() async {
    final ds = await ref.watch(securePreferencesDataSourceProvider.future);
    return ds.getString(key: SecureStorageKey.userId);
  }

  /// User IDを保存
  Future<void> save(String userId) async {
    final ds = await ref.watch(securePreferencesDataSourceProvider.future);
    await ds.setString(key: SecureStorageKey.userId, value: userId);
    state = AsyncValue.data(userId);
  }

  /// User IDを削除
  Future<void> clear() async {
    final ds = await ref.watch(securePreferencesDataSourceProvider.future);
    await ds.remove(key: SecureStorageKey.userId);
    state = const AsyncValue.data(null);
  }
}
