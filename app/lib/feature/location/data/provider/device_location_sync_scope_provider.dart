import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_registration_generation_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:riverpod/riverpod.dart';

final deviceLocationSyncScopeProvider = FutureProvider<DeviceLocationSyncScope>(
  (ref) async {
    final apiBaseUrl = (await ref.watch(telegramUrlProvider.future)).restApiUrl;
    final registrationGeneration = await ref
        .watch(deviceRegistrationGenerationRepositoryProvider)
        .readOrCreate();
    return DeviceLocationSyncScope.fromApiBaseUrl(
      apiBaseUrl: apiBaseUrl,
      registrationGeneration: registrationGeneration,
    );
  },
);
