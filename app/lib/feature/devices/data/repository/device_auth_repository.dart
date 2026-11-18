import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_role_cache_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/push_token_sync_state_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_cache_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/shake_detection_disable_confirmation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceAuthRepository> deviceAuthRepository(Ref ref) async {
  final pushTokenSyncState = await ref.watch(
    pushTokenSyncStateRepositoryProvider.future,
  );
  final locationSyncState = ref.watch(
    deviceLocationSyncStateRepositoryProvider,
  );
  final roleCache = ref.watch(deviceRoleCacheRepositoryProvider);
  final slotCache = ref.watch(notificationSlotCacheRepositoryProvider);
  final shakeDisableConfirmation = ref.watch(
    shakeDetectionDisableConfirmationRepositoryProvider,
  );
  return DeviceAuthRepository(
    await ref.watch(securePreferencesDataSourceProvider.future),
    onCredentialsWillChange: () async {
      await locationSyncState.clearLastSent();
      await pushTokenSyncState.clearAll();
      await roleCache.clear();
      await slotCache.clear();
      await shakeDisableConfirmation.clear();
    },
    onCredentialsChanged: () => ref.invalidate(deviceIdProvider),
  );
}

/// 端末の資格情報（サーバー発行の JWT）を secure storage へ保存する。
///
/// トークンは端末 ID・認証ヘッダーのために全リクエストで参照されるため、
/// 読み取れたトークンをメモリに保持する。保存・削除はこのクラスを通し、保持した
/// 値を必ず入れ替える。secure storage を直接書き換えた場合は
/// [forgetCachedToken] を呼ぶ。
///
/// 「保存なし」は保持しない。端末のロック中など一時的に読めない状態を、
/// プロセスが終わるまで未登録として扱い続けないためである。
class DeviceAuthRepository(
  final PreferencesDataSource<SecureStorageKey> _preferences, {
  final Future<void> Function()? onCredentialsWillChange,
  final void Function()? onCredentialsChanged,
}) {
  String? _token;
  Future<String?>? _pendingRead;
  var _generation = 0;

  Future<String?> readToken() {
    final token = _token;
    if (token != null) {
      return Future.value(token);
    }
    return _pendingRead ??= loadToken(generation: _generation);
  }

  /// secure storage から読み取り、有効なトークンだけを保持する。
  ///
  /// 読み取り中に保存・削除があった場合（[generation] が古い場合）は保持しない。
  Future<String?> loadToken({required int generation}) async {
    try {
      final token = await _preferences.getString(
        key: SecureStorageKey.deviceToken,
      );
      if (generation == _generation && token != null && token.isNotEmpty) {
        _token = token;
      }
      return token;
    } finally {
      if (generation == _generation) {
        _pendingRead = null;
      }
    }
  }

  void forgetCachedToken() {
    _generation++;
    _token = null;
    _pendingRead = null;
  }

  Future<void> saveToken({required String token}) async {
    await onCredentialsWillChange?.call();
    // 書き込みに失敗した場合に、古い値を返し続けない。
    forgetCachedToken();
    await _preferences.setString(
      key: SecureStorageKey.deviceToken,
      value: token,
    );
    forgetCachedToken();
    _token = token;
    onCredentialsChanged?.call();
  }

  Future<void> clearToken() async {
    await onCredentialsWillChange?.call();
    forgetCachedToken();
    await _preferences.remove(key: SecureStorageKey.deviceToken);
    forgetCachedToken();
    onCredentialsChanged?.call();
  }
}
