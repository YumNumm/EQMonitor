import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shake_detection_settings_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ShakeDetectionSettingsRepository> shakeDetectionSettingsRepository(
  Ref ref,
) async =>
    ShakeDetectionSettingsRepository(await ref.watch(apiClientProvider.future));

class const ShakeDetectionSettingsRepository(final api.ApiClient apiClient) {
  Future<ShakeDetectionState> load() async {
    final response = await apiClient.device
        .getV2DeviceMeSettingsShakeDetection();
    return (
      entries: response.data.settings.map((e) => e.toModel()).toList(),
      requiresReconfiguration: response.data.requiresReconfiguration,
    );
  }

  Future<ShakeDetectionState> save(List<ShakeDetectionEntry> entries) async {
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: entries.map((e) => e.toApiRequest()).toList(),
    );
    return (
      entries: response.data.settings.map((e) => e.toModel()).toList(),
      requiresReconfiguration: response.data.requiresReconfiguration,
    );
  }
}
