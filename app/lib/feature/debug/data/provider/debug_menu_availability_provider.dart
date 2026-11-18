import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_menu_availability_provider.g.dart';

@Riverpod(keepAlive: true)
bool isDebugMenuAvailable(Ref ref) =>
    ref.watch(debugAccessLevelProvider) != DebugAccessLevel.none;
