import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_menu_availability_resolver.g.dart';

@riverpod
DebugMenuAvailabilityResolver debugMenuAvailabilityResolver(Ref ref) =>
    const DebugMenuAvailabilityResolver();

class const DebugMenuAvailabilityResolver() {
  bool resolve({
    required bool isDebugBuild,
    required DeviceRole? role,
    required BuildConfig buildConfig,
    required bool isDebugEnabled,
  }) {
    if (isDebugBuild) {
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
}
