import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workflows/workflows.dart';

part 'device_provisioning_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceProvisioningRepository> deviceProvisioningRepository(
  Ref ref,
) async {
  final dataSource = await ref.watch(
    sharedPreferencesDataSourceProvider.future,
  );
  final prefs = await ref.watch(data_prefs.sharedPreferencesProvider.future);
  return DeviceProvisioningRepository(
    dataSource: dataSource,
    persistence: SharedPreferencesWorkflowPersistence(
      SharedPreferencesAsync(prefs),
    ),
  );
}

class DeviceProvisioningRepository {
  new({
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
}
