import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_menu_availability_provider.g.dart';

@Riverpod(keepAlive: true)
bool isDebugMenuAvailable(Ref ref) {
  final role = ref.watch(deviceRoleProvider).value;
  final buildConfig = ref.watch(buildConfigProvider);
  final isDebugEnabled = ref.watch(debugProvider).value ?? false;

  if (kDebugMode) {
    return true;
  }
  if (role == DeviceRole.admin) {
    return true;
  }
  if (!buildConfig.isDeveloperUiEnabled) {
    return false;
  }
  return buildConfig.isBetaTesting || isDebugEnabled;
}
