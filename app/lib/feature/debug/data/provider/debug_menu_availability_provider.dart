import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/debug/data/logic/debug_menu_availability_resolver.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_menu_availability_provider.g.dart';

@Riverpod(keepAlive: true)
bool isDebugMenuAvailable(Ref ref) => ref
    .watch(debugMenuAvailabilityResolverProvider)
    .resolve(
      isDebugBuild: kDebugMode,
      role: ref.watch(deviceRoleProvider).value,
      buildConfig: ref.watch(buildConfigProvider),
      isDebugEnabled: ref.watch(debugProvider).value ?? false,
    );
