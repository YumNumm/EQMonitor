import 'package:eqmonitor/core/provider/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id.g.dart';

const _userIdKey = 'user_id';

/// User IDを提供するProvider
@Riverpod(keepAlive: true)
class UserId extends _$UserId {
  @override
  Future<String?> build() async {
    final storage = ref.watch(secureStorageProvider);
    return storage.read(key: _userIdKey);
  }

  /// User IDを保存
  Future<void> save(String userId) async {
    final storage = ref.watch(secureStorageProvider);
    await storage.write(key: _userIdKey, value: userId);
    state = AsyncValue.data(userId);
  }

  /// User IDを削除
  Future<void> clear() async {
    final storage = ref.watch(secureStorageProvider);
    await storage.delete(key: _userIdKey);
    state = const AsyncValue.data(null);
  }
}
