import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';
part 'shake_detection_settings_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ShakeDetectionSettingsRepository> shakeDetectionSettingsRepository(
  Ref ref,
) async =>
    ShakeDetectionSettingsRepository(await ref.watch(apiClientProvider.future));

class ShakeDetectionSettingsRepository(final api.ApiClient apiClient) {
  final Lock _lock = Lock(reentrant: true);

  /// サーバー側の通知条件をすべて無効にする。
  ///
  /// 無効であることを確認できた場合だけ true を返す。途中で [isCurrent] が
  /// false になり確認を打ち切った場合は false。
  Future<bool> disableNotifications({required bool Function() isCurrent}) =>
      _lock.synchronized(() async {
        if (!isCurrent()) return false;
        final current = await load();
        if (!isCurrent()) return false;
        if (current.entries.any((entry) => entry.enabled)) {
          await save([
            for (final entry in current.entries) entry.copyWith(enabled: false),
          ]);
        }
        return true;
      });

  Future<ShakeDetectionState> load() => _lock.synchronized(() async {
    final response = await apiClient.device
        .getV2DeviceMeSettingsShakeDetection();
    return (
      entries: response.data.settings.map((e) => e.toModel()).toList(),
      requiresReconfiguration: response.data.requiresReconfiguration,
    );
  });

  Future<ShakeDetectionState> save(
    List<ShakeDetectionEntry> entries, {
    bool Function()? isCurrent,
  }) => _lock.synchronized(() async {
    if (isCurrent?.call() == false) {
      throw StateError('Shake notification settings changed while waiting');
    }
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: entries.map((e) => e.toApiRequest()).toList(),
    );
    return (
      entries: response.data.settings.map((e) => e.toModel()).toList(),
      requiresReconfiguration: response.data.requiresReconfiguration,
    );
  });
}
