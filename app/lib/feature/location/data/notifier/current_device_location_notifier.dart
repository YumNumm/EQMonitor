import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/provider/device_location_sync_scope_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/foreground_device_location_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_device_location_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentDeviceLocation extends _$CurrentDeviceLocation {
  @override
  Future<DeviceLocationPayload?> build() async {
    await ref.watch(deviceLocationSyncScopeProvider.future);
    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) ref.invalidateSelf();
    });
    return ref.watch(foregroundDeviceLocationRepositoryProvider).readLastSent();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      ref.read(foregroundDeviceLocationRepositoryProvider).sync,
    );
  }
}
