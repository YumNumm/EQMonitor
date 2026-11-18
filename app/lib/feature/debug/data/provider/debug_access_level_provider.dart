import 'package:eqmonitor/feature/debug/data/logic/debug_access_level_resolver.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_access_level_provider.g.dart';

@Riverpod(keepAlive: true)
DebugAccessLevel debugAccessLevel(Ref ref) => ref
    .watch(debugAccessLevelResolverProvider)
    .resolve(
      isDebugEnabled: ref.watch(debugProvider).value ?? false,
      role: ref.watch(deviceRoleProvider).value,
    );
