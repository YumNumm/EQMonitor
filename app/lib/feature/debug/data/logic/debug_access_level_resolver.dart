import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_access_level_resolver.g.dart';

@riverpod
DebugAccessLevelResolver debugAccessLevelResolver(Ref ref) =>
    const DebugAccessLevelResolver();

class const DebugAccessLevelResolver() {
  DebugAccessLevel resolve({
    required bool isDebugEnabled,
    required DeviceRole? role,
  }) {
    if (!isDebugEnabled) {
      return DebugAccessLevel.none;
    }
    if (role == DeviceRole.admin) {
      return DebugAccessLevel.full;
    }
    return DebugAccessLevel.restricted;
  }
}
