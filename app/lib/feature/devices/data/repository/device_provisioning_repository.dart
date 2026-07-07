import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
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
Future<DeviceProvisioningRepository> deviceProvisioningRepository(
  Ref ref,
) async {
  final dataSource = await ref.watch(sharedPreferencesDataSourceProvider.future);
  final prefs = await ref.watch(data_prefs.sharedPreferencesProvider.future);
  return DeviceProvisioningRepository(
    dataSource: dataSource,
    persistence: SharedPreferencesWorkflowPersistence(
      SharedPreferencesAsync(prefs),
    ),
  );
}

class DeviceProvisioningRepository {
  DeviceProvisioningRepository({
    required SharedPreferencesDataSource dataSource,
    required SharedPreferencesWorkflowPersistence persistence,
  }) : _dataSource = dataSource,
       _persistence = persistence;

  final SharedPreferencesDataSource _dataSource;
  final SharedPreferencesWorkflowPersistence _persistence;

  Future<bool> isProvisioned() async =>
      await _dataSource.getBool(key: SharedPreferencesKey.deviceProvisioned) ??
      false;

  Future<void> markProvisioned() => _dataSource.setBool(
    key: SharedPreferencesKey.deviceProvisioned,
    value: true,
  );

  Future<void> clearProvisioned() => _dataSource.setBool(
    key: SharedPreferencesKey.deviceProvisioned,
    value: false,
  );

  Future<String?> readLegacyDeviceId() =>
      _dataSource.getString(key: SharedPreferencesKey.legacyDeviceId);

  Future<bool> wasMigratedFromLegacy() async =>
      await _dataSource.getBool(
        key: SharedPreferencesKey.deviceMigratedFromLegacy,
      ) ??
      false;

  Future<void> markMigratedFromLegacy() => _dataSource.setBool(
    key: SharedPreferencesKey.deviceMigratedFromLegacy,
    value: true,
  );

  WorkflowRunner buildRunner() => WorkflowRunner(persistence: _persistence);

  /// 現在のトークンと保存済みハッシュを比較して同期スナップショットを返す。
  Future<PushTokenSyncSnapshot> computeSnapshot(
    NotificationToken? token, {
    required bool apnsSupported,
  }) async {
    return PushTokenSyncSnapshot(
      fcm: await _computeKindState(PushTokenKind.fcm, token?.fcmToken),
      apnsNotification: apnsSupported
          ? await _computeKindState(
              PushTokenKind.apnsNotification,
              token?.apnsToken,
            )
          : const NotApplicableTokenState(),
      apnsPushToStart: apnsSupported
          ? await _computeKindState(
              PushTokenKind.apnsPushToStart,
              token?.apnsPushToStartToken,
            )
          : const NotApplicableTokenState(),
    );
  }

  Future<PushTokenKindState> _computeKindState(
    PushTokenKind kind,
    String? token,
  ) async {
    if (token == null || token.isEmpty) {
      return const AbsentTokenState();
    }
    final stored = await _loadHash(kind);
    final current = _computeHash(kind, token);
    if (stored == current) {
      return const SyncedTokenState();
    }
    return const PendingTokenState();
  }

  Future<String?> _loadHash(PushTokenKind kind) =>
      _dataSource.getString(key: _hashKey(kind));

  Future<void> saveTokenHash(PushTokenKind kind, String token) {
    final hash = _computeHash(kind, token);
    return _dataSource.setString(key: _hashKey(kind), value: hash);
  }

  String _computeHash(PushTokenKind kind, String token) {
    const env = kDebugMode ? 'dev' : 'prod';
    final input = '${kind.name}|$env|$token';
    return sha256.convert(utf8.encode(input)).toString();
  }

  SharedPreferencesKey _hashKey(PushTokenKind kind) => switch (kind) {
    PushTokenKind.fcm => SharedPreferencesKey.lastFcmTokenHash,
    PushTokenKind.apnsNotification => SharedPreferencesKey.lastApnsTokenHash,
    PushTokenKind.apnsPushToStart =>
      SharedPreferencesKey.lastApnsPushToStartTokenHash,
  };
}
