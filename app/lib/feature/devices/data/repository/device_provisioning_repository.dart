import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workflows/workflows.dart';

part 'device_provisioning_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceProvisioningRepository deviceProvisioningRepository(Ref ref) =>
    DeviceProvisioningRepository(ref.watch(sharedPreferencesProvider));

class DeviceProvisioningRepository {
  DeviceProvisioningRepository(this._prefs)
    : _persistence = SharedPreferencesWorkflowPersistence(_prefs);

  final SharedPreferencesAsync _prefs;
  final SharedPreferencesWorkflowPersistence _persistence;

  bool isProvisioned() =>
      _prefs.getBool(SharedPreferencesKey.deviceProvisioned.key) ?? false;

  Future<void> markProvisioned() =>
      _prefs.setBool(SharedPreferencesKey.deviceProvisioned.key, true);

  Future<void> clearProvisioned() =>
      _prefs.setBool(SharedPreferencesKey.deviceProvisioned.key, false);

  String? readLegacyDeviceId() =>
      _prefs.getString(SharedPreferencesKey.legacyDeviceId.key);

  WorkflowRunner buildRunner() => WorkflowRunner(persistence: _persistence);

  /// 現在のトークンと保存済みハッシュを比較して同期スナップショットを返す。
  PushTokenSyncSnapshot computeSnapshot(NotificationToken? token) {
    return PushTokenSyncSnapshot(
      fcm: _computeKindState(
        PushTokenKind.fcm,
        token?.fcmToken,
      ),
      apnsNotification: _computeKindState(
        PushTokenKind.apnsNotification,
        token?.apnsToken,
      ),
      apnsPushToStart: _computeKindState(
        PushTokenKind.apnsPushToStart,
        token?.apnsPushToStartToken,
      ),
    );
  }

  PushTokenKindState _computeKindState(PushTokenKind kind, String? token) {
    if (token == null || token.isEmpty) {
      return const AbsentTokenState();
    }
    final stored = _loadHash(kind);
    final current = _computeHash(kind, token);
    if (stored == current) {
      return const SyncedTokenState();
    }
    return const PendingTokenState();
  }

  String? _loadHash(PushTokenKind kind) {
    final key = _hashKey(kind);
    return _prefs.getString(key);
  }

  Future<void> saveTokenHash(PushTokenKind kind, String token) {
    final hash = _computeHash(kind, token);
    return _prefs.setString(_hashKey(kind), hash);
  }

  String _computeHash(PushTokenKind kind, String token) {
    const env = kDebugMode ? 'dev' : 'prod';
    final input = '${kind.name}|$env|$token';
    return sha256.convert(utf8.encode(input)).toString();
  }

  String _hashKey(PushTokenKind kind) => switch (kind) {
    PushTokenKind.fcm => SharedPreferencesKey.lastFcmTokenHash.key,
    PushTokenKind.apnsNotification =>
      SharedPreferencesKey.lastApnsTokenHash.key,
    PushTokenKind.apnsPushToStart =>
      SharedPreferencesKey.lastApnsPushToStartTokenHash.key,
  };
}
