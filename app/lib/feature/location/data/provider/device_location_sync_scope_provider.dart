import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_sync_scope_provider.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceLocationSyncScope> deviceLocationSyncScope(Ref ref) async {
  final apiBaseUrl = (await ref.watch(telegramUrlProvider.future)).restApiUrl;
  return DeviceLocationSyncScope.fromApiBaseUrl(apiBaseUrl: apiBaseUrl);
}
